


CREATE TABLE DEFAULT_TBL (i int DEFAULT 100,
	x text DEFAULT 'vadim', f float8 DEFAULT 123.456);

INSERT INTO DEFAULT_TBL VALUES (1, 'thomas', 57.0613);
INSERT INTO DEFAULT_TBL VALUES (1, 'bruce');
INSERT INTO DEFAULT_TBL (i, f) VALUES (2, 987.654);
INSERT INTO DEFAULT_TBL (x) VALUES ('marc');
INSERT INTO DEFAULT_TBL VALUES (3, null, 1.0);

SELECT * FROM DEFAULT_TBL;

CREATE SEQUENCE DEFAULT_SEQ;

CREATE TABLE DEFAULTEXPR_TBL (i1 int DEFAULT 100 + (200-199) * 2,
	i2 int DEFAULT nextval('default_seq'));

INSERT INTO DEFAULTEXPR_TBL VALUES (-1, -2);
INSERT INTO DEFAULTEXPR_TBL (i1) VALUES (-3);
INSERT INTO DEFAULTEXPR_TBL (i2) VALUES (-4);
INSERT INTO DEFAULTEXPR_TBL (i2) VALUES (NULL);

SELECT * FROM DEFAULTEXPR_TBL;

CREATE TABLE error_tbl (i int DEFAULT (100, ));
CREATE TABLE error_tbl (b1 bool DEFAULT 1 IN (1, 2));
CREATE TABLE error_tbl (b1 bool DEFAULT (1 IN (1, 2)));

DROP TABLE error_tbl;


CREATE TABLE CHECK_TBL (x int,
	CONSTRAINT CHECK_CON CHECK (x > 3));

INSERT INTO CHECK_TBL VALUES (5);
INSERT INTO CHECK_TBL VALUES (4);
INSERT INTO CHECK_TBL VALUES (3);
INSERT INTO CHECK_TBL VALUES (2);
INSERT INTO CHECK_TBL VALUES (6);
INSERT INTO CHECK_TBL VALUES (1);

SELECT * FROM CHECK_TBL;

CREATE SEQUENCE CHECK_SEQ;

CREATE TABLE CHECK2_TBL (x int, y text, z int,
	CONSTRAINT SEQUENCE_CON
	CHECK (x > 3 and y <> 'check failed' and z < 8));

INSERT INTO CHECK2_TBL VALUES (4, 'check ok', -2);
INSERT INTO CHECK2_TBL VALUES (1, 'x check failed', -2);
INSERT INTO CHECK2_TBL VALUES (5, 'z check failed', 10);
INSERT INTO CHECK2_TBL VALUES (0, 'check failed', -2);
INSERT INTO CHECK2_TBL VALUES (6, 'check failed', 11);
INSERT INTO CHECK2_TBL VALUES (7, 'check ok', 7);

SELECT * from CHECK2_TBL;


CREATE SEQUENCE INSERT_SEQ;

CREATE TABLE INSERT_TBL (x INT DEFAULT nextval('insert_seq'),
	y TEXT DEFAULT '-NULL-',
	z INT DEFAULT -1 * currval('insert_seq'),
	CONSTRAINT INSERT_TBL_CON CHECK (x >= 3 AND y <> 'check failed' AND x < 8),
	CHECK (x + z = 0));

INSERT INTO INSERT_TBL(x,z) VALUES (2, -2);

SELECT * FROM INSERT_TBL;

SELECT 'one' AS one, nextval('insert_seq');

INSERT INTO INSERT_TBL(y) VALUES ('Y');
INSERT INTO INSERT_TBL(y) VALUES ('Y');
INSERT INTO INSERT_TBL(x,z) VALUES (1, -2);
INSERT INTO INSERT_TBL(z,x) VALUES (-7,  7);
INSERT INTO INSERT_TBL VALUES (5, 'check failed', -5);
INSERT INTO INSERT_TBL VALUES (7, '!check failed', -7);
INSERT INTO INSERT_TBL(y) VALUES ('-!NULL-');

SELECT * FROM INSERT_TBL;

