USE ReportServer

--Report executions per day
SELECT CAST(CAST(MONTH(TimeStart) AS VARCHAR) + '/' + CAST(DAY(Timestart) AS VARCHAR) + '/' + CAST(YEAR(TimeStart) AS VARCHAR) AS DATETIME),
 ReportPath, COUNT(*) AS Executions, SUM(TimeProcessing) AS TotalTimeProcessing, SUM(TimeDataRetrieval) AS TotalTimeDataRetrieval, SUM(TimeRendering) AS TotalTimeRendering
FROM [ReportServer].[dbo].[ExecutionLog2]
GROUP BY YEAR(TimeStart), MONTH(TimeStart), DAY(Timestart), ReportPath
ORDER BY YEAR(TimeStart) DESC, MONTH(TimeStart) DESC, DAY(Timestart) DESC, COUNT(*) DESC

