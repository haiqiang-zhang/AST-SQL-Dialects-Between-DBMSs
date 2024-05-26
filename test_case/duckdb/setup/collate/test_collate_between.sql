CREATE TABLE collate_test(s VARCHAR, t VARCHAR);
INSERT INTO collate_test VALUES ('mark', 'muhleisen');
PRAGMA default_collation='NOACCENT';
