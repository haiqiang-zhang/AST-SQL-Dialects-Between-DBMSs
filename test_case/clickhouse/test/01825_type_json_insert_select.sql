SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS type_json_src;
DROP TABLE IF EXISTS type_json_dst;
CREATE TABLE type_json_src (id UInt32, data JSON) ENGINE = MergeTree ORDER BY id;
CREATE TABLE type_json_dst AS type_json_src;
INSERT INTO type_json_src VALUES (1, '{"k1": 1, "k2": "foo"}');
INSERT INTO type_json_dst SELECT * FROM type_json_src;
SELECT DISTINCT toTypeName(data) FROM type_json_dst;
SELECT id, data FROM type_json_dst ORDER BY id;
INSERT INTO type_json_src VALUES (2, '{"k1": 2, "k2": "bar"}') (3, '{"k1": 3, "k3": "aaa"}');
INSERT INTO type_json_dst SELECT * FROM type_json_src WHERE id > 1;
SELECT DISTINCT toTypeName(data) FROM type_json_dst;
SELECT id, data FROM type_json_dst ORDER BY id;
INSERT INTO type_json_dst VALUES (4, '{"arr": [{"k11": 5, "k22": 6}, {"k11": 7, "k33": 8}]}');
INSERT INTO type_json_src VALUES (5, '{"arr": "not array"}');
TRUNCATE TABLE type_json_src;
SELECT DISTINCT toTypeName(data) FROM type_json_dst;
SELECT id, data FROM type_json_dst ORDER BY id;
DROP TABLE type_json_src;
DROP TABLE type_json_dst;
CREATE TABLE type_json_src (data String) ENGINE = MergeTree ORDER BY tuple();
SYSTEM STOP MERGES type_json_src;
SET max_threads = 1;
SET max_insert_threads = 1;
TRUNCATE TABLE type_json_src;
DROP TABLE type_json_src;
