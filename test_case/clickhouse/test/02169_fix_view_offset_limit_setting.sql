CREATE VIEW vcounter AS SELECT intDiv(id, 10) AS tens, max(createdAt) AS maxid FROM counter GROUP BY tens;
SELECT tens FROM vcounter ORDER BY tens ASC LIMIT 100 SETTINGS limit = 6, offset = 5;
SELECT tens FROM vcounter ORDER BY tens ASC LIMIT 100 SETTINGS limit = 6, offset = 0;
DROP TABLE vcounter;
DROP TABLE counter;
