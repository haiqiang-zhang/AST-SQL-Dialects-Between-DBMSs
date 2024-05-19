
SET datestyle TO ISO, YMD;



CREATE TABLE temporal_rng (
	valid_at daterange,
	CONSTRAINT temporal_rng_pk PRIMARY KEY (valid_at WITHOUT OVERLAPS)
);


CREATE TABLE temporal_rng (
	id INTEGER,
	CONSTRAINT temporal_rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);


CREATE TABLE temporal_rng (
	id int4range,
	valid_at TEXT,
	CONSTRAINT temporal_rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);


CREATE TABLE temporal_rng (
	id int4range,
	valid_at daterange,
	CONSTRAINT temporal_rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng_pk';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng_pk';

CREATE TABLE temporal_rng2 (
	id1 int4range,
	id2 int4range,
	valid_at daterange,
	CONSTRAINT temporal_rng2_pk PRIMARY KEY (id1, id2, valid_at WITHOUT OVERLAPS)
);
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng2_pk';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng2_pk';

CREATE TYPE textrange2 AS range (subtype=text, collation="C");
CREATE TABLE temporal_rng3 (
	id int4range,
	valid_at textrange2,
	CONSTRAINT temporal_rng3_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
ALTER TABLE temporal_rng3 DROP CONSTRAINT temporal_rng3_pk;
DROP TABLE temporal_rng3;
DROP TYPE textrange2;

CREATE TABLE temporal_mltrng (
  id int4range,
  valid_at datemultirange,
  CONSTRAINT temporal_mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);

CREATE TABLE temporal_mltrng2 (
	id1 int4range,
	id2 int4range,
	valid_at datemultirange,
	CONSTRAINT temporal_mltrng2_pk PRIMARY KEY (id1, id2, valid_at WITHOUT OVERLAPS)
);
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_mltrng2_pk';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_mltrng2_pk';


CREATE TABLE temporal_rng3 (
	valid_at daterange,
	CONSTRAINT temporal_rng3_uq UNIQUE (valid_at WITHOUT OVERLAPS)
);


CREATE TABLE temporal_rng3 (
	id INTEGER,
	CONSTRAINT temporal_rng3_uq UNIQUE (id, valid_at WITHOUT OVERLAPS)
);


CREATE TABLE temporal_rng3 (
	id int4range,
	valid_at TEXT,
	CONSTRAINT temporal_rng3_uq UNIQUE (id, valid_at WITHOUT OVERLAPS)
);


CREATE TABLE temporal_rng3 (
	id int4range,
	valid_at daterange,
	CONSTRAINT temporal_rng3_uq UNIQUE (id, valid_at WITHOUT OVERLAPS)
);
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
DROP TABLE temporal_rng3;

CREATE TABLE temporal_rng3 (
	id1 int4range,
	id2 int4range,
	valid_at daterange,
	CONSTRAINT temporal_rng3_uq UNIQUE (id1, id2, valid_at WITHOUT OVERLAPS)
);
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
DROP TABLE temporal_rng3;

CREATE TYPE textrange2 AS range (subtype=text, collation="C");
CREATE TABLE temporal_rng3 (
	id int4range,
	valid_at textrange2,
	CONSTRAINT temporal_rng3_uq UNIQUE (id, valid_at WITHOUT OVERLAPS)
);
ALTER TABLE temporal_rng3 DROP CONSTRAINT temporal_rng3_uq;
DROP TABLE temporal_rng3;
DROP TYPE textrange2;


DROP TABLE temporal_rng;
CREATE TABLE temporal_rng (
	id int4range,
	valid_at daterange
);
ALTER TABLE temporal_rng
	ADD CONSTRAINT temporal_rng_pk
	PRIMARY KEY (id, valid_at WITHOUT OVERLAPS);

CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange
);
CREATE INDEX idx_temporal3_uq ON temporal3 USING gist (id, valid_at);
ALTER TABLE temporal3
	ADD CONSTRAINT temporal3_pk
	PRIMARY KEY USING INDEX idx_temporal3_uq;
DROP TABLE temporal3;

CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange
);
CREATE INDEX idx_temporal3_uq ON temporal3 USING gist (id, valid_at);
ALTER TABLE temporal3
	ADD CONSTRAINT temporal3_uq
	UNIQUE USING INDEX idx_temporal3_uq;
