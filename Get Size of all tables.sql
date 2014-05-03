DECLARE @tableName VARCHAR(2000) ; 
 
CREATE TABLE #AllTables
    (
      row_num INT IDENTITY(1, 1),
      schemaName VARCHAR(1000),
      table_name VARCHAR(1000)
    ) ;

--Using temp table, i dont like to use cursors
INSERT  INTO #AllTables
        ( schemaName,
          table_name
        )
        SELECT  sys.schemas.NAME,
                sys.Tables.[name]
        FROM    sys.Tables
                JOIN sys.schemas ON sys.tables.schema_id = sys.schemas.schema_id
        WHERE   sys.Tables.[schema_id] = 1 --Only dbo tables for the dbo schema


CREATE TABLE #TempTable
    (
      tableName VARCHAR(100),
      [rows] VARCHAR(100),
      reserved VARCHAR(50),
      data VARCHAR(50),
      index_size VARCHAR(50),
      unused VARCHAR(50)
    )

DECLARE @i INT
SET @i = 1 ;
DECLARE @tableCount INT 
SET @tableCount = ( SELECT  COUNT(1)
                    FROM    #AllTables
                  ) ;

--Loop to get all tables
WHILE ( @i <= @tableCount ) 
    BEGIN
        SELECT  @tableName = schemaName + '.' + table_name
        FROM    #AllTables
        WHERE   row_num = @i ;

      --Dump the results of the sp_spaceused query to the temp table
        INSERT  #TempTable
                EXEC sp_spaceused @tableName ;

        SET @i = @i + 1 ;
    END ;

--Select all records so we can use the reults
SELECT  *,
        CAST(ROUND(( CAST(REPLACE(data, ' KB', '') AS BIGINT) + CAST(REPLACE(index_size, ' KB', '') AS BIGINT) ) / ( CAST(rows AS MONEY) + 1 ), 2) AS VARCHAR(100))
        + ' KB' AvgRowSize,
        CAST(( CAST(REPLACE(data, ' KB', '') AS BIGINT) + CAST(REPLACE(index_size, ' KB', '') AS BIGINT) ) AS VARCHAR(100)) + ' KB' AS TotalTableSize
FROM    #TempTable
ORDER BY ( CAST(REPLACE(data, ' KB', '') AS BIGINT) + CAST(REPLACE(index_size, ' KB', '') AS BIGINT) ) DESC ;
 --total table size

--Final cleanup!
DROP TABLE #TempTable ;
DROP TABLE #Alltables ; 

