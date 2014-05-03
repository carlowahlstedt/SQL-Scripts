--first query finds orphaned users and second query will fix them

--The output lists the users and corresponding security identifiers (SID) 
--in the current database that are not linked to any SQL Server login
sp_change_users_login @Action='Report';


--The following command relinks the server login account <login_name> 
--with the database user <database_user>. 
sp_change_users_login @Action='update_one', @UserNamePattern='<database_user>', @LoginName='<login_name>';