DROP TABLE temporal3;

CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange
);
CREATE UNIQUE INDEX idx_temporal3_uq ON temporal3 (id, valid_at);
ALTER TABLE temporal3
	ADD CONSTRAINT temporal3_uq
	UNIQUE USING INDEX idx_temporal3_uq;
DROP TABLE temporal3;

CREATE TABLE temporal3 (
	id int4range
);
ALTER TABLE temporal3
	ADD COLUMN valid_at daterange,
	ADD CONSTRAINT temporal3_pk
	PRIMARY KEY (id, valid_at WITHOUT OVERLAPS);
DROP TABLE temporal3;

CREATE TABLE temporal3 (
	id int4range
);
ALTER TABLE temporal3
	ADD COLUMN valid_at daterange,
	ADD CONSTRAINT temporal3_uq
	UNIQUE (id, valid_at WITHOUT OVERLAPS);
DROP TABLE temporal3;


INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-01-02', '2018-02-03'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-03-03', '2018-04-04'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[2,3)', daterange('2018-01-01', '2018-01-05'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[3,4)', daterange('2018-01-01', NULL));

INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-01-01', '2018-01-05'));
INSERT INTO temporal_rng (id, valid_at) VALUES (NULL, daterange('2018-01-01', '2018-01-05'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[3,4)', NULL);

INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[1,2)', datemultirange(daterange('2018-01-02', '2018-02-03')));
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[1,2)', datemultirange(daterange('2018-03-03', '2018-04-04')));
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[2,3)', datemultirange(daterange('2018-01-01', '2018-01-05')));
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[3,4)', datemultirange(daterange('2018-01-01', NULL)));

INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[1,2)', datemultirange(daterange('2018-01-01', '2018-01-05')));
INSERT INTO temporal_mltrng (id, valid_at) VALUES (NULL, datemultirange(daterange('2018-01-01', '2018-01-05')));
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[3,4)', NULL);

SELECT * FROM temporal_mltrng ORDER BY id, valid_at;


CREATE TABLE temporal3 (
  id int4range,
  valid_at daterange,
  id2 int8range,
  name TEXT,
  CONSTRAINT temporal3_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
  CONSTRAINT temporal3_uniq UNIQUE (id2, valid_at WITHOUT OVERLAPS)
);
INSERT INTO temporal3 (id, valid_at, id2, name)
  VALUES
  ('[1,2)', daterange('2000-01-01', '2010-01-01'), '[7,8)', 'foo'),
  ('[2,3)', daterange('2000-01-01', '2010-01-01'), '[9,10)', 'bar')
;
DROP TABLE temporal3;


CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange,
	CONSTRAINT temporal3_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);

ALTER TABLE temporal3 ALTER COLUMN valid_at DROP NOT NULL;
ALTER TABLE temporal3 ALTER COLUMN valid_at TYPE tstzrange USING tstzrange(lower(valid_at), upper(valid_at));
ALTER TABLE temporal3 RENAME COLUMN valid_at TO valid_thru;
ALTER TABLE temporal3 DROP COLUMN valid_thru;
DROP TABLE temporal3;


CREATE TABLE temporal_partitioned (
	id int4range,
	valid_at daterange,
  name text,
	CONSTRAINT temporal_paritioned_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
) PARTITION BY LIST (id);
CREATE TABLE tp1 PARTITION OF temporal_partitioned FOR VALUES IN ('[1,2)', '[2,3)');
CREATE TABLE tp2 PARTITION OF temporal_partitioned FOR VALUES IN ('[3,4)', '[4,5)');
INSERT INTO temporal_partitioned (id, valid_at, name) VALUES
  ('[1,2)', daterange('2000-01-01', '2000-02-01'), 'one'),
  ('[1,2)', daterange('2000-02-01', '2000-03-01'), 'one'),
  ('[3,4)', daterange('2000-01-01', '2010-01-01'), 'three');
SELECT * FROM temporal_partitioned ORDER BY id, valid_at;
SELECT * FROM tp1 ORDER BY id, valid_at;
SELECT * FROM tp2 ORDER BY id, valid_at;
DROP TABLE temporal_partitioned;

CREATE TABLE temporal_partitioned (
	id int4range,
	valid_at daterange,
  name text,
	CONSTRAINT temporal_paritioned_uq UNIQUE (id, valid_at WITHOUT OVERLAPS)
) PARTITION BY LIST (id);
CREATE TABLE tp1 PARTITION OF temporal_partitioned FOR VALUES IN ('[1,2)', '[2,3)');
CREATE TABLE tp2 PARTITION OF temporal_partitioned FOR VALUES IN ('[3,4)', '[4,5)');
INSERT INTO temporal_partitioned (id, valid_at, name) VALUES
  ('[1,2)', daterange('2000-01-01', '2000-02-01'), 'one'),
  ('[1,2)', daterange('2000-02-01', '2000-03-01'), 'one'),
  ('[3,4)', daterange('2000-01-01', '2010-01-01'), 'three');
SELECT * FROM temporal_partitioned ORDER BY id, valid_at;
SELECT * FROM tp1 ORDER BY id, valid_at;
SELECT * FROM tp2 ORDER BY id, valid_at;
DROP TABLE temporal_partitioned;


CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange,
	CONSTRAINT temporal3_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal3 (id, PERIOD valid_at)
);
ALTER TABLE temporal3 DROP COLUMN valid_at;
ALTER TABLE temporal3 DROP COLUMN valid_at CASCADE;
DROP TABLE temporal_fk_rng2rng;
DROP TABLE temporal3;