INSERT INTO INSERT_TBL(y,z) VALUES ('check failed', 4);
INSERT INTO INSERT_TBL(x,y) VALUES (5, 'check failed');
INSERT INTO INSERT_TBL(x,y) VALUES (5, '!check failed');
INSERT INTO INSERT_TBL(y) VALUES ('-!NULL-');

SELECT * FROM INSERT_TBL;

SELECT 'seven' AS one, nextval('insert_seq');

INSERT INTO INSERT_TBL(y) VALUES ('Y');

SELECT 'eight' AS one, currval('insert_seq');

INSERT INTO INSERT_TBL VALUES (null, null, null);

SELECT * FROM INSERT_TBL;


CREATE TABLE SYS_COL_CHECK_TBL (city text, state text, is_capital bool,
                  altitude int,
                  CHECK (NOT (is_capital AND tableoid::regclass::text = 'sys_col_check_tbl')));

INSERT INTO SYS_COL_CHECK_TBL VALUES ('Seattle', 'Washington', false, 100);
INSERT INTO SYS_COL_CHECK_TBL VALUES ('Olympia', 'Washington', true, 100);

SELECT *, tableoid::regclass::text FROM SYS_COL_CHECK_TBL;

DROP TABLE SYS_COL_CHECK_TBL;

CREATE TABLE SYS_COL_CHECK_TBL (city text, state text, is_capital bool,
                  altitude int,
				  CHECK (NOT (is_capital AND ctid::text = 'sys_col_check_tbl')));


CREATE TABLE INSERT_CHILD (cx INT default 42,
	cy INT CHECK (cy > x))
	INHERITS (INSERT_TBL);

INSERT INTO INSERT_CHILD(x,z,cy) VALUES (7,-7,11);
INSERT INTO INSERT_CHILD(x,z,cy) VALUES (7,-7,6);
INSERT INTO INSERT_CHILD(x,z,cy) VALUES (6,-7,7);
INSERT INTO INSERT_CHILD(x,y,z,cy) VALUES (6,'check failed',-6,7);

SELECT * FROM INSERT_CHILD;

DROP TABLE INSERT_CHILD;


CREATE TABLE ATACC1 (TEST INT
	CHECK (TEST > 0) NO INHERIT);

CREATE TABLE ATACC2 (TEST2 INT) INHERITS (ATACC1);
INSERT INTO ATACC2 (TEST) VALUES (-3);
INSERT INTO ATACC1 (TEST) VALUES (-3);
DROP TABLE ATACC1 CASCADE;

CREATE TABLE ATACC1 (TEST INT, TEST2 INT
	CHECK (TEST > 0), CHECK (TEST2 > 10) NO INHERIT);

CREATE TABLE ATACC2 () INHERITS (ATACC1);
INSERT INTO ATACC2 (TEST) VALUES (-3);
INSERT INTO ATACC1 (TEST) VALUES (-3);
INSERT INTO ATACC2 (TEST2) VALUES (3);
INSERT INTO ATACC1 (TEST2) VALUES (3);
DROP TABLE ATACC1 CASCADE;

CREATE TABLE ATACC1 (a int, not null a no inherit);
CREATE TABLE ATACC2 () INHERITS (ATACC1);
DROP TABLE ATACC1, ATACC2;
CREATE TABLE ATACC1 (a int);
ALTER TABLE ATACC1 ADD NOT NULL a NO INHERIT;
CREATE TABLE ATACC2 () INHERITS (ATACC1);
DROP TABLE ATACC1, ATACC2;
CREATE TABLE ATACC1 (a int);
CREATE TABLE ATACC2 () INHERITS (ATACC1);
ALTER TABLE ATACC1 ADD NOT NULL a NO INHERIT;
DROP TABLE ATACC1, ATACC2;


DELETE FROM INSERT_TBL;

ALTER SEQUENCE INSERT_SEQ RESTART WITH 4;

CREATE TEMP TABLE tmp (xd INT, yd TEXT, zd INT);

