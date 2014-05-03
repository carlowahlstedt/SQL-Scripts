
SELECT TOP 20
        qs.execution_count,
        qs.total_worker_time AS Total_CPU,
        total_CPU_inSeconds = qs.total_worker_time/1000000, --Converted from microseconds
        average_CPU_inSeconds = (qs.total_worker_time/1000000)/qs.execution_count, --Converted from microseconds
        qs.total_elapsed_time,
        total_elapsed_time_inSeconds = qs.total_elapsed_time/1000000, --Converted from microseconds
        text,
        qp.query_plan
FROM    sys.dm_exec_query_stats AS qs
        CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) ASst
        CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
ORDER BY qs.total_worker_time DESC



SELECT TOP 20
            DB_Name(st.dbid),
        qs.execution_count,
        qs.total_worker_time AS Total_CPU,
        total_CPU_inSeconds = qs.total_worker_time/1000000, --Converted from microseconds
        average_CPU_inSeconds = (qs.total_worker_time/1000000)/qs.execution_count, --Converted from microseconds
        qs.total_elapsed_time,
        total_elapsed_time_inSeconds = qs.total_elapsed_time/1000000, --Converted from microseconds
        text,
        qp.query_plan
FROM    sys.dm_exec_query_stats AS qs
        CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
        CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
ORDER BY qs.total_worker_time DESC