DROP TABLE temporal_rng;
CREATE TABLE temporal_rng (id int4range, valid_at daterange);
ALTER TABLE temporal_rng
  ADD CONSTRAINT temporal_rng_pk
  PRIMARY KEY (id, valid_at WITHOUT OVERLAPS);

CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at int4range,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk2 PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk2 FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng (id, PERIOD valid_at)
);

CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng (id, PERIOD valid_at)
);
DROP TABLE temporal_fk_rng2rng;


CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng (id, valid_at)
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, valid_at)
		REFERENCES temporal_rng (id, valid_at)
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, valid_at)
		REFERENCES temporal_rng (id, PERIOD valid_at)
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, valid_at)
		REFERENCES temporal_rng
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng (id)
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id)
		REFERENCES temporal_rng (id, PERIOD valid_at)
);
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng
);
DROP TABLE temporal_fk_rng2rng;
CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id)
		REFERENCES temporal_rng
);

CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD parent_id)
		REFERENCES temporal_rng (id, PERIOD id)
);

DROP TABLE temporal_rng2;
CREATE TABLE temporal_rng2 (
  id1 int4range,
  id2 int4range,
  valid_at daterange,
  CONSTRAINT temporal_rng2_pk PRIMARY KEY (id1, id2, valid_at WITHOUT OVERLAPS)
);

CREATE TABLE temporal_fk2_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id1 int4range,
	parent_id2 int4range,
	CONSTRAINT temporal_fk2_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk2_rng2rng_fk FOREIGN KEY (parent_id1, parent_id2, PERIOD valid_at)
		REFERENCES temporal_rng2 (id1, id2, PERIOD valid_at)
);
DROP TABLE temporal_fk2_rng2rng;


CREATE TABLE temporal_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng (id, PERIOD valid_at);
CREATE TABLE temporal_fk2_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id1 int4range,
	parent_id2 int4range,
	CONSTRAINT temporal_fk2_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
ALTER TABLE temporal_fk2_rng2rng
	ADD CONSTRAINT temporal_fk2_rng2rng_fk
	FOREIGN KEY (parent_id1, parent_id2, PERIOD valid_at)
	REFERENCES temporal_rng2 (id1, id2, PERIOD valid_at);

ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk,
	ALTER COLUMN valid_at TYPE tsrange USING tsrange(lower(valid_at), upper(valid_at));
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng;
ALTER TABLE temporal_fk_rng2rng
	ALTER COLUMN valid_at TYPE daterange USING daterange(lower(valid_at)::date, upper(valid_at)::date);

ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng;

ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk2
	FOREIGN KEY (parent_id, PERIOD parent_id)
	REFERENCES temporal_rng (id, PERIOD id);


