CREATE TABLE collate_test(s VARCHAR COLLATE NOACCENT.NOCASE);
INSERT INTO collate_test VALUES ('MÃÂÃÂÃÂÃÂ¼hleisen'), ('HÃÂÃÂÃÂÃÂ«llÃÂÃÂÃÂÃÂ¶');
SELECT * FROM collate_test WHERE s='Muhleisen';
SELECT * FROM collate_test WHERE s='muhleisen';
SELECT * FROM collate_test WHERE s='hEllÃÂÃÂÃÂÃÂ´';