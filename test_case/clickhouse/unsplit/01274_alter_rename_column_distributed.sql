set distributed_foreground_insert = 1;
DROP TABLE IF EXISTS visits;
DROP TABLE IF EXISTS visits_dist;
CREATE TABLE visits(StartDate Date, Name String) ENGINE MergeTree ORDER BY(StartDate);
ALTER TABLE visits RENAME COLUMN Name TO Name2;
DROP TABLE visits;