DELETE FROM temporal_fk_rng2rng;
DELETE FROM temporal_rng;
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[1,2)', daterange('2018-01-02', '2018-02-03')),
  ('[1,2)', daterange('2018-03-03', '2018-04-04')),
  ('[2,3)', daterange('2018-01-01', '2018-01-05')),
  ('[3,4)', daterange('2018-01-01', NULL));

ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk;
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[1,2)', daterange('2018-01-02', '2018-02-01'), '[1,2)');
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng;
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk;
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[2,3)', daterange('2018-01-02', '2018-04-01'), '[1,2)');
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng;
DELETE FROM temporal_fk_rng2rng;
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng;


SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_fk_rng2rng_fk';


INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[1,2)', daterange('2018-01-02', '2018-02-01'), '[1,2)');
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[2,3)', daterange('2018-01-02', '2018-04-01'), '[1,2)');
INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-02-03', '2018-03-03'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[2,3)', daterange('2018-01-02', '2018-04-01'), '[1,2)');


UPDATE temporal_fk_rng2rng SET valid_at = daterange('2018-01-02', '2018-03-01') WHERE id = '[1,2)';
UPDATE temporal_fk_rng2rng SET valid_at = daterange('2018-01-02', '2018-05-01') WHERE id = '[1,2)';
UPDATE temporal_fk_rng2rng SET parent_id = '[8,9)' WHERE id = '[1,2)';


BEGIN;
  INSERT INTO temporal_rng (id, valid_at) VALUES
    ('[5,6)', daterange('2018-01-01', '2018-02-01')),
    ('[5,6)', daterange('2018-02-01', '2018-03-01'));
  INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES
    ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
  ALTER TABLE temporal_fk_rng2rng
    ALTER CONSTRAINT temporal_fk_rng2rng_fk
    DEFERRABLE INITIALLY DEFERRED;

  DELETE FROM temporal_rng WHERE id = '[5,6)'; 
COMMIT; 


TRUNCATE temporal_rng, temporal_fk_rng2rng;
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk;
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng
	ON UPDATE NO ACTION;
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01') WHERE id = '[5,6)';
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
UPDATE temporal_rng SET valid_at = daterange('2016-02-01', '2016-03-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
BEGIN;
  ALTER TABLE temporal_fk_rng2rng
    ALTER CONSTRAINT temporal_fk_rng2rng_fk
    DEFERRABLE INITIALLY DEFERRED;

  UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
  WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
COMMIT;
UPDATE temporal_rng SET id = '[7,8)'
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
DELETE FROM temporal_fk_rng2rng WHERE id = '[3,4)';
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


TRUNCATE temporal_rng, temporal_fk_rng2rng;
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk;
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng
	ON UPDATE RESTRICT;
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01') WHERE id = '[5,6)';
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
UPDATE temporal_rng SET valid_at = daterange('2016-02-01', '2016-03-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
BEGIN;
  ALTER TABLE temporal_fk_rng2rng
    ALTER CONSTRAINT temporal_fk_rng2rng_fk
    DEFERRABLE INITIALLY DEFERRED;
  UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
  WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
ROLLBACK;
UPDATE temporal_rng SET id = '[7,8)'
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
DELETE FROM temporal_fk_rng2rng WHERE id = '[3,4)';
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


TRUNCATE temporal_rng, temporal_fk_rng2rng;
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk;
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng;
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
BEGIN;
  ALTER TABLE temporal_fk_rng2rng
    ALTER CONSTRAINT temporal_fk_rng2rng_fk
    DEFERRABLE INITIALLY DEFERRED;

  DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
COMMIT;
DELETE FROM temporal_fk_rng2rng WHERE id = '[3,4)';
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


TRUNCATE temporal_rng, temporal_fk_rng2rng;
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk;
ALTER TABLE temporal_fk_rng2rng
	ADD CONSTRAINT temporal_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_rng
	ON DELETE RESTRICT;
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
BEGIN;
  ALTER TABLE temporal_fk_rng2rng
    ALTER CONSTRAINT temporal_fk_rng2rng_fk
    DEFERRABLE INITIALLY DEFERRED;
  DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
ROLLBACK;
DELETE FROM temporal_fk_rng2rng WHERE id = '[3,4)';
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


INSERT INTO temporal_rng (id, valid_at) VALUES ('[6,7)', daterange('2018-01-01', '2021-01-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[4,5)', daterange('2018-01-01', '2021-01-01'), '[6,7)');
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk,
	ADD CONSTRAINT temporal_fk_rng2rng_fk
		FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng
		ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO temporal_rng (id, valid_at) VALUES ('[9,10)', daterange('2018-01-01', '2021-01-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[6,7)', daterange('2018-01-01', '2021-01-01'), '[9,10)');
ALTER TABLE temporal_fk_rng2rng
	DROP CONSTRAINT temporal_fk_rng2rng_fk,
	ADD CONSTRAINT temporal_fk_rng2rng_fk
		FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng
		ON DELETE SET NULL ON UPDATE SET NULL;

INSERT INTO temporal_rng (id, valid_at) VALUES ('[-1,-1]', daterange(null, null));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[12,13)', daterange('2018-01-01', '2021-01-01'));
INSERT INTO temporal_fk_rng2rng (id, valid_at, parent_id) VALUES ('[8,9)', daterange('2018-01-01', '2021-01-01'), '[12,13)');
ALTER TABLE temporal_fk_rng2rng
  ALTER COLUMN parent_id SET DEFAULT '[-1,-1]',
	DROP CONSTRAINT temporal_fk_rng2rng_fk,
	ADD CONSTRAINT temporal_fk_rng2rng_fk
		FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_rng
		ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at int4multirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk2 PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk2 FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_mltrng (id, PERIOD valid_at)
);

CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_mltrng (id, PERIOD valid_at)
);
DROP TABLE temporal_fk_mltrng2mltrng;


CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_mltrng (id, valid_at)
);
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, valid_at)
		REFERENCES temporal_mltrng (id, valid_at)
);
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, valid_at)
		REFERENCES temporal_mltrng (id, PERIOD valid_at)
);
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, valid_at)
		REFERENCES temporal_mltrng
);
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_mltrng (id)
);
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id)
		REFERENCES temporal_mltrng (id, PERIOD valid_at)
);
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_mltrng
);
DROP TABLE temporal_fk_mltrng2mltrng;
CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id)
		REFERENCES temporal_mltrng
);

CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk_mltrng2mltrng_fk FOREIGN KEY (parent_id, PERIOD parent_id)
		REFERENCES temporal_mltrng (id, PERIOD id)
);

CREATE TABLE temporal_fk2_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id1 int4range,
	parent_id2 int4range,
	CONSTRAINT temporal_fk2_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_fk2_mltrng2mltrng_fk FOREIGN KEY (parent_id1, parent_id2, PERIOD valid_at)
		REFERENCES temporal_mltrng2 (id1, id2, PERIOD valid_at)
);
DROP TABLE temporal_fk2_mltrng2mltrng;


CREATE TABLE temporal_fk_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id int4range,
	CONSTRAINT temporal_fk_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at);
CREATE TABLE temporal_fk2_mltrng2mltrng (
	id int4range,
	valid_at datemultirange,
	parent_id1 int4range,
	parent_id2 int4range,
	CONSTRAINT temporal_fk2_mltrng2mltrng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);
ALTER TABLE temporal_fk2_mltrng2mltrng
	ADD CONSTRAINT temporal_fk2_mltrng2mltrng_fk
	FOREIGN KEY (parent_id1, parent_id2, PERIOD valid_at)
	REFERENCES temporal_mltrng2 (id1, id2, PERIOD valid_at);

ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk2
	FOREIGN KEY (parent_id, PERIOD parent_id)
	REFERENCES temporal_mltrng (id, PERIOD id);


DELETE FROM temporal_fk_mltrng2mltrng;
ALTER TABLE temporal_fk_mltrng2mltrng
	DROP CONSTRAINT temporal_fk_mltrng2mltrng_fk;
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[1,2)', datemultirange(daterange('2018-01-02', '2018-02-01')), '[1,2)');
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at);
ALTER TABLE temporal_fk_mltrng2mltrng
	DROP CONSTRAINT temporal_fk_mltrng2mltrng_fk;
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[2,3)', datemultirange(daterange('2018-01-02', '2018-04-01')), '[1,2)');
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at);
DELETE FROM temporal_fk_mltrng2mltrng;
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at);


SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_fk_mltrng2mltrng_fk';


INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[1,2)', datemultirange(daterange('2018-01-02', '2018-02-01')), '[1,2)');
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[2,3)', datemultirange(daterange('2018-01-02', '2018-04-01')), '[1,2)');
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[1,2)', datemultirange(daterange('2018-02-03', '2018-03-03')));
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[2,3)', datemultirange(daterange('2018-01-02', '2018-04-01')), '[1,2)');


