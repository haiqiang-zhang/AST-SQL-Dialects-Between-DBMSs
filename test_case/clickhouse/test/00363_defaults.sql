SELECT * FROM prewhere_defaults PREWHERE x != 0 ORDER BY x;
ALTER TABLE prewhere_defaults ADD COLUMN y UInt16 DEFAULT x;
SELECT * FROM prewhere_defaults PREWHERE x != 0 ORDER BY x;
INSERT INTO prewhere_defaults (x) VALUES (2);
SELECT * FROM prewhere_defaults PREWHERE x != 0 ORDER BY x;
DROP TABLE prewhere_defaults;
