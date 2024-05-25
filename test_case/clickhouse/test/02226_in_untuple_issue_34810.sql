SELECT * FROM calendar WHERE (year, month) IN ( SELECT (year, month) FROM events32 );
DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS events32;
