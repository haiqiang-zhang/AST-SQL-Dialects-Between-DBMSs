SET search_path = fast_default;
CREATE SCHEMA fast_default;
CREATE TABLE m(id OID);
INSERT INTO m VALUES (NULL::OID);
END;
END;
end;
CREATE TABLE has_volatile AS
SELECT * FROM generate_series(1,10) id;
ALTER TABLE has_volatile ADD col1 int;
ALTER TABLE has_volatile ADD col2 int DEFAULT 1;
ALTER TABLE has_volatile ADD col3 timestamptz DEFAULT current_timestamp;
ALTER TABLE has_volatile ADD col4 int DEFAULT (random() * 10000)::int;
CREATE TABLE T(pk INT NOT NULL PRIMARY KEY, c_int INT DEFAULT 1);
INSERT INTO T VALUES (1), (2);
ALTER TABLE T ADD COLUMN c_bpchar BPCHAR(5) DEFAULT 'hello',
              ALTER COLUMN c_int SET DEFAULT 2;
INSERT INTO T VALUES (3), (4);
ALTER TABLE T ADD COLUMN c_text TEXT  DEFAULT 'world',
              ALTER COLUMN c_bpchar SET DEFAULT 'dog';
INSERT INTO T VALUES (5), (6);
ALTER TABLE T ADD COLUMN c_date DATE DEFAULT '2016-06-02',
              ALTER COLUMN c_text SET DEFAULT 'cat';
INSERT INTO T VALUES (7), (8);
ALTER TABLE T ADD COLUMN c_timestamp TIMESTAMP DEFAULT '2016-09-01 12:00:00',
              ADD COLUMN c_timestamp_null TIMESTAMP,
              ALTER COLUMN c_date SET DEFAULT '2010-01-01';
INSERT INTO T VALUES (9), (10);
ALTER TABLE T ADD COLUMN c_array TEXT[]
                  DEFAULT '{"This", "is", "the", "real", "world"}',
              ALTER COLUMN c_timestamp SET DEFAULT '1970-12-31 11:12:13',
              ALTER COLUMN c_timestamp_null SET DEFAULT '2016-09-29 12:00:00';
INSERT INTO T VALUES (11), (12);
ALTER TABLE T ADD COLUMN c_small SMALLINT DEFAULT -5,
              ADD COLUMN c_small_null SMALLINT,
              ALTER COLUMN c_array
                  SET DEFAULT '{"This", "is", "no", "fantasy"}';
INSERT INTO T VALUES (13), (14);
ALTER TABLE T ADD COLUMN c_big BIGINT DEFAULT 180000000000018,
              ALTER COLUMN c_small SET DEFAULT 9,
              ALTER COLUMN c_small_null SET DEFAULT 13;
INSERT INTO T VALUES (15), (16);
ALTER TABLE T ADD COLUMN c_num NUMERIC DEFAULT 1.00000000001,
              ALTER COLUMN c_big SET DEFAULT -9999999999999999;
INSERT INTO T VALUES (17), (18);
ALTER TABLE T ADD COLUMN c_time TIME DEFAULT '12:00:00',
              ALTER COLUMN c_num SET DEFAULT 2.000000000000002;
INSERT INTO T VALUES (19), (20);
ALTER TABLE T ADD COLUMN c_interval INTERVAL DEFAULT '1 day',
              ALTER COLUMN c_time SET DEFAULT '23:59:59';
INSERT INTO T VALUES (21), (22);
ALTER TABLE T ADD COLUMN c_hugetext TEXT DEFAULT repeat('abcdefg',1000),
              ALTER COLUMN c_interval SET DEFAULT '3 hours';
INSERT INTO T VALUES (23), (24);
ALTER TABLE T ALTER COLUMN c_interval DROP DEFAULT,
              ALTER COLUMN c_hugetext SET DEFAULT repeat('poiuyt', 1000);
INSERT INTO T VALUES (25), (26);
ALTER TABLE T ALTER COLUMN c_bpchar    DROP DEFAULT,
              ALTER COLUMN c_date      DROP DEFAULT,
              ALTER COLUMN c_text      DROP DEFAULT,
              ALTER COLUMN c_timestamp DROP DEFAULT,
              ALTER COLUMN c_array     DROP DEFAULT,
              ALTER COLUMN c_small     DROP DEFAULT,
              ALTER COLUMN c_big       DROP DEFAULT,
              ALTER COLUMN c_num       DROP DEFAULT,
              ALTER COLUMN c_time      DROP DEFAULT,
              ALTER COLUMN c_hugetext  DROP DEFAULT;
INSERT INTO T VALUES (27), (28);
