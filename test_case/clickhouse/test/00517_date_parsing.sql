SELECT toDate(s) FROM (SELECT arrayJoin(['2017-01-02', '2017-1-02', '2017-01-2', '2017-1-2', '2017/01/02', '2017/1/02', '2017/01/2', '2017/1/2', '2017-11-12']) AS s);
DROP TABLE IF EXISTS date;
CREATE TABLE date (d Date) ENGINE = Memory;
INSERT INTO date VALUES ('2017-01-02'), ('2017-1-02'), ('2017-01-2'), ('2017-1-2'), ('2017/01/02'), ('2017/1/02'), ('2017/01/2'), ('2017/1/2'), ('2017-11-12');
SELECT * FROM date;
SELECT * FROM date ORDER BY d;
DROP TABLE date;
