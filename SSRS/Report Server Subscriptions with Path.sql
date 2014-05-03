
SELECT  InactiveFlags,
		UserName,
        dbo.Catalog.Description,
        LastStatus,
        LastRunTime,
        Path,
        ExtensionSettings
FROM    dbo.Subscriptions
        JOIN dbo.Catalog ON dbo.Subscriptions.Report_OID = dbo.Catalog.ItemID
		JOIN dbo.Users ON dbo.Subscriptions.OwnerID = dbo.Users.UserID
ORDER BY UserName, InactiveFlags
