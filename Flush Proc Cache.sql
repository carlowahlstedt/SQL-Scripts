--To get the database id for a particular database ---
Select DB_ID('[DatabaseName]')  --i.e. Tickler

--Then reset the proc cache
DBCC FLUSHPROCINDB (DB_ID('[DatabaseName]')) WITH NO_INFOMSGS;

