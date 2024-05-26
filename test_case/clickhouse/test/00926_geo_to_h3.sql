select geoToH3(37.63098076, 55.77922738, 15);
select geoToH3(lon, lat, resolution) AS k from table1 order by lat, lon, k;
select lat, lon, geoToH3(lon, lat, resolution) AS k from table1 order by lat, lon, k;
select geoToH3(lon, lat, resolution) AS k, count(*) from table1 group by k order by k;
DROP TABLE table1;
