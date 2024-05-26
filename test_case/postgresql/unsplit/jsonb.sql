CREATE TABLE testjsonb (
       j jsonb
);
SELECT '""'::jsonb;
SELECT '"abc"'::jsonb;
SELECT '"\n\"\\"'::jsonb;
SELECT '1'::jsonb;
SELECT '0'::jsonb;
SELECT '0.1'::jsonb;
SELECT '9223372036854775808'::jsonb;
SELECT '1e100'::jsonb;
SELECT '1.3e100'::jsonb;
SELECT '[]'::jsonb;
SELECT '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'::jsonb;
SELECT '[1,2]'::jsonb;
SELECT '{}'::jsonb;
SELECT '{"abc":1}'::jsonb;
SELECT '{"abc":1,"def":2,"ghi":[3,4],"hij":{"klm":5,"nop":[6]}}'::jsonb;
SELECT 'true'::jsonb;
SELECT 'false'::jsonb;
SELECT 'null'::jsonb;
SELECT ' true '::jsonb;
SELECT '{
		"one": 1,
		"two":"two",
		"three":
		true}'::jsonb;
select pg_input_is_valid('{"a":true}', 'jsonb');
select * from pg_input_error_info('{"a":true', 'jsonb');
SELECT array_to_json(ARRAY [jsonb '{"a":1}', jsonb '{"b":[2,3]}']);
CREATE TEMP TABLE rows AS
SELECT x, 'txt' || x as y
FROM generate_series(1,3) AS x;
analyze rows;
select attname, to_jsonb(histogram_bounds) histogram_bounds
from pg_stats
where tablename = 'rows' and
      schemaname = pg_my_temp_schema()::regnamespace::text
order by 1;
select to_jsonb(timestamp '2014-05-28 12:22:35.614298');
BEGIN;
SET LOCAL TIME ZONE 10.5;
SET LOCAL TIME ZONE -8;
COMMIT;
SELECT jsonb_agg(q)
  FROM ( SELECT $$a$$ || x AS b, y AS c,
               ARRAY[ROW(x.*,ARRAY[1,2,3]),
               ROW(y.*,ARRAY[4,5,6])] AS z
         FROM generate_series(1,2) x,
              generate_series(4,5) y) q;
