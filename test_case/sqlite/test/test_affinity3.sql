SELECT id, (apr / 100), typeof(apr) apr_type  FROM v1;
PRAGMA automatic_index=ON;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v1rj;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v2;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v2rj;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v2rjrj;
PRAGMA automatic_index=OFF;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v1;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v1rj;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v2;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v2rj;
SELECT id, (apr / 100), typeof(apr) apr_type  FROM v2rjrj;
CREATE TABLE map_integer (id INT, name);
INSERT INTO map_integer VALUES(1,'a');
CREATE TABLE map_text (id TEXT, name);
INSERT INTO map_text VALUES('4','e');
CREATE TABLE data (id TEXT, name);
INSERT INTO data VALUES(1,'abc');
INSERT INTO data VALUES('4','xyz');
CREATE VIEW idmap as
      SELECT * FROM map_integer
      UNION SELECT * FROM map_text;
CREATE TABLE mzed AS SELECT * FROM idmap;
PRAGMA automatic_index=ON;
SELECT * FROM data JOIN idmap USING(id);
SELECT * FROM data JOIN mzed USING(id);
PRAGMA automatic_index=OFF;
SELECT * FROM data JOIN idmap USING(id);
SELECT * FROM data JOIN mzed USING(id);
