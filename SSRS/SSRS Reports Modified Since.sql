SELECT Path, Name, CreatedByUser.UserName AS CreatedBy, ModifiedByUser.UserName AS ModifiedBy, Catalog.CreationDate, Catalog.ModifiedDate
  FROM [ReportServer].[dbo].Catalog
		LEFT JOIN ReportServer.dbo.Users AS CreatedByUser ON ReportServer.dbo.Catalog.CreatedByID = CreatedByUser.UserID
		LEFT JOIN ReportServer.dbo.Users AS ModifiedByUser ON ReportServer.dbo.Catalog.ModifiedByID = ModifiedByUser.UserID
  WHERE CreationDate >= '1/19/2012'
		OR ModifiedDate >= '1/19/2012'
  ORDER BY ModifiedDate DESC
  
  