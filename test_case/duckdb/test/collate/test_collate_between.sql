CREATE TABLE collate_test(s VARCHAR, t VARCHAR);
INSERT INTO collate_test VALUES ('mark', 'muhleisen');
PRAGMA default_collation='NOACCENT';
SELECT COUNT(*) FROM collate_test WHERE 'mórritz' BETWEEN s AND t;
SELECT COUNT(*) FROM collate_test WHERE 'mórritz' COLLATE NOACCENT BETWEEN s AND t;
SELECT COUNT(*) FROM collate_test WHERE 'mórritz' BETWEEN (s COLLATE NOACCENT) AND t;
SELECT COUNT(*) FROM collate_test WHERE 'mórritz' BETWEEN s AND (t COLLATE NOACCENT);
SELECT COUNT(*) FROM collate_test WHERE 'mórritz' BETWEEN s AND t;
