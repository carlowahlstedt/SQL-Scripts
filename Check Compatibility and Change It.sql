
--SQL 2005
SELECT * 
FROM sys.databases 
WHERE compatibility_level = 80
	AND state_desc = 'online'
ORDER BY name


--SQL 2008r2
--ALTER DATABASE [DatabaseName]
--SET COMPATIBILITY_LEVEL = 90;
--GO


--Set Compatibility Level
EXEC sp_dbcmptlevel [DatabaseName], 90;
GO

