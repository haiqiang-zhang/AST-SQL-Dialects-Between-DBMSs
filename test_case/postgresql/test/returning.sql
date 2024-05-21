CREATE TEMP TABLE foo (f1 serial, f2 text, f3 int default 42);
INSERT INTO foo (f2,f3)
  VALUES ('test', DEFAULT), ('More', 11), (upper('more'), 7+9)
  RETURNING *, f1+f3 AS sum;
SELECT * FROM foo;
UPDATE foo SET f2 = lower(f2), f3 = DEFAULT RETURNING foo.*, f1+f3 AS sum13;
SELECT * FROM foo;
DELETE FROM foo WHERE f1 > 2 RETURNING f3, f2, f1, least(f1,f3);
SELECT * FROM foo;
SELECT * FROM foo;
SELECT * FROM foo;
CREATE TEMP TABLE foochild (fc int) INHERITS (foo);
INSERT INTO foochild VALUES(123,'child',999,-123);
ALTER TABLE foo ADD COLUMN f4 int8 DEFAULT 99;
SELECT * FROM foo;
SELECT * FROM foochild;
UPDATE foo SET f4 = f4 + f3 WHERE f4 = 99 RETURNING *;
SELECT * FROM foo;
SELECT * FROM foochild;
SELECT * FROM foo;
SELECT * FROM foochild;
SELECT * FROM foo;
SELECT * FROM foochild;
DROP TABLE foochild;
CREATE TEMP VIEW voo AS SELECT f1, f2 FROM foo;
CREATE RULE voo_i AS ON INSERT TO voo DO INSTEAD
  INSERT INTO foo VALUES(new.*, 57);
INSERT INTO voo VALUES(11,'zit');
CREATE OR REPLACE RULE voo_i AS ON INSERT TO voo DO INSTEAD
  INSERT INTO foo VALUES(new.*, 57) RETURNING f1, f2;
INSERT INTO voo VALUES(13,'zit2');
INSERT INTO voo VALUES(14,'zoo2') RETURNING *;
SELECT * FROM foo;
SELECT * FROM voo;
CREATE OR REPLACE RULE voo_u AS ON UPDATE TO voo DO INSTEAD
  UPDATE foo SET f1 = new.f1, f2 = new.f2 WHERE f1 = old.f1
  RETURNING f1, f2;
update voo set f1 = f1 + 1 where f2 = 'zoo2';
update voo set f1 = f1 + 1 where f2 = 'zoo2' RETURNING *, f1*2;
SELECT * FROM foo;
SELECT * FROM voo;
CREATE OR REPLACE RULE voo_d AS ON DELETE TO voo DO INSTEAD
  DELETE FROM foo WHERE f1 = old.f1
  RETURNING f1, f2;
DELETE FROM foo WHERE f1 = 13;
DELETE FROM foo WHERE f2 = 'zit' RETURNING *;
SELECT * FROM foo;
SELECT * FROM voo;
CREATE TEMP TABLE joinme (f2j text, other int);
INSERT INTO joinme VALUES('more', 12345);
INSERT INTO joinme VALUES('zoo2', 54321);
INSERT INTO joinme VALUES('other', 0);
CREATE TEMP VIEW joinview AS
  SELECT foo.*, other FROM foo JOIN joinme ON (f2 = f2j);
SELECT * FROM joinview;
CREATE RULE joinview_u AS ON UPDATE TO joinview DO INSTEAD
  UPDATE foo SET f1 = new.f1, f3 = new.f3
    FROM joinme WHERE f2 = f2j AND f2 = old.f2
    RETURNING foo.*, other;
UPDATE joinview SET f1 = f1 + 1 WHERE f3 = 57 RETURNING *, other + 1;
SELECT * FROM joinview;
SELECT * FROM foo;
SELECT * FROM voo;
INSERT INTO foo AS bar DEFAULT VALUES RETURNING *;
INSERT INTO foo AS bar DEFAULT VALUES RETURNING bar.*;
INSERT INTO foo AS bar DEFAULT VALUES RETURNING bar.f3;
