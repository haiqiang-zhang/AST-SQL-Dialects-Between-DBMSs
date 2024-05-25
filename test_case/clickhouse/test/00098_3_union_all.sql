SELECT val FROM
(SELECT value AS val FROM data2013 WHERE name = 'Alice'
UNION /*comment*/ ALL
SELECT value AS val FROM data2014 WHERE name = 'Alice')
ORDER BY val ASC;
DROP TABLE data2013;
DROP TABLE data2014;