UPDATE temporal_fk_mltrng2mltrng SET valid_at = datemultirange(daterange('2018-01-02', '2018-03-01')) WHERE id = '[1,2)';
UPDATE temporal_fk_mltrng2mltrng SET valid_at = datemultirange(daterange('2018-01-02', '2018-05-01')) WHERE id = '[1,2)';
UPDATE temporal_fk_mltrng2mltrng SET parent_id = '[8,9)' WHERE id = '[1,2)';


BEGIN;
  INSERT INTO temporal_mltrng (id, valid_at) VALUES
    ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01'))),
    ('[5,6)', datemultirange(daterange('2018-02-01', '2018-03-01')));
  INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES
    ('[3,4)', datemultirange(daterange('2018-01-05', '2018-01-10')), '[5,6)');
  ALTER TABLE temporal_fk_mltrng2mltrng
    ALTER CONSTRAINT temporal_fk_mltrng2mltrng_fk
    DEFERRABLE INITIALLY DEFERRED;

  DELETE FROM temporal_mltrng WHERE id = '[5,6)'; 
COMMIT; 


TRUNCATE temporal_mltrng, temporal_fk_mltrng2mltrng;
ALTER TABLE temporal_fk_mltrng2mltrng
	DROP CONSTRAINT temporal_fk_mltrng2mltrng_fk;
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at)
	ON UPDATE NO ACTION;
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01')));
UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-01-01', '2016-02-01')) WHERE id = '[5,6)';
DELETE FROM temporal_mltrng WHERE id = '[5,6)';
INSERT INTO temporal_mltrng (id, valid_at) VALUES
  ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01'))),
  ('[5,6)', datemultirange(daterange('2018-02-01', '2018-03-01')));
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[3,4)', datemultirange(daterange('2018-01-05', '2018-01-10')), '[5,6)');
UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-02-01', '2016-03-01'))
WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-02-01', '2018-03-01'));
UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-01-01', '2016-02-01'))
WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));
BEGIN;
  ALTER TABLE temporal_fk_mltrng2mltrng
    ALTER CONSTRAINT temporal_fk_mltrng2mltrng_fk
    DEFERRABLE INITIALLY DEFERRED;

  UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-01-01', '2016-02-01'))
  WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));
COMMIT;
UPDATE temporal_mltrng SET id = '[7,8)'
WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));


TRUNCATE temporal_mltrng, temporal_fk_mltrng2mltrng;
ALTER TABLE temporal_fk_mltrng2mltrng
	DROP CONSTRAINT temporal_fk_mltrng2mltrng_fk;
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at)
	ON UPDATE RESTRICT;
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01')));
UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-01-01', '2016-02-01')) WHERE id = '[5,6)';
DELETE FROM temporal_mltrng WHERE id = '[5,6)';
INSERT INTO temporal_mltrng (id, valid_at) VALUES
  ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01'))),
  ('[5,6)', datemultirange(daterange('2018-02-01', '2018-03-01')));
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[3,4)', datemultirange(daterange('2018-01-05', '2018-01-10')), '[5,6)');
UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-02-01', '2016-03-01'))
WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-02-01', '2018-03-01'));
BEGIN;
  ALTER TABLE temporal_fk_mltrng2mltrng
    ALTER CONSTRAINT temporal_fk_mltrng2mltrng_fk
    DEFERRABLE INITIALLY DEFERRED;

  UPDATE temporal_mltrng SET valid_at = datemultirange(daterange('2016-01-01', '2016-02-01'))
  WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));
ROLLBACK;
UPDATE temporal_mltrng SET id = '[7,8)'
WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));


TRUNCATE temporal_mltrng, temporal_fk_mltrng2mltrng;
ALTER TABLE temporal_fk_mltrng2mltrng
	DROP CONSTRAINT temporal_fk_mltrng2mltrng_fk;
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at);
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01')));
DELETE FROM temporal_mltrng WHERE id = '[5,6)';
INSERT INTO temporal_mltrng (id, valid_at) VALUES
  ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01'))),
  ('[5,6)', datemultirange(daterange('2018-02-01', '2018-03-01')));
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[3,4)', datemultirange(daterange('2018-01-05', '2018-01-10')), '[5,6)');
DELETE FROM temporal_mltrng WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-02-01', '2018-03-01'));
DELETE FROM temporal_mltrng WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));
BEGIN;
  ALTER TABLE temporal_fk_mltrng2mltrng
    ALTER CONSTRAINT temporal_fk_mltrng2mltrng_fk
    DEFERRABLE INITIALLY DEFERRED;

  DELETE FROM temporal_mltrng WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));
