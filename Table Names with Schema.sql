--SELECT sys.tables.name
--FROM   sys.extended_properties
--	JOIN sys.tables ON sys.extended_properties.major_id = Object_id(sys.tables.name)
--WHERE  sys.extended_properties.name = 'SupportingData'
--	AND sys.extended_properties.value = '0'

--SELECT sys.tables.name
--FROM   sys.extended_properties
--	JOIN sys.tables ON sys.extended_properties.major_id = Object_id(sys.tables.name)
--WHERE sys.extended_properties.name = 'SupportingData'
--	AND sys.extended_properties.value = '1'

--SELECT sys.tables.name
--FROM   sys.extended_properties
--	JOIN sys.tables ON sys.extended_properties.major_id = Object_id(sys.tables.name)
--WHERE  sys.extended_properties.name = 'SupportingData'

SELECT sys.schemas.name as theSchema, sys.tables.name
FROM sys.tables 
	join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
WHERE sys.tables.name not in 
	(SELECT sys.tables.name
	FROM sys.extended_properties
		JOIN sys.tables ON sys.extended_properties.major_id = Object_id(sys.tables.name)
	WHERE sys.extended_properties.name = 'SupportingData'
		AND sys.extended_properties.value = '1'
	)
order by sys.schemas.name, sys.tables.name