INSERT INTO tmp VALUES (null, 'Y', null);
INSERT INTO tmp VALUES (5, '!check failed', null);
INSERT INTO tmp VALUES (null, 'try again', null);
INSERT INTO INSERT_TBL(y) select yd from tmp;

SELECT * FROM INSERT_TBL;

INSERT INTO INSERT_TBL SELECT * FROM tmp WHERE yd = 'try again';
INSERT INTO INSERT_TBL(y,z) SELECT yd, -7 FROM tmp WHERE yd = 'try again';
INSERT INTO INSERT_TBL(y,z) SELECT yd, -8 FROM tmp WHERE yd = 'try again';

SELECT * FROM INSERT_TBL;

DROP TABLE tmp;


UPDATE INSERT_TBL SET x = NULL WHERE x = 5;
UPDATE INSERT_TBL SET x = 6 WHERE x = 6;
UPDATE INSERT_TBL SET x = -z, z = -x;
UPDATE INSERT_TBL SET x = z, z = x;

SELECT * FROM INSERT_TBL;



CREATE TABLE COPY_TBL (x INT, y TEXT, z INT,
	CONSTRAINT COPY_CON
	CHECK (x > 3 AND y <> 'check failed' AND x < 7 ));

COPY COPY_TBL FROM :'filename';

SELECT * FROM COPY_TBL;

COPY COPY_TBL FROM :'filename';

SELECT * FROM COPY_TBL;


CREATE TABLE PRIMARY_TBL (i int PRIMARY KEY, t text);

INSERT INTO PRIMARY_TBL VALUES (1, 'one');
INSERT INTO PRIMARY_TBL VALUES (2, 'two');
INSERT INTO PRIMARY_TBL VALUES (1, 'three');
INSERT INTO PRIMARY_TBL VALUES (4, 'three');
INSERT INTO PRIMARY_TBL VALUES (5, 'one');
INSERT INTO PRIMARY_TBL (t) VALUES ('six');

SELECT * FROM PRIMARY_TBL;

DROP TABLE PRIMARY_TBL;

CREATE TABLE PRIMARY_TBL (i int, t text,
	PRIMARY KEY(i,t));

INSERT INTO PRIMARY_TBL VALUES (1, 'one');
INSERT INTO PRIMARY_TBL VALUES (2, 'two');
INSERT INTO PRIMARY_TBL VALUES (1, 'three');
INSERT INTO PRIMARY_TBL VALUES (4, 'three');
INSERT INTO PRIMARY_TBL VALUES (5, 'one');
INSERT INTO PRIMARY_TBL (t) VALUES ('six');

SELECT * FROM PRIMARY_TBL;

DROP TABLE PRIMARY_TBL;


CREATE TABLE UNIQUE_TBL (i int UNIQUE, t text);

INSERT INTO UNIQUE_TBL VALUES (1, 'one');
INSERT INTO UNIQUE_TBL VALUES (2, 'two');
INSERT INTO UNIQUE_TBL VALUES (1, 'three');
INSERT INTO UNIQUE_TBL VALUES (4, 'four');
INSERT INTO UNIQUE_TBL VALUES (5, 'one');
INSERT INTO UNIQUE_TBL (t) VALUES ('six');
INSERT INTO UNIQUE_TBL (t) VALUES ('seven');

INSERT INTO UNIQUE_TBL VALUES (5, 'five-upsert-insert') ON CONFLICT (i) DO UPDATE SET t = 'five-upsert-update';
INSERT INTO UNIQUE_TBL VALUES (6, 'six-upsert-insert') ON CONFLICT (i) DO UPDATE SET t = 'six-upsert-update';
INSERT INTO UNIQUE_TBL VALUES (1, 'a'), (2, 'b'), (2, 'b') ON CONFLICT (i) DO UPDATE SET t = 'fails';

SELECT * FROM UNIQUE_TBL;

DROP TABLE UNIQUE_TBL;

CREATE TABLE UNIQUE_TBL (i int UNIQUE NULLS NOT DISTINCT, t text);

