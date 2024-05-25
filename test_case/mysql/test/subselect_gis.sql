select City from t1 where (select
MBRintersects(ST_GeomFromText(ST_AsText(Location)),ST_GeomFromText('Polygon((2 50, 2.5
50, 2.5 47, 2 47, 2 50))'))=0);
drop table t1;
