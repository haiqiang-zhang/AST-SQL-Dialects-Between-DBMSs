SELECT * FROM defaults;
ALTER TABLE defaults UPDATE n = 100 WHERE s = '1';
SELECT * FROM defaults;
SELECT count(*) FROM defaults;
ALTER TABLE defaults DELETE WHERE n = 100;
SELECT * FROM defaults;
SELECT count(*) FROM defaults;
DROP TABLE defaults;
