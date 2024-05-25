PRAGMA default_collation='NOCASE';
CREATE TABLE collate_test(s VARCHAR);
INSERT INTO collate_test VALUES ('hEllO'), ('WÃÂÃÂÃÂÃÂ¶RlD'), ('wozld');
PRAGMA default_collation='NOCASE.NOACCENT';
SELECT COUNT(*) FROM collate_test WHERE 'BlA'='bLa';
SELECT * FROM collate_test WHERE s='hello';
SELECT * FROM collate_test ORDER BY s;
SELECT * FROM collate_test ORDER BY s;
