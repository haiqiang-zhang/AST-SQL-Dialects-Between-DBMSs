SELECT sql FROM sqlite_schema;
PRAGMA writable_schema = 1;
UPDATE sqlite_schema SET sql = 'CREATE TABLE t2 syntax error!' WHERE name='t2';
SELECT sql FROM sqlite_schema;
SELECT sql FROM sqlite_schema;
