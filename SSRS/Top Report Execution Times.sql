USE ReportServer

--Top report execution times
SELECT TOP 100 *, (TimeEnd-TimeStart)
FROM [ReportServer].[dbo].[ExecutionLog2]
ORDER BY TimeProcessing DESC