INSERT INTO UNIQUE_TBL VALUES (1, 'one');
INSERT INTO UNIQUE_TBL VALUES (2, 'two');
INSERT INTO UNIQUE_TBL VALUES (1, 'three');  
INSERT INTO UNIQUE_TBL VALUES (4, 'four');
INSERT INTO UNIQUE_TBL VALUES (5, 'one');
INSERT INTO UNIQUE_TBL (t) VALUES ('six');
INSERT INTO UNIQUE_TBL (t) VALUES ('seven');  
INSERT INTO UNIQUE_TBL (t) VALUES ('eight') ON CONFLICT DO NOTHING;  

SELECT * FROM UNIQUE_TBL;

DROP TABLE UNIQUE_TBL;

CREATE TABLE UNIQUE_TBL (i int, t text,
	UNIQUE(i,t));

INSERT INTO UNIQUE_TBL VALUES (1, 'one');
INSERT INTO UNIQUE_TBL VALUES (2, 'two');
INSERT INTO UNIQUE_TBL VALUES (1, 'three');
INSERT INTO UNIQUE_TBL VALUES (1, 'one');
INSERT INTO UNIQUE_TBL VALUES (5, 'one');
INSERT INTO UNIQUE_TBL (t) VALUES ('six');

SELECT * FROM UNIQUE_TBL;

DROP TABLE UNIQUE_TBL;


CREATE TABLE unique_tbl (i int UNIQUE DEFERRABLE, t text);

INSERT INTO unique_tbl VALUES (0, 'one');
INSERT INTO unique_tbl VALUES (1, 'two');
INSERT INTO unique_tbl VALUES (2, 'tree');
INSERT INTO unique_tbl VALUES (3, 'four');
INSERT INTO unique_tbl VALUES (4, 'five');

BEGIN;

UPDATE unique_tbl SET i = 1 WHERE i = 0;

ROLLBACK;

UPDATE unique_tbl SET i = i+1;

SELECT * FROM unique_tbl;

BEGIN;

SET CONSTRAINTS unique_tbl_i_key DEFERRED;

INSERT INTO unique_tbl VALUES (3, 'three');
DELETE FROM unique_tbl WHERE t = 'tree'; 

COMMIT; 

SELECT * FROM unique_tbl;

ALTER TABLE unique_tbl DROP CONSTRAINT unique_tbl_i_key;
ALTER TABLE unique_tbl ADD CONSTRAINT unique_tbl_i_key
	UNIQUE (i) DEFERRABLE INITIALLY DEFERRED;

BEGIN;

INSERT INTO unique_tbl VALUES (1, 'five');
INSERT INTO unique_tbl VALUES (5, 'one');
UPDATE unique_tbl SET i = 4 WHERE i = 2;
UPDATE unique_tbl SET i = 2 WHERE i = 4 AND t = 'four';
DELETE FROM unique_tbl WHERE i = 1 AND t = 'one';
DELETE FROM unique_tbl WHERE i = 5 AND t = 'five';

COMMIT;

SELECT * FROM unique_tbl;

BEGIN;
INSERT INTO unique_tbl VALUES (3, 'Three'); 
COMMIT; 

BEGIN;

SET CONSTRAINTS ALL IMMEDIATE;

INSERT INTO unique_tbl VALUES (3, 'Three'); 

COMMIT;

BEGIN;

SET CONSTRAINTS ALL DEFERRED;

INSERT INTO unique_tbl VALUES (3, 'Three'); 

SET CONSTRAINTS ALL IMMEDIATE; 

COMMIT;

CREATE TABLE parted_uniq_tbl (i int UNIQUE DEFERRABLE) partition by range (i);
CREATE TABLE parted_uniq_tbl_1 PARTITION OF parted_uniq_tbl FOR VALUES FROM (0) TO (10);
CREATE TABLE parted_uniq_tbl_2 PARTITION OF parted_uniq_tbl FOR VALUES FROM (20) TO (30);
SELECT conname, conrelid::regclass FROM pg_constraint
  WHERE conname LIKE 'parted_uniq%' ORDER BY conname;
