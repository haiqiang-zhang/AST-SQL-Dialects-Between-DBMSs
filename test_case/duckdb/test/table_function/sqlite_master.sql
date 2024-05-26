SELECT * FROM sqlite_master;
SELECT EXISTS(SELECT * FROM sqlite_master);
SELECT EXISTS(SELECT * FROM sqlite_master OFFSET 1);
SELECT COUNT(*) FROM sqlite_master WHERE name='test';
SELECT COUNT(*) FROM sqlite_master WHERE name='integers';
SELECT * FROM sqlite_master WHERE name='tconstraint1';
SELECT * FROM sqlite_master WHERE name='tconstraint2';
SELECT * REPLACE (trim(sql, chr(10)) as sql) FROM sqlite_master WHERE name='i_index';
SELECT "type", "name", "tbl_name", rootpage FROM sqlite_master WHERE name='v1';
