CREATE TABLE guid1
(
	guid_field UUID,
	text_field TEXT DEFAULT(now())
);
CREATE TABLE guid2
(
	guid_field UUID,
	text_field TEXT DEFAULT(now())
);
SELECT pg_input_is_valid('11', 'uuid');
SELECT * FROM pg_input_error_info('11', 'uuid');
INSERT INTO guid1(guid_field) VALUES('11111111-1111-1111-1111-111111111111');
INSERT INTO guid1(guid_field) VALUES('{22222222-2222-2222-2222-222222222222}');
INSERT INTO guid1(guid_field) VALUES('3f3e3c3b3a3039383736353433a2313e');
SELECT guid_field FROM guid1;
SELECT guid_field FROM guid1 ORDER BY guid_field ASC;
SELECT guid_field FROM guid1 ORDER BY guid_field DESC;
SELECT COUNT(*) FROM guid1 WHERE guid_field = '3f3e3c3b-3a30-3938-3736-353433a2313e';
CREATE INDEX guid1_btree ON guid1 USING BTREE (guid_field);
CREATE INDEX guid1_hash  ON guid1 USING HASH  (guid_field);
CREATE UNIQUE INDEX guid1_unique_BTREE ON guid1 USING BTREE (guid_field);
SELECT count(*) FROM pg_class WHERE relkind='i' AND relname LIKE 'guid%';
INSERT INTO guid1(guid_field) VALUES('44444444-4444-4444-4444-444444444444');
INSERT INTO guid2(guid_field) VALUES('11111111-1111-1111-1111-111111111111');
INSERT INTO guid2(guid_field) VALUES('{22222222-2222-2222-2222-222222222222}');
INSERT INTO guid2(guid_field) VALUES('3f3e3c3b3a3039383736353433a2313e');
TRUNCATE guid1;
INSERT INTO guid1 (guid_field) VALUES (gen_random_uuid());
INSERT INTO guid1 (guid_field) VALUES (gen_random_uuid());
DROP TABLE guid1, guid2 CASCADE;
