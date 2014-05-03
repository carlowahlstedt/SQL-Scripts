SET STATISTICS IO OFF

-- Build the set single_user/drop connections command (ONLINE, non-system databases only): 
SELECT DISTINCT'ALTER DATABASE [' + DB_NAME(dbid) + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;' 
FROM master.dbo.sysaltfiles 
WHERE DATABASEPROPERTYEX( DB_NAME(dbid) , 'Status' ) = 'ONLINE' 
AND DB_NAME(dbid) NOT IN ('master','tempdb','msdb','model') 
GO

-- Build the sp_detach_db command (ONLINE, non-system databases only): 
SELECT DISTINCT'exec sp_detach_db [' + DB_NAME(dbid) + '];' 
FROM master.dbo.sysaltfiles 
WHERE DATABASEPROPERTYEX( DB_NAME(dbid) , 'Status' ) = 'ONLINE' 
AND DB_NAME(dbid) NOT IN ('master','tempdb','msdb','model') 
GO

-- Build the sp_attach_db: 
SET NOCOUNT ON  
DECLARE     @cmd        VARCHAR(MAX), 
            @dbname     VARCHAR(MAX), 
            @prevdbname VARCHAR(MAX) 

SELECT @cmd = '', @dbname = ';', @prevdbname = '' 

CREATE TABLE #Attach 
    (Seq        INT IDENTITY(1,1) PRIMARY KEY, 
     dbname     SYSNAME NULL, 
     fileid     INT NULL, 
     filename   VARCHAR(MAX) NULL, 
     TxtAttach  VARCHAR(MAX) NULL 
) 

INSERT INTO #Attach 
SELECT DISTINCT DB_NAME(dbid) AS dbname, fileid, filename, CONVERT(VARCHAR(MAX),'') AS TxtAttach 
FROM master.dbo.sysaltfiles 
WHERE dbid IN (SELECT dbid FROM master.dbo.sysaltfiles) 
            AND DATABASEPROPERTYEX( DB_NAME(dbid) , 'Status' ) = 'ONLINE' 
            AND DB_NAME(dbid) NOT IN ('master','tempdb','msdb','model') 
ORDER BY dbname, fileid, filename 

UPDATE #Attach 
SET @cmd = TxtAttach =   
            CASE WHEN dbname <> @prevdbname  
            THEN CONVERT(VARCHAR(MAX),'exec sp_attach_db @dbname = N''' + CONVERT(VARCHAR(MAX),dbname) + '''') 
            ELSE @cmd 
            END +',@filename' + CONVERT(VARCHAR(MAX),fileid) + '=N''' + CONVERT(VARCHAR(MAX),filename) +'''', 
    @prevdbname = CASE WHEN dbname <> @prevdbname THEN dbname ELSE @prevdbname END, 
    @dbname = dbname 
FROM #Attach 

SELECT TxtAttach 
FROM 
(SELECT dbname, MAX(TxtAttach) AS TxtAttach FROM #Attach  
 GROUP BY dbname) AS x 

DROP TABLE #Attach 
GO 