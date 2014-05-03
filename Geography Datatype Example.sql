/* NOTE: this is for SQL 2008 and greater only */
create table #location
(
	latitude float,
	longitude float,
	geocode geography null
)

insert into #location
values (47.455, -122.231, null)

insert into #location
values (42.372, -71.0298, null)

insert into #location
values (41.953, -87.643, null)

insert into #location
values (47.668, -117.529, null)

insert into #location
values (39.888, -75.251, null)

update #location
set geocode = geography::Point(latitude, longitude, 4326)

select latitude, geocode.Lat, longitude, geocode.Long, geocode from #location
