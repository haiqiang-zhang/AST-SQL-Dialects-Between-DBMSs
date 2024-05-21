SET datestyle TO ISO, YMD;
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng_pk';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng_pk';
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng2_pk';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng2_pk';
CREATE TYPE textrange2 AS range (subtype=text, collation="C");
DROP TYPE textrange2;
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_mltrng2_pk';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_mltrng2_pk';
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
SELECT pg_get_indexdef(conindid, 0, true) FROM pg_constraint WHERE conname = 'temporal_rng3_uq';
CREATE TYPE textrange2 AS range (subtype=text, collation="C");
DROP TYPE textrange2;
CREATE TABLE temporal_rng (
	id int4range,
	valid_at daterange
);
CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange
);
CREATE INDEX idx_temporal3_uq ON temporal3 USING gist (id, valid_at);
DROP TABLE temporal3;
CREATE TABLE temporal3 (
	id int4range,
	valid_at daterange
);
CREATE INDEX idx_temporal3_uq ON temporal3 USING gist (id, valid_at);
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
DROP TABLE temporal3;
CREATE TABLE temporal3 (
	id int4range
);
DROP TABLE temporal3;
INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-01-02', '2018-02-03'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-03-03', '2018-04-04'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[2,3)', daterange('2018-01-01', '2018-01-05'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[3,4)', daterange('2018-01-01', NULL));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-01-01', '2018-01-05'));
INSERT INTO temporal_rng (id, valid_at) VALUES (NULL, daterange('2018-01-01', '2018-01-05'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[3,4)', NULL);
DROP TABLE temporal_rng;
CREATE TABLE temporal_rng (id int4range, valid_at daterange);
DELETE FROM temporal_rng;
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[1,2)', daterange('2018-01-02', '2018-02-03')),
  ('[1,2)', daterange('2018-03-03', '2018-04-04')),
  ('[2,3)', daterange('2018-01-01', '2018-01-05')),
  ('[3,4)', daterange('2018-01-01', NULL));
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_fk_rng2rng_fk';
INSERT INTO temporal_rng (id, valid_at) VALUES ('[1,2)', daterange('2018-02-03', '2018-03-03'));
BEGIN;
INSERT INTO temporal_rng (id, valid_at) VALUES
    ('[5,6)', daterange('2018-01-01', '2018-02-01')),
    ('[5,6)', daterange('2018-02-01', '2018-03-01'));
COMMIT;
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01') WHERE id = '[5,6)';
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
UPDATE temporal_rng SET valid_at = daterange('2016-02-01', '2016-03-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
BEGIN;
COMMIT;
UPDATE temporal_rng SET id = '[7,8)'
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01') WHERE id = '[5,6)';
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
UPDATE temporal_rng SET valid_at = daterange('2016-02-01', '2016-03-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
BEGIN;
ROLLBACK;
UPDATE temporal_rng SET id = '[7,8)'
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
UPDATE temporal_rng SET valid_at = daterange('2016-01-01', '2016-02-01')
WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
BEGIN;
COMMIT;
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
INSERT INTO temporal_rng (id, valid_at) VALUES ('[5,6)', daterange('2018-01-01', '2018-02-01'));
DELETE FROM temporal_rng WHERE id = '[5,6)';
INSERT INTO temporal_rng (id, valid_at) VALUES
  ('[5,6)', daterange('2018-01-01', '2018-02-01')),
  ('[5,6)', daterange('2018-02-01', '2018-03-01'));
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-02-01', '2018-03-01');
BEGIN;
ROLLBACK;
DELETE FROM temporal_rng WHERE id = '[5,6)' AND valid_at = daterange('2018-01-01', '2018-02-01');
INSERT INTO temporal_rng (id, valid_at) VALUES ('[6,7)', daterange('2018-01-01', '2021-01-01'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[9,10)', daterange('2018-01-01', '2021-01-01'));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[-1,-1]', daterange(null, null));
INSERT INTO temporal_rng (id, valid_at) VALUES ('[12,13)', daterange('2018-01-01', '2021-01-01'));
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conname = 'temporal_fk_mltrng2mltrng_fk';
BEGIN;
COMMIT;
BEGIN;
COMMIT;
BEGIN;
ROLLBACK;
BEGIN;
COMMIT;
BEGIN;
ROLLBACK;
RESET datestyle;
