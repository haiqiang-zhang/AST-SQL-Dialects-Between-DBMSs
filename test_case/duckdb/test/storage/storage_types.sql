SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_interval;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_interval WHERE i=interval 1 year;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_bool;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_bool WHERE not i;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_interval;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_interval WHERE i=interval 1 year;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_bool;
SELECT MIN(i), MAX(i), COUNT(*), COUNT(i) FROM a_bool WHERE not i;
