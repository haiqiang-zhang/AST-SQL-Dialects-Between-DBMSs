
--
-- This is a regression test for bug #2526 "--init-file crashes MySQL if it
-- contains a large select"
--
-- See mysql-test/std_data/init_file.dat and
-- mysql-test/t/init_file-master.opt for the actual test
--

--
-- Bug#23240 --init-file statements with NOW() reports '1970-01-01 11:00:00'as the date time
--
INSERT INTO init_file.startup VALUES ( NOW() );
SELECT * INTO @X FROM init_file.startup limit 0,1;
SELECT * INTO @Y FROM init_file.startup limit 1,1;
SELECT YEAR(@X)-YEAR(@Y);
DROP DATABASE init_file;
--   3, 5, 7, 11, 13 
select * from t1;
--   30, 3, 11, 13
select * from t2;
drop table t1, t2;