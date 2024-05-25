SET max_rows_to_read = 1;
SELECT count() FROM binary_op_mono1 WHERE toDate(i / 1000) = '2020-09-02';
SELECT count() FROM binary_op_mono2 WHERE 1000 / i = 100;
SELECT count() FROM binary_op_mono3 WHERE i + 1000 = 500;
SELECT count() FROM binary_op_mono4 WHERE 1000 + i = 500;
SELECT count() FROM binary_op_mono5 WHERE i - 1000 = 1234;
SELECT count() FROM binary_op_mono6 WHERE 1000 - i = 1234;
SELECT count() FROM binary_op_mono7 WHERE i / 1000.0 = 22.3;
SELECT count() FROM binary_op_mono8 WHERE 1000.0 / i = 33.4;
DROP TABLE IF EXISTS binary_op_mono1;
DROP TABLE IF EXISTS binary_op_mono2;
DROP TABLE IF EXISTS binary_op_mono3;
DROP TABLE IF EXISTS binary_op_mono4;
DROP TABLE IF EXISTS binary_op_mono5;
DROP TABLE IF EXISTS binary_op_mono6;
DROP TABLE IF EXISTS binary_op_mono7;
DROP TABLE IF EXISTS binary_op_mono8;
drop table if exists x;
create table x (i int, j int) engine MergeTree order by i / 10 settings index_granularity = 1;
insert into x values (10, 1), (20, 2), (30, 3), (40, 4);
set max_rows_to_read = 3;
select * from x where i > 30;
drop table x;
