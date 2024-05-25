SELECT * FROM mt;
ALTER TABLE mt FREEZE;
SELECT * FROM mt;
SET mutations_sync = 1;
ALTER TABLE mt UPDATE x = 'Goodbye' WHERE y = 1;
SELECT * FROM mt;
DROP TABLE mt;