UPDATE rows SET x = NULL WHERE x = 1;
CREATE TEMP TABLE test_jsonb (
       json_type text,
       test_json jsonb
);
INSERT INTO test_jsonb VALUES
('scalar','"a scalar"'),
('array','["zero", "one","two",null,"four","five", [1,2,3],{"f1":9}]'),
('object','{"field1":"val1","field2":"val2","field3":null, "field4": 4, "field5": [1,2,3], "field6": {"f1":9}}');
SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'scalar';
SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'array';
SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'object';
SELECT test_json -> 'field2' FROM test_jsonb WHERE json_type = 'object';
SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'scalar';
SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'array';
SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'object';
SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'scalar';
SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'array';
SELECT test_json -> 9 FROM test_jsonb WHERE json_type = 'array';
SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'object';
SELECT test_json ->> 6 FROM test_jsonb WHERE json_type = 'array';
SELECT test_json ->> 7 FROM test_jsonb WHERE json_type = 'array';
SELECT test_json ->> 'field4' FROM test_jsonb WHERE json_type = 'object';
SELECT test_json ->> 'field5' FROM test_jsonb WHERE json_type = 'object';
SELECT test_json ->> 'field6' FROM test_jsonb WHERE json_type = 'object';
SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'scalar';
SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'array';
SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'object';
SELECT jsonb_object_keys(test_json) FROM test_jsonb WHERE json_type = 'object';
SELECT (test_json->'field3') IS NULL AS expect_false FROM test_jsonb WHERE json_type = 'object';
SELECT (test_json->>'field3') IS NULL AS expect_true FROM test_jsonb WHERE json_type = 'object';
SELECT (test_json->3) IS NULL AS expect_false FROM test_jsonb WHERE json_type = 'array';
SELECT (test_json->>3) IS NULL AS expect_true FROM test_jsonb WHERE json_type = 'array';
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::text;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::int;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 1;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 'z';
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> '';
select '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 1;
select '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 3;
select '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 'z';
select '{"a": "c", "b": null}'::jsonb -> 'b';
select '"foo"'::jsonb -> 1;
select '"foo"'::jsonb -> 'z';
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::text;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::int;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 1;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 'z';
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> '';
select '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 1;
select '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 3;
select '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 'z';
select '{"a": "c", "b": null}'::jsonb ->> 'b';
select '"foo"'::jsonb ->> 1;
select '"foo"'::jsonb ->> 'z';
SELECT '{"x":"y"}'::jsonb = '{"x":"y"}'::jsonb;
SELECT '{"x":"y"}'::jsonb = '{"x":"z"}'::jsonb;
SELECT '{"x":"y"}'::jsonb <> '{"x":"y"}'::jsonb;
SELECT '{"x":"y"}'::jsonb <> '{"x":"z"}'::jsonb;
SELECT jsonb_contains('{"a":"b", "b":1, "c":null}', '{"a":"b"}');
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b"}';
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b", "c":null}';
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b", "g":null}';
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"g":null}';
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"c"}';
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b"}';
SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b", "c":"q"}';
SELECT '[1,2]'::jsonb @> '[1,2,2]'::jsonb;
SELECT '[1,1,2]'::jsonb @> '[1,2,2]'::jsonb;
SELECT '[[1,2]]'::jsonb @> '[[1,2,2]]'::jsonb;
SELECT '[1,2,2]'::jsonb <@ '[1,2]'::jsonb;
SELECT '[1,2,2]'::jsonb <@ '[1,1,2]'::jsonb;
SELECT '[[1,2,2]]'::jsonb <@ '[[1,2]]'::jsonb;
SELECT jsonb_contained('{"a":"b"}', '{"a":"b", "b":1, "c":null}');
SELECT '{"a":"b"}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '{"a":"b", "c":null}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '{"a":"b", "g":null}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '{"g":null}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '{"a":"c"}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '{"a":"b"}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '{"a":"b", "c":"q"}'::jsonb <@ '{"a":"b", "b":1, "c":null}';
SELECT '[5]'::jsonb @> '[5]';
SELECT '5'::jsonb @> '5';
SELECT '[5]'::jsonb @> '5';
SELECT '5'::jsonb @> '[5]';
SELECT '["9", ["7", "3"], 1]'::jsonb @> '["9", ["7", "3"], 1]'::jsonb;
SELECT '["9", ["7", "3"], ["1"]]'::jsonb @> '["9", ["7", "3"], ["1"]]'::jsonb;
SELECT '{ "name": "Bob", "tags": [ "enim", "qui"]}'::jsonb @> '{"tags":["qu"]}';
SELECT jsonb_array_length('[1,2,3,{"f1":1,"f2":[5,6]},4]');
SELECT jsonb_each('{"f1":[1,2,3],"f2":{"f3":1},"f4":null}');
SELECT jsonb_each('{"a":{"b":"c","c":"b","1":"first"},"b":[1,2],"c":"cc","1":"first","n":null}'::jsonb) AS q;
SELECT * FROM jsonb_each('{"f1":[1,2,3],"f2":{"f3":1},"f4":null,"f5":99,"f6":"stringy"}') q;
SELECT * FROM jsonb_each('{"a":{"b":"c","c":"b","1":"first"},"b":[1,2],"c":"cc","1":"first","n":null}'::jsonb) AS q;
SELECT jsonb_each_text('{"f1":[1,2,3],"f2":{"f3":1},"f4":null,"f5":"null"}');
SELECT jsonb_each_text('{"a":{"b":"c","c":"b","1":"first"},"b":[1,2],"c":"cc","1":"first","n":null}'::jsonb) AS q;
SELECT * FROM jsonb_each_text('{"f1":[1,2,3],"f2":{"f3":1},"f4":null,"f5":99,"f6":"stringy"}') q;
SELECT * FROM jsonb_each_text('{"a":{"b":"c","c":"b","1":"first"},"b":[1,2],"c":"cc","1":"first","n":null}'::jsonb) AS q;
SELECT jsonb_exists('{"a":null, "b":"qq"}', 'a');
SELECT jsonb '{"a":null, "b":"qq"}' ? 'a';
SELECT jsonb '{"a":null, "b":"qq"}' ? 'b';
SELECT jsonb '{"a":null, "b":"qq"}' ? 'c';
SELECT jsonb '{"a":"null", "b":"qq"}' ? 'a';
SELECT count(*) from testjsonb  WHERE j->'array' ? 'bar';
SELECT jsonb_exists_any('{"a":null, "b":"qq"}', ARRAY['a','b']);
SELECT jsonb '{"a":null, "b":"qq"}' ?| ARRAY['a','b'];
SELECT jsonb '{"a":null, "b":"qq"}' ?| ARRAY['b','a'];
SELECT jsonb '{"a":null, "b":"qq"}' ?| ARRAY['c','a'];
SELECT jsonb '{"a":null, "b":"qq"}' ?| ARRAY['c','d'];
SELECT jsonb '{"a":null, "b":"qq"}' ?| '{}'::text[];
SELECT jsonb_exists_all('{"a":null, "b":"qq"}', ARRAY['a','b']);
SELECT jsonb '{"a":null, "b":"qq"}' ?& ARRAY['a','b'];
SELECT jsonb '{"a":null, "b":"qq"}' ?& ARRAY['b','a'];
SELECT jsonb '{"a":null, "b":"qq"}' ?& ARRAY['c','a'];
SELECT jsonb '{"a":null, "b":"qq"}' ?& ARRAY['c','d'];
SELECT jsonb '{"a":null, "b":"qq"}' ?& ARRAY['a','a', 'b', 'b', 'b'];
SELECT jsonb '{"a":null, "b":"qq"}' ?& '{}'::text[];
SELECT jsonb_typeof('{}') AS object;
SELECT jsonb_typeof('{"c":3,"p":"o"}') AS object;
SELECT jsonb_typeof('[]') AS array;
SELECT jsonb_typeof('["a", 1]') AS array;
SELECT jsonb_typeof('null') AS "null";
SELECT jsonb_typeof('1') AS number;
SELECT jsonb_typeof('-1') AS number;
SELECT jsonb_typeof('1.0') AS number;
SELECT jsonb_typeof('1e2') AS number;
SELECT jsonb_typeof('-1.0') AS number;
SELECT jsonb_typeof('true') AS boolean;
SELECT jsonb_typeof('false') AS boolean;
SELECT jsonb_typeof('"hello"') AS string;
SELECT jsonb_typeof('"true"') AS string;
SELECT jsonb_typeof('"1.0"') AS string;
SELECT jsonb_build_array('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}');
SELECT jsonb_build_object('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}');
SELECT jsonb_object_agg(1, NULL::jsonb);
CREATE TEMP TABLE foo (serial_num int, name text, type text);
INSERT INTO foo VALUES (847001,'t15','GE1043');
INSERT INTO foo VALUES (847002,'t16','GE1043');
INSERT INTO foo VALUES (847003,'sub-alpha','GESS90');
INSERT INTO foo VALUES (999999, NULL, 'bar');
SELECT jsonb_object('{}');
SELECT jsonb_extract_path('{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}','f4','f6');
SELECT jsonb_extract_path_text('{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}','f4','f6');
SELECT '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>array['f4','f6'];
SELECT '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>array['f2'];
SELECT '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>array['f2','0'];
SELECT '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>array['f2','1'];
SELECT '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>>array['f4','f6'];
SELECT '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>>array['f2'];
SELECT '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>>array['f2','0'];
SELECT '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::jsonb#>>array['f2','1'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> '{}';
select '[1,2,3]'::jsonb #> '{}';
select '"foo"'::jsonb #> '{}';
select '42'::jsonb #> '{}';
select 'null'::jsonb #> '{}';
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a', null];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a', ''];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a','b'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a','b','c'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a','b','c','d'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #> array['a','z','c'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb #> array['a','1','b'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb #> array['a','z','b'];
select '[{"b": "c"}, {"b": "cc"}]'::jsonb #> array['1','b'];
select '[{"b": "c"}, {"b": "cc"}]'::jsonb #> array['z','b'];
select '[{"b": "c"}, {"b": null}]'::jsonb #> array['1','b'];
select '"foo"'::jsonb #> array['z'];
select '42'::jsonb #> array['f2'];
select '42'::jsonb #> array['0'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> '{}';
select '[1,2,3]'::jsonb #>> '{}';
select '"foo"'::jsonb #>> '{}';
select '42'::jsonb #>> '{}';
select 'null'::jsonb #>> '{}';
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a', null];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a', ''];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a','b'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a','b','c'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a','b','c','d'];
select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> array['a','z','c'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb #>> array['a','1','b'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb #>> array['a','z','b'];
select '[{"b": "c"}, {"b": "cc"}]'::jsonb #>> array['1','b'];
select '[{"b": "c"}, {"b": "cc"}]'::jsonb #>> array['z','b'];
select '[{"b": "c"}, {"b": null}]'::jsonb #>> array['1','b'];
select '"foo"'::jsonb #>> array['z'];
select '42'::jsonb #>> array['f2'];
select '42'::jsonb #>> array['0'];
SELECT jsonb_array_elements('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false]');
SELECT * FROM jsonb_array_elements('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false]') q;
SELECT jsonb_array_elements_text('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false,"stringy"]');
SELECT * FROM jsonb_array_elements_text('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false,"stringy"]') q;
CREATE TYPE jbpop AS (a text, b int, c timestamp);
CREATE DOMAIN jsb_int_not_null  AS int     NOT NULL;
CREATE DOMAIN jsb_int_array_1d  AS int[]   CHECK(array_length(VALUE, 1) = 3);
CREATE DOMAIN jsb_int_array_2d  AS int[][] CHECK(array_length(VALUE, 2) = 3);
create type jb_unordered_pair as (x int, y int);
create domain jb_ordered_pair as jb_unordered_pair check((value).x <= (value).y);
CREATE TYPE jsbrec AS (
	i	int,
	ia	_int4,
	ia1	int[],
	ia2	int[][],
	ia3	int[][][],
	ia1d	jsb_int_array_1d,
	ia2d	jsb_int_array_2d,
	t	text,
	ta	text[],
	c	char(10),
	ca	char(10)[],
	ts	timestamp,
	js	json,
	jsb	jsonb,
	jsa	json[],
	rec	jbpop,
	reca	jbpop[]
);
CREATE TYPE jsbrec_i_not_null AS (
	i	jsb_int_not_null
);
SELECT * FROM jsonb_populate_record(NULL::jbpop,'{"a":"blurfl","x":43.2}') q;
SELECT * FROM jsonb_populate_record(row('x',3,'2012-12-31 15:30:56')::jbpop,'{"a":"blurfl","x":43.2}') q;
SELECT * FROM jsonb_populate_record(NULL::jbpop,'{"a":"blurfl","x":43.2}') q;
SELECT * FROM jsonb_populate_record(row('x',3,'2012-12-31 15:30:56')::jbpop,'{"a":"blurfl","x":43.2}') q;
SELECT * FROM jsonb_populate_record(NULL::jbpop,'{"a":[100,200,false],"x":43.2}') q;
SELECT * FROM jsonb_populate_record(row('x',3,'2012-12-31 15:30:56')::jbpop,'{"a":[100,200,false],"x":43.2}') q;
SELECT * FROM jsonb_populate_record(row('x',3,'2012-12-31 15:30:56')::jbpop, '{}') q;
SELECT i FROM jsonb_populate_record(NULL::jsbrec_i_not_null, '{"i": 12345}') q;
SELECT ia FROM jsonb_populate_record(NULL::jsbrec, '{"ia": null}') q;
SELECT ia FROM jsonb_populate_record(NULL::jsbrec, '{"ia": [1, "2", null, 4]}') q;
SELECT ia FROM jsonb_populate_record(NULL::jsbrec, '{"ia": [[1, 2], [3, 4]]}') q;
SELECT ia FROM jsonb_populate_record(NULL::jsbrec, '{"ia": "{1,2,3}"}') q;
SELECT ia1 FROM jsonb_populate_record(NULL::jsbrec, '{"ia1": null}') q;
SELECT ia1 FROM jsonb_populate_record(NULL::jsbrec, '{"ia1": [1, "2", null, 4]}') q;
SELECT ia1 FROM jsonb_populate_record(NULL::jsbrec, '{"ia1": [[1, 2, 3]]}') q;
SELECT ia1d FROM jsonb_populate_record(NULL::jsbrec, '{"ia1d": null}') q;
SELECT ia1d FROM jsonb_populate_record(NULL::jsbrec, '{"ia1d": [1, "2", null]}') q;
SELECT ia2 FROM jsonb_populate_record(NULL::jsbrec, '{"ia2": [1, "2", null, 4]}') q;
SELECT ia2 FROM jsonb_populate_record(NULL::jsbrec, '{"ia2": [[1, 2], [null, 4]]}') q;
SELECT ia2 FROM jsonb_populate_record(NULL::jsbrec, '{"ia2": [[], []]}') q;
SELECT ia2d FROM jsonb_populate_record(NULL::jsbrec, '{"ia2d": [[1, "2", 3], [null, 5, 6]]}') q;
SELECT ia3 FROM jsonb_populate_record(NULL::jsbrec, '{"ia3": [1, "2", null, 4]}') q;
SELECT ia3 FROM jsonb_populate_record(NULL::jsbrec, '{"ia3": [[1, 2], [null, 4]]}') q;
SELECT ia3 FROM jsonb_populate_record(NULL::jsbrec, '{"ia3": [ [[], []], [[], []], [[], []] ]}') q;
SELECT ia3 FROM jsonb_populate_record(NULL::jsbrec, '{"ia3": [ [[1, 2]], [[3, 4]] ]}') q;
SELECT ia3 FROM jsonb_populate_record(NULL::jsbrec, '{"ia3": [ [[1, 2], [3, 4]], [[5, 6], [7, 8]] ]}') q;
SELECT ta FROM jsonb_populate_record(NULL::jsbrec, '{"ta": null}') q;
SELECT ta FROM jsonb_populate_record(NULL::jsbrec, '{"ta": [1, "2", null, 4]}') q;
SELECT c FROM jsonb_populate_record(NULL::jsbrec, '{"c": null}') q;
SELECT c FROM jsonb_populate_record(NULL::jsbrec, '{"c": "aaa"}') q;
SELECT c FROM jsonb_populate_record(NULL::jsbrec, '{"c": "aaaaaaaaaa"}') q;
SELECT ca FROM jsonb_populate_record(NULL::jsbrec, '{"ca": null}') q;
SELECT ca FROM jsonb_populate_record(NULL::jsbrec, '{"ca": [1, "2", null, 4]}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": null}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": true}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": 123.45}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": "123.45"}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": "abc"}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": [123, "123", null, {"key": "value"}]}') q;
SELECT js FROM jsonb_populate_record(NULL::jsbrec, '{"js": {"a": "bbb", "b": null, "c": 123.45}}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": null}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": true}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": 123.45}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": "123.45"}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": "abc"}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": [123, "123", null, {"key": "value"}]}') q;
SELECT jsb FROM jsonb_populate_record(NULL::jsbrec, '{"jsb": {"a": "bbb", "b": null, "c": 123.45}}') q;
SELECT jsa FROM jsonb_populate_record(NULL::jsbrec, '{"jsa": null}') q;
SELECT jsa FROM jsonb_populate_record(NULL::jsbrec, '{"jsa": [1, "2", null, 4]}') q;
SELECT jsa FROM jsonb_populate_record(NULL::jsbrec, '{"jsa": ["aaa", null, [1, 2, "3", {}], { "k" : "v" }]}') q;
SELECT rec FROM jsonb_populate_record(NULL::jsbrec, '{"rec": {"a": "abc", "c": "01.02.2003", "x": 43.2}}') q;
SELECT rec FROM jsonb_populate_record(NULL::jsbrec, '{"rec": "(abc,42,01.02.2003)"}') q;
SELECT reca FROM jsonb_populate_record(NULL::jsbrec, '{"reca": [{"a": "abc", "b": 456}, null, {"c": "01.02.2003", "x": 43.2}]}') q;
SELECT reca FROM jsonb_populate_record(NULL::jsbrec, '{"reca": ["(abc,42,01.02.2003)"]}') q;
SELECT reca FROM jsonb_populate_record(NULL::jsbrec, '{"reca": "{\"(abc,42,01.02.2003)\"}"}') q;
SELECT rec FROM jsonb_populate_record(
	row(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
		row('x',3,'2012-12-31 15:30:56')::jbpop,NULL)::jsbrec,
	'{"rec": {"a": "abc", "c": "01.02.2003", "x": 43.2}}'
) q;
create type jsb_char2 as (a char(2));
select * from jsonb_populate_record(NULL::jsb_char2, '{"a": "aa"}') q;
create type jsb_ia as (a int[]);
create type jsb_ia2 as (a int[][]);
select * from jsonb_populate_record(NULL::jsb_ia, '{"a": [1, 2]}') q;
select * from jsonb_populate_record(NULL::jsb_ia2, '{"a": [[1, 0], [2, 3]]}') q;
create domain jsb_i_not_null as int not null;
create domain jsb_i_gt_1 as int check (value > 1);
create type jsb_i_not_null_rec as (a jsb_i_not_null);
create type jsb_i_gt_1_rec as (a jsb_i_gt_1);
select * from jsonb_populate_record(NULL::jsb_i_not_null_rec, '{"a": 1}') q;
select * from jsonb_populate_record(NULL::jsb_i_gt_1_rec, '{"a": 2}') q;
drop type jsb_ia, jsb_ia2, jsb_char2, jsb_i_not_null_rec, jsb_i_gt_1_rec;
drop domain jsb_i_not_null, jsb_i_gt_1;
SELECT jsonb_populate_record(row(1,2), '{"f1": 0, "f2": 1}');
SELECT * FROM
  jsonb_populate_record(null::record, '{"x": 776}') AS (x int, y int);
SELECT * FROM jsonb_populate_recordset(NULL::jbpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(row('def',99,NULL)::jbpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(NULL::jbpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(row('def',99,NULL)::jbpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(row('def',99,NULL)::jbpop,'[{"a":[100,200,300],"x":43.2},{"a":{"z":true},"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(NULL::jbpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(row('def',99,NULL)::jbpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT * FROM jsonb_populate_recordset(row('def',99,NULL)::jbpop,'[{"a":[100,200,300],"x":43.2},{"a":{"z":true},"b":3,"c":"2012-01-20 10:42:53"}]') q;
SELECT jsonb_populate_recordset(row(1,2), '[{"f1": 0, "f2": 1}]');
SELECT i, jsonb_populate_recordset(row(i,50), '[{"f1":"42"},{"f2":"43"}]')
FROM (VALUES (1),(2)) v(i);
SELECT * FROM
  jsonb_populate_recordset(null::record, '[{"x": 776}]') AS (x int, y int);
SELECT * FROM jsonb_populate_recordset(NULL::jbpop,'[]') q;
SELECT * FROM
  jsonb_populate_recordset(null::record, '[]') AS (x int, y int);
select * from jsonb_to_record('{"a":1,"b":"foo","c":"bar"}')
    as x(a int, b text, d text);
select * from jsonb_to_recordset('[{"a":1,"b":"foo","d":false},{"a":2,"b":"bar","c":true}]')
    as x(a int, b text, c boolean);
select *, c is null as c_is_null
from jsonb_to_record('{"a":1, "b":{"c":16, "d":2}, "x":8, "ca": ["1 2", 3], "ia": [[1,2],[3,4]], "r": {"a": "aaa", "b": 123}}'::jsonb)
    as t(a int, b jsonb, c text, x int, ca char(5)[], ia int[][], r jbpop);
select *, c is null as c_is_null
from jsonb_to_recordset('[{"a":1, "b":{"c":16, "d":2}, "x":8}]'::jsonb)
    as t(a int, b jsonb, c text, x int);
select * from jsonb_to_record('{"ia": null}') as x(ia _int4);
select * from jsonb_to_record('{"ia": [1, "2", null, 4]}') as x(ia _int4);
select * from jsonb_to_record('{"ia": [[1, 2], [3, 4]]}') as x(ia _int4);
select * from jsonb_to_record('{"ia2": [1, 2, 3]}') as x(ia2 int[][]);
select * from jsonb_to_record('{"ia2": [[1, 2], [3, 4]]}') as x(ia2 int4[][]);
select * from jsonb_to_record('{"ia2": [[[1], [2], [3]]]}') as x(ia2 int4[][]);
select * from jsonb_to_record('{"out": {"key": 1}}') as x(out json);
select * from jsonb_to_record('{"out": [{"key": 1}]}') as x(out json);
select * from jsonb_to_record('{"out": "{\"key\": 1}"}') as x(out json);
select * from jsonb_to_record('{"out": {"key": 1}}') as x(out jsonb);
select * from jsonb_to_record('{"out": [{"key": 1}]}') as x(out jsonb);
select * from jsonb_to_record('{"out": "{\"key\": 1}"}') as x(out jsonb);
CREATE TEMP TABLE jsbpoptest (js jsonb);
INSERT INTO jsbpoptest
SELECT '{
	"jsa": [1, "2", null, 4],
	"rec": {"a": "abc", "c": "01.02.2003", "x": 43.2},
	"reca": [{"a": "abc", "b": 456}, null, {"c": "01.02.2003", "x": 43.2}]
}'::jsonb
FROM generate_series(1, 3);
SELECT (jsonb_populate_record(NULL::jsbrec, js)).* FROM jsbpoptest;
DROP TYPE jsbrec;
DROP TYPE jsbrec_i_not_null;
DROP DOMAIN jsb_int_not_null;
DROP DOMAIN jsb_int_array_1d;
DROP DOMAIN jsb_int_array_2d;
DROP DOMAIN jb_ordered_pair;
DROP TYPE jb_unordered_pair;
CREATE INDEX jidx ON testjsonb USING gin (j);
SET enable_seqscan = off;
EXPLAIN (COSTS OFF)
SELECT count(*) FROM testjsonb WHERE j @@ '$.wait == null';
CREATE INDEX jidx_array ON testjsonb USING gin((j->'array'));
RESET enable_seqscan;
SET enable_hashagg = off;
SET enable_hashagg = on;
SET enable_sort = off;
SELECT distinct * FROM (values (jsonb '{}' || ''::text),('{}')) v(j);
SET enable_sort = on;
RESET enable_hashagg;
RESET enable_sort;
DROP INDEX jidx;
DROP INDEX jidx_array;
CREATE INDEX jidx ON testjsonb USING btree (j);
SET enable_seqscan = off;
DROP INDEX jidx;
CREATE INDEX jidx ON testjsonb USING gin (j jsonb_path_ops);
SET enable_seqscan = off;
RESET enable_seqscan;
DROP INDEX jidx;
SELECT '{"ff":{"a":12,"b":16}}'::jsonb;
SELECT '{"ff":{"a":12,"b":16},"qq":123}'::jsonb;
SELECT '{"aa":["a","aaa"],"qq":{"a":12,"b":16,"c":["c1","c2"],"d":{"d1":"d1","d2":"d2","d1":"d3"}}}'::jsonb;
SELECT '{"aa":["a","aaa"],"qq":{"a":"12","b":"16","c":["c1","c2"],"d":{"d1":"d1","d2":"d2"}}}'::jsonb;
SELECT '{"aa":["a","aaa"],"qq":{"a":"12","b":"16","c":["c1","c2",["c3"],{"c4":4}],"d":{"d1":"d1","d2":"d2"}}}'::jsonb;
SELECT '{"ff":["a","aaa"]}'::jsonb;
SELECT
  '{"ff":{"a":12,"b":16},"qq":123,"x":[1,2],"Y":null}'::jsonb -> 'ff',
  '{"ff":{"a":12,"b":16},"qq":123,"x":[1,2],"Y":null}'::jsonb -> 'qq',
  ('{"ff":{"a":12,"b":16},"qq":123,"x":[1,2],"Y":null}'::jsonb -> 'Y') IS NULL AS f,
  ('{"ff":{"a":12,"b":16},"qq":123,"x":[1,2],"Y":null}'::jsonb ->> 'Y') IS NULL AS t,
   '{"ff":{"a":12,"b":16},"qq":123,"x":[1,2],"Y":null}'::jsonb -> 'x';
SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[1,2]}';
SELECT '{"a":[2,1],"c":"b"}'::jsonb @> '{"a":[1,2]}';
SELECT '{"a":{"1":2},"c":"b"}'::jsonb @> '{"a":[1,2]}';
SELECT '{"a":{"2":1},"c":"b"}'::jsonb @> '{"a":[1,2]}';
SELECT '{"a":{"1":2},"c":"b"}'::jsonb @> '{"a":{"1":2}}';
SELECT '{"a":{"2":1},"c":"b"}'::jsonb @> '{"a":{"1":2}}';
SELECT '["a","b"]'::jsonb @> '["a","b","c","b"]';
SELECT '["a","b","c","b"]'::jsonb @> '["a","b"]';
SELECT '["a","b","c",[1,2]]'::jsonb @> '["a",[1,2]]';
SELECT '["a","b","c",[1,2]]'::jsonb @> '["b",[1,2]]';
SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[1]}';
SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[2]}';
SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[3]}';
SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"c":3}]}';
SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"x":4}]}';
SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"x":4},3]}';
SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"x":4},1]}';
create temp table nestjsonb (j jsonb);
insert into nestjsonb (j) values ('{"a":[["b",{"x":1}],["b",{"x":2}]],"c":3}');
insert into nestjsonb (j) values ('[[14,2,3]]');
insert into nestjsonb (j) values ('[1,[14,2,3]]');
create index on nestjsonb using gin(j jsonb_path_ops);
set enable_seqscan = on;
set enable_bitmapscan = off;
select * from nestjsonb where j @> '{"a":[[{"x":2}]]}'::jsonb;
select * from nestjsonb where j @> '{"c":3}';
select * from nestjsonb where j @> '[[14]]';
set enable_seqscan = off;
set enable_bitmapscan = on;
select * from nestjsonb where j @> '{"a":[[{"x":2}]]}'::jsonb;
select * from nestjsonb where j @> '{"c":3}';
select * from nestjsonb where j @> '[[14]]';
reset enable_seqscan;
reset enable_bitmapscan;
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'n';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'a';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'b';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'c';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'd';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'd' -> '1';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'e';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 0;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 0;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 1;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 2;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 3;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 3 -> 1;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 4;
SELECT '["a","b","c",[1,2],null]'::jsonb -> 5;
SELECT '["a","b","c",[1,2],null]'::jsonb -> -1;
SELECT '["a","b","c",[1,2],null]'::jsonb -> -5;
SELECT '["a","b","c",[1,2],null]'::jsonb -> -6;
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{0}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{a}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,0}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,1}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,2}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,3}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,-1}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,-3}';
SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,-4}';
SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{0}';
SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{3}';
SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{4}';
SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{4,5}';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'n';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'a';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'b';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'c';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'd';
SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'e';
select jsonb_strip_nulls(null);
select jsonb_pretty('{"a": "test", "b": [1, 2, 3], "c": "test3", "d":{"dd": "test4", "dd2":{"ddd": "test5"}}}');
select jsonb_concat('{"d": "test", "a": [1, 2]}', '{"g": "test2", "c": {"c1":1, "c2":2}}');
select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{"cq":"l", "b":"g", "fg":false}';
select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{"aq":"l"}';
select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{"aa":"l"}';
select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{}';
select '["a", "b"]'::jsonb || '["c"]';
select '["a", "b"]'::jsonb || '["c", "d"]';
select '["c"]' || '["a", "b"]'::jsonb;
select '["a", "b"]'::jsonb || '"c"';
select '"c"' || '["a", "b"]'::jsonb;
select '[]'::jsonb || '["a"]'::jsonb;
select '[]'::jsonb || '"a"'::jsonb;
select '"b"'::jsonb || '"a"'::jsonb;
select '{}'::jsonb || '{"a":"b"}'::jsonb;
select '[]'::jsonb || '{"a":"b"}'::jsonb;
select '{"a":"b"}'::jsonb || '[]'::jsonb;
select '"a"'::jsonb || '{"a":1}';
select '{"a":1}' || '"a"'::jsonb;
select '[3]'::jsonb || '{}'::jsonb;
select '3'::jsonb || '[]'::jsonb;
select '3'::jsonb || '4'::jsonb;
select '3'::jsonb || '{}'::jsonb;
select '["a", "b"]'::jsonb || '{"c":1}';
select '{"c": 1}'::jsonb || '["a", "b"]';
select '{}'::jsonb || '{"cq":"l", "b":"g", "fg":false}';
select pg_column_size('{}'::jsonb || '{}'::jsonb) = pg_column_size('{}'::jsonb);
select pg_column_size('{"aa":1}'::jsonb || '{"b":2}'::jsonb) = pg_column_size('{"aa":1, "b":2}'::jsonb);
select pg_column_size('{"aa":1, "b":2}'::jsonb || '{}'::jsonb) = pg_column_size('{"aa":1, "b":2}'::jsonb);
select pg_column_size('{}'::jsonb || '{"aa":1, "b":2}'::jsonb) = pg_column_size('{"aa":1, "b":2}'::jsonb);
select jsonb_delete('{"a":1 , "b":2, "c":3}'::jsonb, 'a');
select '{"a":1 , "b":2, "c":3}'::jsonb - 'a';
select '{"a":null , "b":2, "c":3}'::jsonb - 'a';
select '{"a":1 , "b":2, "c":3}'::jsonb - 'b';
select '{"a":1 , "b":2, "c":3}'::jsonb - 'c';
select '{"a":1 , "b":2, "c":3}'::jsonb - 'd';
select pg_column_size('{"a":1 , "b":2, "c":3}'::jsonb - 'b') = pg_column_size('{"a":1, "b":2}'::jsonb);
select '["a","b","c"]'::jsonb - 3;
select '["a","b","c"]'::jsonb - 2;
select '["a","b","c"]'::jsonb - 1;
select '["a","b","c"]'::jsonb - 0;
select '["a","b","c"]'::jsonb - -1;
select '["a","b","c"]'::jsonb - -2;
select '["a","b","c"]'::jsonb - -3;
select '["a","b","c"]'::jsonb - -4;
select '{"a":1 , "b":2, "c":3}'::jsonb - '{b}'::text[];
select '{"a":1 , "b":2, "c":3}'::jsonb - '{c,b}'::text[];
select '{"a":1 , "b":2, "c":3}'::jsonb - '{}'::text[];
select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{n}', '[1,2,3]');
select jsonb_delete_path('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}', '{n}');
select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{n}';
select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{b,-1}';
select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{d,1,0}';
select '{}'::jsonb - 'a';
select '[]'::jsonb - 'a';
select '[]'::jsonb - 1;
select '{}'::jsonb #- '{a}';
select '[]'::jsonb #- '{a}';
select jsonb_set_lax('{"a":1,"b":2}','{b}','5');
select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'return_target') as return_target;
select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'delete_key') as delete_key;
select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'use_json_null') as use_json_null;
select jsonb_insert('{"a": [0,1,2]}', '{a, 1}', '"new_value"');
select ('123'::jsonb)['a'];
select ('123'::jsonb)[0];
select ('123'::jsonb)[NULL];
select ('{"a": 1}'::jsonb)['a'];
select ('{"a": 1}'::jsonb)[0];
select ('{"a": 1}'::jsonb)['not_exist'];
select ('{"a": 1}'::jsonb)[NULL];
select ('[1, "2", null]'::jsonb)['a'];
select ('[1, "2", null]'::jsonb)[0];
select ('[1, "2", null]'::jsonb)['1'];
select ('[1, "2", null]'::jsonb)[2];
select ('[1, "2", null]'::jsonb)[3];
select ('[1, "2", null]'::jsonb)[-2];
select ('[1, "2", null]'::jsonb)[1]['a'];
select ('[1, "2", null]'::jsonb)[1][0];
select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['b'];
select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d'];
select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d'][1];
select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d']['a'];
select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1'];
select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']['a2'];
select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']['a2']['a3'];
select ('{"a": ["a1", {"b1": ["aaa", "bbb", "ccc"]}], "b": "bb"}'::jsonb)['a'][1]['b1'];
select ('{"a": ["a1", {"b1": ["aaa", "bbb", "ccc"]}], "b": "bb"}'::jsonb)['a'][1]['b1'][2];
create TEMP TABLE test_jsonb_subscript (
       id int,
       test_json jsonb
);
insert into test_jsonb_subscript values
(1, '{}'), 
(2, '{"key": "value"}');
update test_jsonb_subscript set test_json['a'] = '1' where id = 1;
select * from test_jsonb_subscript;
update test_jsonb_subscript set test_json['a'] = '1' where id = 2;
select * from test_jsonb_subscript;
update test_jsonb_subscript set test_json['a'] = '"test"';
select * from test_jsonb_subscript;
update test_jsonb_subscript set test_json['a'] = '{"b": 1}'::jsonb;
select * from test_jsonb_subscript;
update test_jsonb_subscript set test_json['a'] = '[1, 2, 3]'::jsonb;
select * from test_jsonb_subscript;
select * from test_jsonb_subscript where test_json['key'] = '"value"';
select * from test_jsonb_subscript where test_json['key_doesnt_exists'] = '"value"';
select * from test_jsonb_subscript where test_json['key'] = '"wrong_value"';
update test_jsonb_subscript set test_json['another_key'] = NULL;
select * from test_jsonb_subscript;
insert into test_jsonb_subscript values (3, NULL);
update test_jsonb_subscript set test_json['a'] = '1' where id = 3;
select * from test_jsonb_subscript;
update test_jsonb_subscript set test_json = NULL where id = 3;
update test_jsonb_subscript set test_json[0] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '[0]');
update test_jsonb_subscript set test_json[5] = '1';
select * from test_jsonb_subscript;
update test_jsonb_subscript set test_json[-4] = '1';
select * from test_jsonb_subscript;
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '[]');
update test_jsonb_subscript set test_json[5] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{}');
update test_jsonb_subscript set test_json['a'][0]['b'][0]['c'] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{}');
update test_jsonb_subscript set test_json['a'][2]['b'][2]['c'][2] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{"b": 1}');
update test_jsonb_subscript set test_json['a'][0] = '2';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{}');
update test_jsonb_subscript set test_json[0]['a'] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '[]');
update test_jsonb_subscript set test_json[0]['a'] = '1';
update test_jsonb_subscript set test_json[2]['b'] = '2';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{}');
update test_jsonb_subscript set test_json['a']['b'][1] = '1';
update test_jsonb_subscript set test_json['a']['b'][10] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '[]');
update test_jsonb_subscript set test_json[0][0][0] = '1';
update test_jsonb_subscript set test_json[0][0][1] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{}');
update test_jsonb_subscript set test_json['a']['b'][10] = '1';
update test_jsonb_subscript set test_json['a'][10][10] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{"a": {}}');
update test_jsonb_subscript set test_json['a']['b']['c'][2] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{"a": []}');
update test_jsonb_subscript set test_json['a'][1]['c'][2] = '1';
select * from test_jsonb_subscript;
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, '{"a": 1}');
delete from test_jsonb_subscript;
insert into test_jsonb_subscript values (1, 'null');
drop table test_jsonb_subscript;
create temp table test_jsonb_subscript (
       id text,
       test_json jsonb
);
insert into test_jsonb_subscript values('foo', '{"foo": "bar"}');
insert into test_jsonb_subscript
  select s, ('{"' || s || '": "bar"}')::jsonb from repeat('xyzzy', 500) s;
