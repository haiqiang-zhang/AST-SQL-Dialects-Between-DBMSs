SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS type_json_src;
DROP TABLE IF EXISTS type_json_dst;
CREATE TABLE type_json_src (id UInt32, data JSON) ENGINE = MergeTree ORDER BY id;
CREATE TABLE type_json_dst AS type_json_src;
INSERT INTO type_json_src VALUES (1, '{"k1": 1, "k2": "foo"}');
INSERT INTO type_json_dst SELECT * FROM type_json_src;
