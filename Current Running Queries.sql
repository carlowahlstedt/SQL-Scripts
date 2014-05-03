SELECT	'THIS IS ME',
		DB_NAME(req.database_id) AS 'Database',
		req.session_id,
		sqltext.TEXT,
		req.session_id,
		req.status,
		req.command,
		req.total_elapsed_time,
		req.blocking_session_id,
		req.cpu_time,
		req.logical_reads,
		req.reads,
		req.writes,
		req.wait_resource,
		req.wait_time,
		req.wait_type
FROM	sys.dm_exec_requests req
		CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext
ORDER BY req.total_elapsed_time DESC