COMMIT;


TRUNCATE temporal_mltrng, temporal_fk_mltrng2mltrng;
ALTER TABLE temporal_fk_mltrng2mltrng
	DROP CONSTRAINT temporal_fk_mltrng2mltrng_fk;
ALTER TABLE temporal_fk_mltrng2mltrng
	ADD CONSTRAINT temporal_fk_mltrng2mltrng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_mltrng (id, PERIOD valid_at)
	ON DELETE RESTRICT;
INSERT INTO temporal_mltrng (id, valid_at) VALUES ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01')));
DELETE FROM temporal_mltrng WHERE id = '[5,6)';
INSERT INTO temporal_mltrng (id, valid_at) VALUES
  ('[5,6)', datemultirange(daterange('2018-01-01', '2018-02-01'))),
  ('[5,6)', datemultirange(daterange('2018-02-01', '2018-03-01')));
INSERT INTO temporal_fk_mltrng2mltrng (id, valid_at, parent_id) VALUES ('[3,4)', datemultirange(daterange('2018-01-05', '2018-01-10')), '[5,6)');
DELETE FROM temporal_mltrng WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-02-01', '2018-03-01'));
BEGIN;
  ALTER TABLE temporal_fk_mltrng2mltrng
    ALTER CONSTRAINT temporal_fk_mltrng2mltrng_fk
    DEFERRABLE INITIALLY DEFERRED;

  DELETE FROM temporal_mltrng WHERE id = '[5,6)' AND valid_at = datemultirange(daterange('2018-01-01', '2018-02-01'));
ROLLBACK;


CREATE TABLE temporal_box (
  id int4range,
  valid_at box,
  CONSTRAINT temporal_box_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
);

CREATE TABLE temporal_fk_box2box (
  id int4range,
  valid_at box,
  parent_id int4range,
  CONSTRAINT temporal_fk_box2box_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
  CONSTRAINT temporal_fk_box2box_fk FOREIGN KEY (parent_id, PERIOD valid_at)
    REFERENCES temporal_box (id, PERIOD valid_at)
);


CREATE TABLE temporal_partitioned_rng (
	id int4range,
	valid_at daterange,
  name text,
	CONSTRAINT temporal_paritioned_rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS)
) PARTITION BY LIST (id);
CREATE TABLE tp1 partition OF temporal_partitioned_rng FOR VALUES IN ('[1,2)', '[3,4)', '[5,6)', '[7,8)', '[9,10)', '[11,12)');
CREATE TABLE tp2 partition OF temporal_partitioned_rng FOR VALUES IN ('[2,3)', '[4,5)', '[6,7)', '[8,9)', '[10,11)', '[12,13)');
INSERT INTO temporal_partitioned_rng (id, valid_at, name) VALUES
  ('[1,2)', daterange('2000-01-01', '2000-02-01'), 'one'),
  ('[1,2)', daterange('2000-02-01', '2000-03-01'), 'one'),
  ('[2,3)', daterange('2000-01-01', '2010-01-01'), 'two');

CREATE TABLE temporal_partitioned_fk_rng2rng (
	id int4range,
	valid_at daterange,
	parent_id int4range,
	CONSTRAINT temporal_partitioned_fk_rng2rng_pk PRIMARY KEY (id, valid_at WITHOUT OVERLAPS),
	CONSTRAINT temporal_partitioned_fk_rng2rng_fk FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_partitioned_rng (id, PERIOD valid_at)
) PARTITION BY LIST (id);
CREATE TABLE tfkp1 partition OF temporal_partitioned_fk_rng2rng FOR VALUES IN ('[1,2)', '[3,4)', '[5,6)', '[7,8)', '[9,10)', '[11,12)');
CREATE TABLE tfkp2 partition OF temporal_partitioned_fk_rng2rng FOR VALUES IN ('[2,3)', '[4,5)', '[6,7)', '[8,9)', '[10,11)', '[12,13)');


INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES
  ('[1,2)', daterange('2000-01-01', '2000-02-15'), '[1,2)'),
  ('[1,2)', daterange('2001-01-01', '2002-01-01'), '[2,3)'),
  ('[2,3)', daterange('2000-01-01', '2000-02-15'), '[1,2)');
INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES
  ('[3,4)', daterange('2010-01-01', '2010-02-15'), '[1,2)');
INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES
  ('[3,4)', daterange('2000-01-01', '2000-02-15'), '[3,4)');


UPDATE temporal_partitioned_fk_rng2rng SET valid_at = daterange('2000-01-01', '2000-02-13') WHERE id = '[2,3)';
UPDATE temporal_partitioned_fk_rng2rng SET id = '[4,5)' WHERE id = '[1,2)';
UPDATE temporal_partitioned_fk_rng2rng SET id = '[1,2)' WHERE id = '[4,5)';
UPDATE temporal_partitioned_fk_rng2rng SET valid_at = daterange('2000-01-01', '2000-04-01') WHERE id = '[1,2)';


TRUNCATE temporal_partitioned_rng, temporal_partitioned_fk_rng2rng;
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2016-01-01', '2016-02-01'));
UPDATE temporal_partitioned_rng SET valid_at = daterange('2018-01-01', '2018-02-01') WHERE id = '[5,6)';
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
UPDATE temporal_partitioned_rng SET valid_at = daterange('2016-02-01', '2016-03-01')
  WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
UPDATE temporal_partitioned_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
  WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


TRUNCATE temporal_partitioned_rng, temporal_partitioned_fk_rng2rng;
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
DELETE FROM temporal_partitioned_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
DELETE FROM temporal_partitioned_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


TRUNCATE temporal_partitioned_rng, temporal_partitioned_fk_rng2rng;
ALTER TABLE temporal_partitioned_fk_rng2rng
	DROP CONSTRAINT temporal_partitioned_fk_rng2rng_fk;
ALTER TABLE temporal_partitioned_fk_rng2rng
	ADD CONSTRAINT temporal_partitioned_fk_rng2rng_fk
	FOREIGN KEY (parent_id, PERIOD valid_at)
	REFERENCES temporal_partitioned_rng
	ON DELETE RESTRICT;
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2016-01-01', '2016-02-01'));
UPDATE temporal_partitioned_rng SET valid_at = daterange('2018-01-01', '2018-02-01') WHERE id = '[5,6)';
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
UPDATE temporal_partitioned_rng SET valid_at = daterange('2016-02-01', '2016-03-01')
  WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
UPDATE temporal_partitioned_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
  WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


TRUNCATE temporal_partitioned_rng, temporal_partitioned_fk_rng2rng;
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
INSERT INTO temporal_partitioned_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-02-01', '2018-03-01'));
INSERT INTO temporal_partitioned_fk_rng2rng (id, valid_at, parent_id) VALUES ('[3,4)', daterange('2018-01-05', '2018-01-10'), '[5,6)');
DELETE FROM temporal_partitioned_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
DELETE FROM temporal_partitioned_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');


ALTER TABLE temporal_partitioned_fk_rng2rng
	DROP CONSTRAINT temporal_partitioned_fk_rng2rng_fk,
	ADD CONSTRAINT temporal_partitioned_fk_rng2rng_fk
		FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_partitioned_rng
		ON DELETE CASCADE ON UPDATE CASCADE;



ALTER TABLE temporal_partitioned_fk_rng2rng
	DROP CONSTRAINT temporal_partitioned_fk_rng2rng_fk,
	ADD CONSTRAINT temporal_partitioned_fk_rng2rng_fk
		FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_partitioned_rng
		ON DELETE SET NULL ON UPDATE SET NULL;



ALTER TABLE temporal_partitioned_fk_rng2rng
  ALTER COLUMN parent_id SET DEFAULT '[-1,-1]',
	DROP CONSTRAINT temporal_partitioned_fk_rng2rng_fk,
	ADD CONSTRAINT temporal_partitioned_fk_rng2rng_fk
		FOREIGN KEY (parent_id, PERIOD valid_at)
		REFERENCES temporal_partitioned_rng
		ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


DROP TABLE temporal_partitioned_fk_rng2rng;
DROP TABLE temporal_partitioned_rng;

RESET datestyle;
