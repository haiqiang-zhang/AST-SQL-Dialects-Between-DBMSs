RENAME TABLE 02265_ordinary_db.join_table TO 02265_atomic_db.join_table;
SELECT * FROM 02265_atomic_db.join_table;
DROP DATABASE IF EXISTS 02265_atomic_db;
DROP DATABASE IF EXISTS 02265_ordinary_db;
