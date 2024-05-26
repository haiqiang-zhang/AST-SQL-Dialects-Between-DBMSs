SET max_parallel_maintenance_workers TO 4;
SET min_parallel_index_scan_size TO '128kB';
CREATE TABLE parallel_vacuum_table (a int) WITH (autovacuum_enabled = off);
INSERT INTO parallel_vacuum_table SELECT i from generate_series(1, 10000) i;
CREATE INDEX regular_sized_index ON parallel_vacuum_table(a);
CREATE INDEX typically_sized_index ON parallel_vacuum_table(a);
CREATE INDEX vacuum_in_leader_small_index ON parallel_vacuum_table((1));