BEGIN;
INSERT INTO parted_uniq_tbl VALUES (1);
SAVEPOINT f;
INSERT INTO parted_uniq_tbl VALUES (1);	
ROLLBACK TO f;
SET CONSTRAINTS parted_uniq_tbl_i_key DEFERRED;
INSERT INTO parted_uniq_tbl VALUES (1);	
COMMIT;
DROP TABLE parted_uniq_tbl;

CREATE TABLE parted_fk_naming (
    id bigint NOT NULL default 1,
    id_abc bigint,
    CONSTRAINT dummy_constr FOREIGN KEY (id_abc)
        REFERENCES parted_fk_naming (id),
    PRIMARY KEY (id)
)
PARTITION BY LIST (id);
CREATE TABLE parted_fk_naming_1 (
    id bigint NOT NULL default 1,
    id_abc bigint,
    PRIMARY KEY (id),
    CONSTRAINT dummy_constr CHECK (true)
);
ALTER TABLE parted_fk_naming ATTACH PARTITION parted_fk_naming_1 FOR VALUES IN ('1');
SELECT conname FROM pg_constraint WHERE conrelid = 'parted_fk_naming_1'::regclass AND contype = 'f';
DROP TABLE parted_fk_naming;


BEGIN;

INSERT INTO unique_tbl VALUES (3, 'Three'); 
UPDATE unique_tbl SET t = 'THREE' WHERE i = 3 AND t = 'Three';

COMMIT; 

SELECT * FROM unique_tbl;


BEGIN;

INSERT INTO unique_tbl VALUES(3, 'tree'); 
UPDATE unique_tbl SET t = 'threex' WHERE t = 'tree';
DELETE FROM unique_tbl WHERE t = 'three';

SELECT * FROM unique_tbl;

COMMIT;

SELECT * FROM unique_tbl;

DROP TABLE unique_tbl;


CREATE TABLE circles (
  c1 CIRCLE,
  c2 TEXT,
  EXCLUDE USING gist
    (c1 WITH &&, (c2::circle) WITH &&)
    WHERE (circle_center(c1) <> '(0,0)')
);

INSERT INTO circles VALUES('<(0,0), 5>', '<(0,0), 5>');
INSERT INTO circles VALUES('<(0,0), 5>', '<(0,0), 4>');

INSERT INTO circles VALUES('<(10,10), 10>', '<(0,0), 5>');
INSERT INTO circles VALUES('<(20,20), 10>', '<(0,0), 4>');
INSERT INTO circles VALUES('<(20,20), 10>', '<(0,0), 4>')
  ON CONFLICT ON CONSTRAINT circles_c1_c2_excl DO NOTHING;
INSERT INTO circles VALUES('<(20,20), 10>', '<(0,0), 4>')
  ON CONFLICT ON CONSTRAINT circles_c1_c2_excl DO UPDATE SET c2 = EXCLUDED.c2;
INSERT INTO circles VALUES('<(20,20), 1>', '<(0,0), 5>');
INSERT INTO circles VALUES('<(20,20), 10>', '<(10,10), 5>');

ALTER TABLE circles ADD EXCLUDE USING gist
  (c1 WITH &&, (c2::circle) WITH &&);

REINDEX INDEX circles_c1_c2_excl;

DROP TABLE circles;


CREATE TABLE deferred_excl (
  f1 int,
  f2 int,
  CONSTRAINT deferred_excl_con EXCLUDE (f1 WITH =) INITIALLY DEFERRED
);

INSERT INTO deferred_excl VALUES(1);
INSERT INTO deferred_excl VALUES(2);
INSERT INTO deferred_excl VALUES(1); 
INSERT INTO deferred_excl VALUES(1) ON CONFLICT ON CONSTRAINT deferred_excl_con DO NOTHING; 
BEGIN;
INSERT INTO deferred_excl VALUES(2); 
COMMIT; 
BEGIN;
INSERT INTO deferred_excl VALUES(3);
INSERT INTO deferred_excl VALUES(3); 
COMMIT; 

BEGIN;
INSERT INTO deferred_excl VALUES(2, 1); 
DELETE FROM deferred_excl WHERE f1 = 2 AND f2 IS NULL; 
UPDATE deferred_excl SET f2 = 2 WHERE f1 = 2;
COMMIT; 

