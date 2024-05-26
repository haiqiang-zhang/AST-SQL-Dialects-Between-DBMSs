DROP TABLE IF EXISTS t1;
SELECT @@lc_time_names;
CREATE TABLE t1 (a DATE);
INSERT INTO t1 VALUES
('2006-01-01'),('2006-01-02'),('2006-01-03'),
('2006-01-04'),('2006-01-05'),('2006-01-06'),('2006-01-07');
SELECT a, date_format(a,'%a') as abday, dayname(a) as day FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (a DATE);
INSERT INTO t1 VALUES
('2006-01-01'),('2006-02-01'),('2006-03-01'),
('2006-04-01'),('2006-05-01'),('2006-06-01'),
('2006-07-01'),('2006-08-01'),('2006-09-01'),
('2006-10-01'),('2006-11-01'),('2006-12-01');
SELECT a, date_format(a,'%b') as abmon, monthname(a) as mon FROM t1 ORDER BY a;
SELECT format(123456.789, 3, 'el_GR');
DROP TABLE t1;
SELECT DATE_FORMAT('2001-01-01', '%w %a %W');
