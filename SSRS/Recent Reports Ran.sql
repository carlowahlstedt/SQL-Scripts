USE ReportServer

--Recent reports ran
SELECT TOP 100 *, (TimeEnd-TimeStart)
FROM [ReportServer].[dbo].[ExecutionLog2]
ORDER BY TimeStart DESC