SELECT * FROM deferred_excl;

ALTER TABLE deferred_excl DROP CONSTRAINT deferred_excl_con;

UPDATE deferred_excl SET f1 = 3;

ALTER TABLE deferred_excl ADD EXCLUDE (f1 WITH =);

DROP TABLE deferred_excl;

CREATE TABLE notnull_tbl1 (a INTEGER NOT NULL NOT NULL);
select conname, contype, conkey from pg_constraint where conrelid = 'notnull_tbl1'::regclass;
ALTER TABLE notnull_tbl1 ADD CONSTRAINT nn NOT NULL a;
ALTER TABLE notnull_tbl1 ADD COLUMN b INT CONSTRAINT notnull_tbl1_a_not_null NOT NULL;
ALTER TABLE notnull_tbl1 ALTER a DROP NOT NULL;
select conname, contype, conkey from pg_constraint where conrelid = 'notnull_tbl1'::regclass;
ALTER TABLE notnull_tbl1 ALTER a SET NOT NULL;
select conname, contype, conkey from pg_constraint where conrelid = 'notnull_tbl1'::regclass;
ALTER TABLE notnull_tbl1 ALTER a SET NOT NULL;
select conname, contype, conkey from pg_constraint where conrelid = 'notnull_tbl1'::regclass;
ALTER TABLE notnull_tbl1 ALTER a DROP NOT NULL;
ALTER TABLE notnull_tbl1 ADD CONSTRAINT foobar NOT NULL a;
select conname, contype, conkey from pg_constraint where conrelid = 'notnull_tbl1'::regclass;
DROP TABLE notnull_tbl1;

CREATE TABLE notnull_tbl2 (a INTEGER CONSTRAINT blah NOT NULL, b INTEGER CONSTRAINT blah NOT NULL);

CREATE TABLE notnull_tbl2 (a INTEGER PRIMARY KEY);
ALTER TABLE notnull_tbl2 ALTER a DROP NOT NULL;

CREATE TABLE notnull_tbl3 (a INTEGER NOT NULL, CHECK (a IS NOT NULL));
ALTER TABLE notnull_tbl3 ALTER A DROP NOT NULL;
ALTER TABLE notnull_tbl3 ADD b int, ADD CONSTRAINT pk PRIMARY KEY (a, b);
ALTER TABLE notnull_tbl3 DROP CONSTRAINT pk;

CREATE TABLE cnn_parent (a int, b int);
CREATE TABLE cnn_child () INHERITS (cnn_parent);
CREATE TABLE cnn_grandchild (NOT NULL b) INHERITS (cnn_child);
CREATE TABLE cnn_child2 (NOT NULL a NO INHERIT) INHERITS (cnn_parent);
CREATE TABLE cnn_grandchild2 () INHERITS (cnn_grandchild, cnn_child2);

ALTER TABLE cnn_parent ADD PRIMARY KEY (b);
ALTER TABLE cnn_parent DROP CONSTRAINT cnn_parent_pkey;
DROP TABLE cnn_parent CASCADE;

CREATE TABLE cnn_parent (a int, b int PRIMARY KEY);
CREATE TABLE cnn_child () INHERITS (cnn_parent);
CREATE TABLE cnn_grandchild (NOT NULL b) INHERITS (cnn_child);
CREATE TABLE cnn_child2 (NOT NULL a NO INHERIT) INHERITS (cnn_parent);
CREATE TABLE cnn_grandchild2 () INHERITS (cnn_grandchild, cnn_child2);

ALTER TABLE cnn_parent ADD PRIMARY KEY (b);
ALTER TABLE cnn_parent DROP CONSTRAINT cnn_parent_pkey;
DROP TABLE cnn_parent CASCADE;

CREATE TABLE cnn_parent (a int, b int);
CREATE TABLE cnn_child () INHERITS (cnn_parent);
CREATE TABLE cnn_grandchild (NOT NULL b) INHERITS (cnn_child);
CREATE TABLE cnn_child2 (NOT NULL a NO INHERIT) INHERITS (cnn_parent);
CREATE TABLE cnn_grandchild2 () INHERITS (cnn_grandchild, cnn_child2);

