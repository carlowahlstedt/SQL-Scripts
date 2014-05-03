--Gives the users and their access

--TODO: need to include the specific database that it accesses

SELECT  USER_NAME(p.grantee_principal_id) AS principal_name,
        dp.type_desc AS principal_type_desc,
        p.class_desc,
        OBJECT_NAME(p.major_id) AS object_name,
        p.permission_name,
        p.state_desc AS permission_state_desc,
        dp.*
FROM    sys.database_permissions p
        INNER   JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
--WHERE USER_NAME(p.grantee_principal_id) = 'kyhousing\jvivio'
ORDER BY principal_name, class_desc, object_name
