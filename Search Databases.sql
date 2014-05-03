/*
* sys.sql_modules would be recommended as INFORMATION_SCHEMA.ROUTINES has only first 8000 characters of sql code but sys.sql_modules stores full code
*/

--select definition from sys.sql_modules WHERE definition LIKE '%xp_sendmail%'
create table #tempmodules
(name varchar(8000))
 
INSERT INTO #tempmodules
EXEC sp_MSForEachDB 'SELECT definition from sys.sql_modules WHERE definition LIKE ''%xp_sendmail%'''
 
select distinct * from #tempmodules
drop table #tempmodules


-- SELECT TOP 100 ROUTINE_CATALOG, ROUTINE_SCHEMA, ROUTINE_NAME, ROUTINE_DEFINITION, ROUTINE_TYPE from INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_DEFINITION LIKE '%xp_sendmail%'
create table #tempschema
(DatabaseName varchar(250),
DatabaseSchema varchar(250),
RoutineName varchar(250),
RoutineType varchar(250),
)
 
INSERT INTO #tempschema
EXEC sp_MSForEachDB 'SELECT ROUTINE_CATALOG, ROUTINE_SCHEMA, ROUTINE_NAME, ROUTINE_TYPE from INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_DEFINITION LIKE ''%xp_sendmail%'''
 
select distinct * from #tempschema
drop table #tempschema