CREATE UNIQUE INDEX b_uq ON cnn_parent (b);
ALTER TABLE cnn_parent ADD PRIMARY KEY USING INDEX b_uq;
ALTER TABLE cnn_parent DROP CONSTRAINT cnn_parent_pkey;

create table cnn2_parted(a int primary key) partition by list (a);
create table cnn2_part1(a int);
alter table cnn2_parted attach partition cnn2_part1 for values in (1);
drop table cnn2_parted, cnn2_part1;

create table cnn2_parted(a int not null) partition by list (a);
create table cnn2_part1(a int primary key);
alter table cnn2_parted attach partition cnn2_part1 for values in (1);
drop table cnn2_parted, cnn2_part1;

CREATE TABLE notnull_tbl4 (a INTEGER PRIMARY KEY INITIALLY DEFERRED);
CREATE TABLE notnull_tbl4_lk (LIKE notnull_tbl4);
CREATE TABLE notnull_tbl4_lk2 (LIKE notnull_tbl4 INCLUDING INDEXES);
CREATE TABLE notnull_tbl4_lk3 (LIKE notnull_tbl4 INCLUDING INDEXES, CONSTRAINT a_nn NOT NULL a);
CREATE TABLE notnull_tbl4_cld () INHERITS (notnull_tbl4);
CREATE TABLE notnull_tbl4_cld2 (PRIMARY KEY (a) DEFERRABLE) INHERITS (notnull_tbl4);
CREATE TABLE notnull_tbl4_cld3 (PRIMARY KEY (a) DEFERRABLE, CONSTRAINT a_nn NOT NULL a) INHERITS (notnull_tbl4);

CREATE TABLE notnull_tbl5 (a INTEGER CONSTRAINT a_nn NOT NULL);
ALTER TABLE notnull_tbl5 ADD PRIMARY KEY (a) DEFERRABLE;
ALTER TABLE notnull_tbl5 DROP CONSTRAINT a_nn;
DROP TABLE notnull_tbl5;

CREATE ROLE regress_constraint_comments;
SET SESSION AUTHORIZATION regress_constraint_comments;

CREATE TABLE constraint_comments_tbl (a int CONSTRAINT the_constraint CHECK (a > 0));
CREATE DOMAIN constraint_comments_dom AS int CONSTRAINT the_constraint CHECK (value > 0);

COMMENT ON CONSTRAINT the_constraint ON constraint_comments_tbl IS 'yes, the comment';
COMMENT ON CONSTRAINT the_constraint ON DOMAIN constraint_comments_dom IS 'yes, another comment';

COMMENT ON CONSTRAINT no_constraint ON constraint_comments_tbl IS 'yes, the comment';
COMMENT ON CONSTRAINT no_constraint ON DOMAIN constraint_comments_dom IS 'yes, another comment';

COMMENT ON CONSTRAINT the_constraint ON no_comments_tbl IS 'bad comment';
COMMENT ON CONSTRAINT the_constraint ON DOMAIN no_comments_dom IS 'another bad comment';

COMMENT ON CONSTRAINT the_constraint ON constraint_comments_tbl IS NULL;
COMMENT ON CONSTRAINT the_constraint ON DOMAIN constraint_comments_dom IS NULL;

RESET SESSION AUTHORIZATION;
CREATE ROLE regress_constraint_comments_noaccess;
SET SESSION AUTHORIZATION regress_constraint_comments_noaccess;
COMMENT ON CONSTRAINT the_constraint ON constraint_comments_tbl IS 'no, the comment';
COMMENT ON CONSTRAINT the_constraint ON DOMAIN constraint_comments_dom IS 'no, another comment';
RESET SESSION AUTHORIZATION;

DROP TABLE constraint_comments_tbl;
DROP DOMAIN constraint_comments_dom;

DROP ROLE regress_constraint_comments;
DROP ROLE regress_constraint_comments_noaccess;
