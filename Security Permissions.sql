--these are all the users in the security folder of the gui for the whole database
SELECT  *
FROM    sys.server_principals
ORDER BY name

--these are all the users in the security folder of the gui for the given database
USE [DatabaseName]
SELECT  *
FROM    sys.database_principals
WHERE   type_desc != 'DATABASE_ROLE'
ORDER BY name

--these are the users assign to the given database and the role they are assigned to in that database
USE [DatabaseName]
SELECT  p.name,
        p.type_desc,
        pp.name,
        pp.type_desc,
        pp.is_fixed_role
FROM    sys.database_role_members roles
        JOIN sys.database_principals p ON roles.member_principal_id = p.principal_id
        JOIN sys.database_principals pp ON roles.role_principal_id = pp.principal_id
--WHERE p.type_desc = 'SQL_USER'
--WHERE p.type_desc = 'WINDOWS_USER'
ORDER BY p.type_desc, p.name


--all users for a given database that aren't orphaned
USE [DatabaseName]
SELECT  UserName = sys.database_principals.name,
        UserType = sys.database_principals.type_desc,
        LoginName = sys.server_principals.name,
        LoginType = sys.server_principals.type_desc
FROM    sys.database_principals
        JOIN sys.server_principals ON sys.database_principals.sid = sys.server_principals.sid
UNION ALL
SELECT  UserName = sys.database_principals.name,
        UserType = sys.database_principals.type_desc,
        LoginName = sys.server_principals.name,
        LoginType = sys.server_principals.type_desc
FROM    sys.database_principals
        JOIN sys.server_principals ON sys.database_principals.principal_id = sys.server_principals.principal_id


--all users for a given database that aren't orphaned and don't have matching login/user names
USE [DatabaseName]
SELECT  *
FROM    ( SELECT    UserName = sys.database_principals.name,
                    UserType = sys.database_principals.type_desc,
                    LoginName = sys.server_principals.name,
                    LoginType = sys.server_principals.type_desc
          FROM      sys.database_principals
                    JOIN sys.server_principals ON sys.database_principals.sid = sys.server_principals.sid
          UNION ALL
          SELECT    UserName = sys.database_principals.name,
                    UserType = sys.database_principals.type_desc,
                    LoginName = sys.server_principals.name,
                    LoginType = sys.server_principals.type_desc
          FROM      sys.database_principals
                    JOIN sys.server_principals ON sys.database_principals.principal_id = sys.server_principals.principal_id
        ) AS allUsers
WHERE   UserName != LoginName
ORDER BY usertype, logintype

