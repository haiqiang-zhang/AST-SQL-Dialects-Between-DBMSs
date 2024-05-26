PRAGMA freelist_count;
CREATE TABLE abc(a, b, c);
PRAGMA freelist_count;
DROP TABLE abc;
PRAGMA freelist_count;
PRAGMA main.freelist_count;
