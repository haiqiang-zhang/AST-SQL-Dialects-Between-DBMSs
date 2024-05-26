SELECT * FROM child;
PRAGMA foreign_key_check;
INSERT INTO parent VALUES(123);
SELECT * FROM child;
PRAGMA foreign_key_check;
