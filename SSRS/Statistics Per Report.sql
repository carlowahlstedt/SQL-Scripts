USE ReportServer

--Statistics per report
SELECT	ReportPath,
		MAX(TimeProcessing) AS MaxTimeProcessing, MIN(TimeProcessing) AS MinTimeProcessing, SUM(TimeProcessing) AS TotalTimeProcessing, AVG(TimeProcessing) AS AverageTimeProcessing, 
		MAX(TimeDataRetrieval) AS MaxTimeDataRetrieval, MIN(TimeDataRetrieval) AS MinTimeDataRetrieval, SUM(TimeDataRetrieval) AS TotalTimeDataRetrieval, AVG(TimeDataRetrieval) AS AverageTimeDataRetrieval, 
		MAX(TimeRendering) AS MaxTimeRendering, MIN(TimeRendering) AS MinTimeRendering, SUM(TimeRendering) AS TotalTimeRendering, AVG(TimeRendering) AS AverageTimeRendering
FROM [ReportServer].[dbo].[ExecutionLog2]
GROUP BY ReportPath
ORDER BY ReportPath

