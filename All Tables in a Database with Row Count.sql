
declare @tabcnt int
declare @printline char (60)
select @tabcnt = count (*) from sysobjects where type = 'U'

If @tabcnt != 0
BEGIN
  select 'TABLE NAME'= convert (varchar (50), o.name), ROWS=i.rows
    from sysobjects o, sysindexes i
    where o.type = 'U'
      and o.id = i.id
      and i.indid in (0,1)
  order by o.name
END

select @printline = '(' + convert (varchar(10), @tabcnt) +
			' tables in ' + DB_NAME() + ')'

print ''
print @printline
GO