select length(id), test_json[id] from test_jsonb_subscript;
update test_jsonb_subscript set test_json[id] = '"baz"';
table test_jsonb_subscript;
select to_tsvector('{"a": "aaa bbb ddd ccc", "b": ["eee fff ggg"], "c": {"d": "hhh iii"}}'::jsonb);
select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '"all"');
select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::jsonb, tsquery('bbb & ddd & hhh'));
select 'true'::jsonb::bool;
select '1.0'::jsonb::float;
select '12345'::jsonb::int4;
select '12345'::jsonb::numeric;
select '12345.05'::jsonb::numeric;
select '12345.05'::jsonb::float4;
select '12345.05'::jsonb::float8;
select '12345.05'::jsonb::int2;
select '12345.05'::jsonb::int4;
select '12345.05'::jsonb::int8;
select '12345.0000000000000000000000000000000000000000000005'::jsonb::numeric;
select '12345.0000000000000000000000000000000000000000000005'::jsonb::float4;
select '12345.0000000000000000000000000000000000000000000005'::jsonb::float8;
select '12345.0000000000000000000000000000000000000000000005'::jsonb::int2;
select '12345.0000000000000000000000000000000000000000000005'::jsonb::int4;
select '12345.0000000000000000000000000000000000000000000005'::jsonb::int8;
