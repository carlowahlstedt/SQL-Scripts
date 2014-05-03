
--First look at the list of SP that you're going to delete
--SELECT  sys.schemas.name + '.' + sys.procedures.name
--FROM    sys.procedures
--        JOIN sys.schemas ON sys.procedures.schema_id = sys.schemas.schema_id
--WHERE   sys.schemas.schema_id <> 1


--update the select in the cursor, then you can delete them
DECLARE @procedureName VARCHAR(500)
DECLARE cur CURSOR
FOR
SELECT  sys.schemas.name + '.' + sys.procedures.name AS name
FROM    sys.procedures
        JOIN sys.schemas ON sys.procedures.schema_id = sys.schemas.schema_id
WHERE   sys.schemas.schema_id <> 1
OPEN cur

FETCH NEXT FROM cur INTO @procedureName
WHILE @@fetch_status = 0 
    BEGIN
        EXEC('DROP PROCEDURE ' + @procedureName)
        FETCH NEXT FROM cur INTO @procedureName
    END
CLOSE cur
DEALLOCATE cur

