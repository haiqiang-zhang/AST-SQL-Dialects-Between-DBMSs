SELECT '""'::json;				
SELECT $$''$$::json;			
SELECT '"abc"'::json;			
SELECT '"abc'::json;			
SELECT '"abc
def"'::json;					
SELECT '"\n\"\\"'::json;		
SELECT '"\v"'::json;			

SELECT ('"'||repeat('.', 12)||'abc"')::json; 
SELECT ('"'||repeat('.', 12)||'abc\n"')::json; 


SELECT '1'::json;				
SELECT '0'::json;				
SELECT '01'::json;				
SELECT '0.1'::json;				
SELECT '9223372036854775808'::json;	
SELECT '1e100'::json;			
SELECT '1.3e100'::json;			
SELECT '1f2'::json;				
SELECT '0.x1'::json;			
SELECT '1.3ex100'::json;		

SELECT '[]'::json;				
SELECT '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'::json;  
SELECT '[1,2]'::json;			
SELECT '[1,2,]'::json;			
SELECT '[1,2'::json;			
SELECT '[1,[2]'::json;			

SELECT '{}'::json;				
SELECT '{"abc"}'::json;			
SELECT '{"abc":1}'::json;		
SELECT '{1:"abc"}'::json;		
SELECT '{"abc",1}'::json;		
SELECT '{"abc"=1}'::json;		
SELECT '{"abc"::1}'::json;		
SELECT '{"abc":1,"def":2,"ghi":[3,4],"hij":{"klm":5,"nop":[6]}}'::json; 
SELECT '{"abc":1:2}'::json;		
SELECT '{"abc":1,3}'::json;		

SET max_stack_depth = '100kB';
SELECT repeat('[', 10000)::json;
SELECT repeat('{"a":', 10000)::json;
RESET max_stack_depth;

SELECT 'true'::json;			
SELECT 'false'::json;			
SELECT 'null'::json;			
SELECT ' true '::json;			
SELECT 'true false'::json;		
SELECT 'true, false'::json;		
SELECT 'truf'::json;			
SELECT 'trues'::json;			
SELECT ''::json;				
SELECT '    '::json;			

SELECT '{
		"one": 1,
		"two":"two",
		"three":
		true}'::json; 
SELECT '{
		"one": 1,
		"two":,"two",  
		"three":
		true}'::json;
SELECT '{
		"one": 1,
		"two":"two",
		"averyveryveryveryveryveryveryveryveryverylongfieldname":}'::json;

select pg_input_is_valid('{"a":true}', 'json');
select pg_input_is_valid('{"a":true', 'json');
select * from pg_input_error_info('{"a":true', 'json');


SELECT array_to_json(array(select 1 as a));
SELECT array_to_json(array_agg(q),false) from (select x as b, x * 2 as c from generate_series(1,3) x) q;
SELECT array_to_json(array_agg(q),true) from (select x as b, x * 2 as c from generate_series(1,3) x) q;
SELECT array_to_json(array_agg(q),false)
  FROM ( SELECT $$a$$ || x AS b, y AS c,
               ARRAY[ROW(x.*,ARRAY[1,2,3]),
               ROW(y.*,ARRAY[4,5,6])] AS z
         FROM generate_series(1,2) x,
              generate_series(4,5) y) q;
SELECT array_to_json(array_agg(x),false) from generate_series(5,10) x;
SELECT array_to_json('{{1,5},{99,100}}'::int[]);

SELECT row_to_json(row(1,'foo'));

SELECT row_to_json(q)
FROM (SELECT $$a$$ || x AS b,
         y AS c,
         ARRAY[ROW(x.*,ARRAY[1,2,3]),
               ROW(y.*,ARRAY[4,5,6])] AS z
      FROM generate_series(1,2) x,
           generate_series(4,5) y) q;

SELECT row_to_json(q,true)
FROM (SELECT $$a$$ || x AS b,
         y AS c,
         ARRAY[ROW(x.*,ARRAY[1,2,3]),
               ROW(y.*,ARRAY[4,5,6])] AS z
      FROM generate_series(1,2) x,
           generate_series(4,5) y) q;

CREATE TEMP TABLE rows AS
SELECT x, 'txt' || x as y
FROM generate_series(1,3) AS x;

SELECT row_to_json(q,true)
FROM rows q;

SELECT row_to_json(row((select array_agg(x) as d from generate_series(5,10) x)),false);


analyze rows;

select attname, to_json(histogram_bounds) histogram_bounds
from pg_stats
where tablename = 'rows' and
      schemaname = pg_my_temp_schema()::regnamespace::text
order by 1;


select to_json(timestamp '2014-05-28 12:22:35.614298');

BEGIN;
SET LOCAL TIME ZONE 10.5;
select to_json(timestamptz '2014-05-28 12:22:35.614298-04');
SET LOCAL TIME ZONE -8;
select to_json(timestamptz '2014-05-28 12:22:35.614298-04');
COMMIT;

select to_json(date '2014-05-28');

select to_json(date 'Infinity');
select to_json(date '-Infinity');
select to_json(timestamp 'Infinity');
select to_json(timestamp '-Infinity');
select to_json(timestamptz 'Infinity');
select to_json(timestamptz '-Infinity');


SELECT json_agg(q)
  FROM ( SELECT $$a$$ || x AS b, y AS c,
               ARRAY[ROW(x.*,ARRAY[1,2,3]),
               ROW(y.*,ARRAY[4,5,6])] AS z
         FROM generate_series(1,2) x,
              generate_series(4,5) y) q;

SELECT json_agg(q ORDER BY x, y)
  FROM rows q;

UPDATE rows SET x = NULL WHERE x = 1;

SELECT json_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q;

SELECT row_to_json(q)
FROM (SELECT 'NaN'::float8 AS "float8field") q;

SELECT row_to_json(q)
FROM (SELECT 'Infinity'::float8 AS "float8field") q;

SELECT row_to_json(q)
FROM (SELECT '-Infinity'::float8 AS "float8field") q;

SELECT row_to_json(q)
FROM (SELECT '{"a":1,"b": [2,3,4,"d","e","f"],"c":{"p":1,"q":2}}'::json AS "jsonfield") q;



CREATE TEMP TABLE test_json (
       json_type text,
       test_json json
);

INSERT INTO test_json VALUES
('scalar','"a scalar"'),
('array','["zero", "one","two",null,"four","five", [1,2,3],{"f1":9}]'),
('object','{"field1":"val1","field2":"val2","field3":null, "field4": 4, "field5": [1,2,3], "field6": {"f1":9}}');

SELECT test_json -> 'x'
FROM test_json
WHERE json_type = 'scalar';

SELECT test_json -> 'x'
FROM test_json
WHERE json_type = 'array';

SELECT test_json -> 'x'
FROM test_json
WHERE json_type = 'object';

SELECT test_json->'field2'
FROM test_json
WHERE json_type = 'object';

SELECT test_json->>'field2'
FROM test_json
WHERE json_type = 'object';

SELECT test_json -> 2
FROM test_json
WHERE json_type = 'scalar';

SELECT test_json -> 2
FROM test_json
WHERE json_type = 'array';

SELECT test_json -> -1
FROM test_json
WHERE json_type = 'array';

SELECT test_json -> 2
FROM test_json
WHERE json_type = 'object';

SELECT test_json->>2
FROM test_json
WHERE json_type = 'array';

SELECT test_json ->> 6 FROM test_json WHERE json_type = 'array';
SELECT test_json ->> 7 FROM test_json WHERE json_type = 'array';

SELECT test_json ->> 'field4' FROM test_json WHERE json_type = 'object';
SELECT test_json ->> 'field5' FROM test_json WHERE json_type = 'object';
SELECT test_json ->> 'field6' FROM test_json WHERE json_type = 'object';

SELECT json_object_keys(test_json)
FROM test_json
WHERE json_type = 'scalar';

SELECT json_object_keys(test_json)
FROM test_json
WHERE json_type = 'array';

SELECT json_object_keys(test_json)
FROM test_json
WHERE json_type = 'object';


select count(*) from
    (select json_object_keys(json_object(array_agg(g)))
     from (select unnest(array['f'||n,n::text])as g
           from generate_series(1,300) as n) x ) y;


select (test_json->'field3') is null as expect_false
from test_json
where json_type = 'object';

select (test_json->>'field3') is null as expect_true
from test_json
where json_type = 'object';

select (test_json->3) is null as expect_false
from test_json
where json_type = 'array';

select (test_json->>3) is null as expect_true
from test_json
where json_type = 'array';


select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> null::text;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> null::int;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> 1;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> -1;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> 'z';
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> '';
select '[{"b": "c"}, {"b": "cc"}]'::json -> 1;
select '[{"b": "c"}, {"b": "cc"}]'::json -> 3;
select '[{"b": "c"}, {"b": "cc"}]'::json -> 'z';
select '{"a": "c", "b": null}'::json -> 'b';
select '"foo"'::json -> 1;
select '"foo"'::json -> 'z';

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> null::text;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> null::int;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> 1;
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> 'z';
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> '';
select '[{"b": "c"}, {"b": "cc"}]'::json ->> 1;
select '[{"b": "c"}, {"b": "cc"}]'::json ->> 3;
select '[{"b": "c"}, {"b": "cc"}]'::json ->> 'z';
select '{"a": "c", "b": null}'::json ->> 'b';
select '"foo"'::json ->> 1;
select '"foo"'::json ->> 'z';


SELECT json_array_length('[1,2,3,{"f1":1,"f2":[5,6]},4]');

SELECT json_array_length('[]');

SELECT json_array_length('{"f1":1,"f2":[5,6]}');

SELECT json_array_length('4');


select json_each('{"f1":[1,2,3],"f2":{"f3":1},"f4":null}');
select * from json_each('{"f1":[1,2,3],"f2":{"f3":1},"f4":null,"f5":99,"f6":"stringy"}') q;

select json_each_text('{"f1":[1,2,3],"f2":{"f3":1},"f4":null,"f5":"null"}');
select * from json_each_text('{"f1":[1,2,3],"f2":{"f3":1},"f4":null,"f5":99,"f6":"stringy"}') q;


select json_extract_path('{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}','f4','f6');
select json_extract_path('{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}','f2');
select json_extract_path('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',0::text);
select json_extract_path('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',1::text);
select json_extract_path_text('{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}','f4','f6');
select json_extract_path_text('{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}','f2');
select json_extract_path_text('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',0::text);
select json_extract_path_text('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',1::text);


select json_extract_path('{"f2":{"f3":1},"f4":{"f5":null,"f6":"stringy"}}','f4','f5') is null as expect_false;
select json_extract_path_text('{"f2":{"f3":1},"f4":{"f5":null,"f6":"stringy"}}','f4','f5') is null as expect_true;
select json_extract_path('{"f2":{"f3":1},"f4":[0,1,2,null]}','f4','3') is null as expect_false;
select json_extract_path_text('{"f2":{"f3":1},"f4":[0,1,2,null]}','f4','3') is null as expect_true;


select '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::json#>array['f4','f6'];
select '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::json#>array['f2'];
select '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::json#>array['f2','0'];
select '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::json#>array['f2','1'];

select '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::json#>>array['f4','f6'];
select '{"f2":{"f3":1},"f4":{"f5":99,"f6":"stringy"}}'::json#>>array['f2'];
select '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::json#>>array['f2','0'];
select '{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}'::json#>>array['f2','1'];

select '{"a": {"b":{"c": "foo"}}}'::json #> '{}';
select '[1,2,3]'::json #> '{}';
select '"foo"'::json #> '{}';
select '42'::json #> '{}';
select 'null'::json #> '{}';
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a'];
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a', null];
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a', ''];
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a','b'];
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a','b','c'];
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a','b','c','d'];
select '{"a": {"b":{"c": "foo"}}}'::json #> array['a','z','c'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json #> array['a','1','b'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json #> array['a','z','b'];
select '[{"b": "c"}, {"b": "cc"}]'::json #> array['1','b'];
select '[{"b": "c"}, {"b": "cc"}]'::json #> array['z','b'];
select '[{"b": "c"}, {"b": null}]'::json #> array['1','b'];
select '"foo"'::json #> array['z'];
select '42'::json #> array['f2'];
select '42'::json #> array['0'];

select '{"a": {"b":{"c": "foo"}}}'::json #>> '{}';
select '[1,2,3]'::json #>> '{}';
select '"foo"'::json #>> '{}';
select '42'::json #>> '{}';
select 'null'::json #>> '{}';
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a'];
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a', null];
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a', ''];
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a','b'];
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a','b','c'];
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a','b','c','d'];
select '{"a": {"b":{"c": "foo"}}}'::json #>> array['a','z','c'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json #>> array['a','1','b'];
select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json #>> array['a','z','b'];
select '[{"b": "c"}, {"b": "cc"}]'::json #>> array['1','b'];
select '[{"b": "c"}, {"b": "cc"}]'::json #>> array['z','b'];
select '[{"b": "c"}, {"b": null}]'::json #>> array['1','b'];
select '"foo"'::json #>> array['z'];
select '42'::json #>> array['f2'];
select '42'::json #>> array['0'];


select json_array_elements('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false,"stringy"]');
select * from json_array_elements('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false,"stringy"]') q;
select json_array_elements_text('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false,"stringy"]');
select * from json_array_elements_text('[1,true,[1,[2,3]],null,{"f1":1,"f2":[7,8,9]},false,"stringy"]') q;

create type jpop as (a text, b int, c timestamp);

CREATE DOMAIN js_int_not_null  AS int     NOT NULL;
CREATE DOMAIN js_int_array_1d  AS int[]   CHECK(array_length(VALUE, 1) = 3);
CREATE DOMAIN js_int_array_2d  AS int[][] CHECK(array_length(VALUE, 2) = 3);

create type j_unordered_pair as (x int, y int);
create domain j_ordered_pair as j_unordered_pair check((value).x <= (value).y);

CREATE TYPE jsrec AS (
	i	int,
	ia	_int4,
	ia1	int[],
	ia2	int[][],
	ia3	int[][][],
	ia1d	js_int_array_1d,
	ia2d	js_int_array_2d,
	t	text,
	ta	text[],
	c	char(10),
	ca	char(10)[],
	ts	timestamp,
	js	json,
	jsb	jsonb,
	jsa	json[],
	rec	jpop,
	reca	jpop[]
);

CREATE TYPE jsrec_i_not_null AS (
	i	js_int_not_null
);

select * from json_populate_record(null::jpop,'{"a":"blurfl","x":43.2}') q;
select * from json_populate_record(row('x',3,'2012-12-31 15:30:56')::jpop,'{"a":"blurfl","x":43.2}') q;

select * from json_populate_record(null::jpop,'{"a":"blurfl","x":43.2}') q;
select * from json_populate_record(row('x',3,'2012-12-31 15:30:56')::jpop,'{"a":"blurfl","x":43.2}') q;

select * from json_populate_record(null::jpop,'{"a":[100,200,false],"x":43.2}') q;
select * from json_populate_record(row('x',3,'2012-12-31 15:30:56')::jpop,'{"a":[100,200,false],"x":43.2}') q;
select * from json_populate_record(row('x',3,'2012-12-31 15:30:56')::jpop,'{"c":[100,200,false],"x":43.2}') q;

select * from json_populate_record(row('x',3,'2012-12-31 15:30:56')::jpop,'{}') q;

SELECT i FROM json_populate_record(NULL::jsrec_i_not_null, '{"x": 43.2}') q;
SELECT i FROM json_populate_record(NULL::jsrec_i_not_null, '{"i": null}') q;
SELECT i FROM json_populate_record(NULL::jsrec_i_not_null, '{"i": 12345}') q;

SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": null}') q;
SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": 123}') q;
SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": [1, "2", null, 4]}') q;
SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": [[1, 2], [3, 4]]}') q;
SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": [[1], 2]}') q;
SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": [[1], [2, 3]]}') q;
SELECT ia FROM json_populate_record(NULL::jsrec, '{"ia": "{1,2,3}"}') q;

SELECT ia1 FROM json_populate_record(NULL::jsrec, '{"ia1": null}') q;
SELECT ia1 FROM json_populate_record(NULL::jsrec, '{"ia1": 123}') q;
SELECT ia1 FROM json_populate_record(NULL::jsrec, '{"ia1": [1, "2", null, 4]}') q;
SELECT ia1 FROM json_populate_record(NULL::jsrec, '{"ia1": [[1, 2, 3]]}') q;

SELECT ia1d FROM json_populate_record(NULL::jsrec, '{"ia1d": null}') q;
SELECT ia1d FROM json_populate_record(NULL::jsrec, '{"ia1d": 123}') q;
SELECT ia1d FROM json_populate_record(NULL::jsrec, '{"ia1d": [1, "2", null, 4]}') q;
SELECT ia1d FROM json_populate_record(NULL::jsrec, '{"ia1d": [1, "2", null]}') q;

SELECT ia2 FROM json_populate_record(NULL::jsrec, '{"ia2": [1, "2", null, 4]}') q;
SELECT ia2 FROM json_populate_record(NULL::jsrec, '{"ia2": [[1, 2], [null, 4]]}') q;
SELECT ia2 FROM json_populate_record(NULL::jsrec, '{"ia2": [[], []]}') q;
SELECT ia2 FROM json_populate_record(NULL::jsrec, '{"ia2": [[1, 2], [3]]}') q;
SELECT ia2 FROM json_populate_record(NULL::jsrec, '{"ia2": [[1, 2], 3, 4]}') q;

SELECT ia2d FROM json_populate_record(NULL::jsrec, '{"ia2d": [[1, "2"], [null, 4]]}') q;
SELECT ia2d FROM json_populate_record(NULL::jsrec, '{"ia2d": [[1, "2", 3], [null, 5, 6]]}') q;

SELECT ia3 FROM json_populate_record(NULL::jsrec, '{"ia3": [1, "2", null, 4]}') q;
SELECT ia3 FROM json_populate_record(NULL::jsrec, '{"ia3": [[1, 2], [null, 4]]}') q;
SELECT ia3 FROM json_populate_record(NULL::jsrec, '{"ia3": [ [[], []], [[], []], [[], []] ]}') q;
SELECT ia3 FROM json_populate_record(NULL::jsrec, '{"ia3": [ [[1, 2]], [[3, 4]] ]}') q;
SELECT ia3 FROM json_populate_record(NULL::jsrec, '{"ia3": [ [[1, 2], [3, 4]], [[5, 6], [7, 8]] ]}') q;
SELECT ia3 FROM json_populate_record(NULL::jsrec, '{"ia3": [ [[1, 2], [3, 4]], [[5, 6], [7, 8], [9, 10]] ]}') q;

SELECT ta FROM json_populate_record(NULL::jsrec, '{"ta": null}') q;
SELECT ta FROM json_populate_record(NULL::jsrec, '{"ta": 123}') q;
SELECT ta FROM json_populate_record(NULL::jsrec, '{"ta": [1, "2", null, 4]}') q;
SELECT ta FROM json_populate_record(NULL::jsrec, '{"ta": [[1, 2, 3], {"k": "v"}]}') q;

SELECT c FROM json_populate_record(NULL::jsrec, '{"c": null}') q;
SELECT c FROM json_populate_record(NULL::jsrec, '{"c": "aaa"}') q;
SELECT c FROM json_populate_record(NULL::jsrec, '{"c": "aaaaaaaaaa"}') q;
SELECT c FROM json_populate_record(NULL::jsrec, '{"c": "aaaaaaaaaaaaa"}') q;

SELECT ca FROM json_populate_record(NULL::jsrec, '{"ca": null}') q;
SELECT ca FROM json_populate_record(NULL::jsrec, '{"ca": 123}') q;
SELECT ca FROM json_populate_record(NULL::jsrec, '{"ca": [1, "2", null, 4]}') q;
SELECT ca FROM json_populate_record(NULL::jsrec, '{"ca": ["aaaaaaaaaaaaaaaa"]}') q;
SELECT ca FROM json_populate_record(NULL::jsrec, '{"ca": [[1, 2, 3], {"k": "v"}]}') q;

SELECT js FROM json_populate_record(NULL::jsrec, '{"js": null}') q;
SELECT js FROM json_populate_record(NULL::jsrec, '{"js": true}') q;
SELECT js FROM json_populate_record(NULL::jsrec, '{"js": 123.45}') q;
SELECT js FROM json_populate_record(NULL::jsrec, '{"js": "123.45"}') q;
SELECT js FROM json_populate_record(NULL::jsrec, '{"js": "abc"}') q;
SELECT js FROM json_populate_record(NULL::jsrec, '{"js": [123, "123", null, {"key": "value"}]}') q;
SELECT js FROM json_populate_record(NULL::jsrec, '{"js": {"a": "bbb", "b": null, "c": 123.45}}') q;

SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": null}') q;
SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": true}') q;
SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": 123.45}') q;
SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": "123.45"}') q;
SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": "abc"}') q;
SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": [123, "123", null, {"key": "value"}]}') q;
SELECT jsb FROM json_populate_record(NULL::jsrec, '{"jsb": {"a": "bbb", "b": null, "c": 123.45}}') q;

SELECT jsa FROM json_populate_record(NULL::jsrec, '{"jsa": null}') q;
SELECT jsa FROM json_populate_record(NULL::jsrec, '{"jsa": 123}') q;
SELECT jsa FROM json_populate_record(NULL::jsrec, '{"jsa": [1, "2", null, 4]}') q;
SELECT jsa FROM json_populate_record(NULL::jsrec, '{"jsa": ["aaa", null, [1, 2, "3", {}], { "k" : "v" }]}') q;

SELECT rec FROM json_populate_record(NULL::jsrec, '{"rec": 123}') q;
SELECT rec FROM json_populate_record(NULL::jsrec, '{"rec": [1, 2]}') q;
SELECT rec FROM json_populate_record(NULL::jsrec, '{"rec": {"a": "abc", "c": "01.02.2003", "x": 43.2}}') q;
SELECT rec FROM json_populate_record(NULL::jsrec, '{"rec": "(abc,42,01.02.2003)"}') q;

SELECT reca FROM json_populate_record(NULL::jsrec, '{"reca": 123}') q;
SELECT reca FROM json_populate_record(NULL::jsrec, '{"reca": [1, 2]}') q;
SELECT reca FROM json_populate_record(NULL::jsrec, '{"reca": [{"a": "abc", "b": 456}, null, {"c": "01.02.2003", "x": 43.2}]}') q;
SELECT reca FROM json_populate_record(NULL::jsrec, '{"reca": ["(abc,42,01.02.2003)"]}') q;
SELECT reca FROM json_populate_record(NULL::jsrec, '{"reca": "{\"(abc,42,01.02.2003)\"}"}') q;

SELECT rec FROM json_populate_record(
	row(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
		row('x',3,'2012-12-31 15:30:56')::jpop,NULL)::jsrec,
	'{"rec": {"a": "abc", "c": "01.02.2003", "x": 43.2}}'
) q;

SELECT json_populate_record(null::record, '{"x": 0, "y": 1}');
SELECT json_populate_record(row(1,2), '{"f1": 0, "f2": 1}');
SELECT * FROM
  json_populate_record(null::record, '{"x": 776}') AS (x int, y int);

SELECT json_populate_record(null::j_ordered_pair, '{"x": 0, "y": 1}');
SELECT json_populate_record(row(1,2)::j_ordered_pair, '{"x": 0}');
SELECT json_populate_record(row(1,2)::j_ordered_pair, '{"x": 1, "y": 0}');


select * from json_populate_recordset(null::jpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(row('def',99,null)::jpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(null::jpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(row('def',99,null)::jpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(row('def',99,null)::jpop,'[{"a":[100,200,300],"x":43.2},{"a":{"z":true},"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(row('def',99,null)::jpop,'[{"c":[100,200,300],"x":43.2},{"a":{"z":true},"b":3,"c":"2012-01-20 10:42:53"}]') q;

create type jpop2 as (a int, b json, c int, d int);
select * from json_populate_recordset(null::jpop2, '[{"a":2,"c":3,"b":{"z":4},"d":6}]') q;

select * from json_populate_recordset(null::jpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(row('def',99,null)::jpop,'[{"a":"blurfl","x":43.2},{"b":3,"c":"2012-01-20 10:42:53"}]') q;
select * from json_populate_recordset(row('def',99,null)::jpop,'[{"a":[100,200,300],"x":43.2},{"a":{"z":true},"b":3,"c":"2012-01-20 10:42:53"}]') q;

SELECT json_populate_recordset(null::record, '[{"x": 0, "y": 1}]');
SELECT json_populate_recordset(row(1,2), '[{"f1": 0, "f2": 1}]');
SELECT i, json_populate_recordset(row(i,50), '[{"f1":"42"},{"f2":"43"}]')
FROM (VALUES (1),(2)) v(i);
SELECT * FROM
  json_populate_recordset(null::record, '[{"x": 776}]') AS (x int, y int);

SELECT json_populate_recordset(null::record, '[]');
SELECT json_populate_recordset(row(1,2), '[]');
SELECT * FROM json_populate_recordset(NULL::jpop,'[]') q;
SELECT * FROM
  json_populate_recordset(null::record, '[]') AS (x int, y int);

SELECT json_populate_recordset(null::j_ordered_pair, '[{"x": 0, "y": 1}]');
SELECT json_populate_recordset(row(1,2)::j_ordered_pair, '[{"x": 0}, {"y": 3}]');
SELECT json_populate_recordset(row(1,2)::j_ordered_pair, '[{"x": 1, "y": 0}]');

select * from json_populate_recordset(row(0::int),'[{"a":"1","b":"2"},{"a":"3"}]') q (a text, b text);
select * from json_populate_recordset(row(0::int,0::int),'[{"a":"1","b":"2"},{"a":"3"}]') q (a text, b text);
select * from json_populate_recordset(row(0::int,0::int,0::int),'[{"a":"1","b":"2"},{"a":"3"}]') q (a text, b text);
select * from json_populate_recordset(row(1000000000::int,50::int),'[{"b":"2"},{"a":"3"}]') q (a text, b text);

CREATE TEMP TABLE jspoptest (js json);

INSERT INTO jspoptest
SELECT '{
	"jsa": [1, "2", null, 4],
	"rec": {"a": "abc", "c": "01.02.2003", "x": 43.2},
	"reca": [{"a": "abc", "b": 456}, null, {"c": "01.02.2003", "x": 43.2}]
}'::json
FROM generate_series(1, 3);

SELECT (json_populate_record(NULL::jsrec, js)).* FROM jspoptest;

DROP TYPE jsrec;
DROP TYPE jsrec_i_not_null;
DROP DOMAIN js_int_not_null;
DROP DOMAIN js_int_array_1d;
DROP DOMAIN js_int_array_2d;
DROP DOMAIN j_ordered_pair;
DROP TYPE j_unordered_pair;

select value, json_typeof(value)
  from (values (json '123.4'),
               (json '-1'),
               (json '"foo"'),
               (json 'true'),
               (json 'false'),
               (json 'null'),
               (json '[1, 2, 3]'),
               (json '[]'),
               (json '{"x":"foo", "y":123}'),
               (json '{}'),
               (NULL::json))
      as data(value);


SELECT json_build_array('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}');
SELECT json_build_array('a', NULL); 
SELECT json_build_array(VARIADIC NULL::text[]); 
SELECT json_build_array(VARIADIC '{}'::text[]); 
SELECT json_build_array(VARIADIC '{a,b,c}'::text[]); 
SELECT json_build_array(VARIADIC ARRAY['a', NULL]::text[]); 
SELECT json_build_array(VARIADIC '{1,2,3,4}'::text[]); 
SELECT json_build_array(VARIADIC '{1,2,3,4}'::int[]); 
SELECT json_build_array(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][]); 

SELECT json_build_object('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}');

SELECT json_build_object(
       'a', json_build_object('b',false,'c',99),
       'd', json_build_object('e',array[9,8,7]::int[],
           'f', (select row_to_json(r) from ( select relkind, oid::regclass as name from pg_class where relname = 'pg_class') r)));
SELECT json_build_object('{a,b,c}'::text[]); 
SELECT json_build_object('{a,b,c}'::text[], '{d,e,f}'::text[]); 
SELECT json_build_object('a', 'b', 'c'); 
SELECT json_build_object(NULL, 'a'); 
SELECT json_build_object('a', NULL); 
SELECT json_build_object(VARIADIC NULL::text[]); 
SELECT json_build_object(VARIADIC '{}'::text[]); 
SELECT json_build_object(VARIADIC '{a,b,c}'::text[]); 
SELECT json_build_object(VARIADIC ARRAY['a', NULL]::text[]); 
SELECT json_build_object(VARIADIC ARRAY[NULL, 'a']::text[]); 
SELECT json_build_object(VARIADIC '{1,2,3,4}'::text[]); 
SELECT json_build_object(VARIADIC '{1,2,3,4}'::int[]); 
SELECT json_build_object(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][]); 

SELECT json_build_array();

SELECT json_build_object();

SELECT json_build_object(1,2);

SELECT json_build_object(null,2);

SELECT json_build_object(r,2) FROM (SELECT 1 AS a, 2 AS b) r;

SELECT json_build_object(json '{"a":1,"b":2}', 3);

SELECT json_build_object('{1,2,3}'::int[], 3);

CREATE TEMP TABLE foo (serial_num int, name text, type text);
INSERT INTO foo VALUES (847001,'t15','GE1043');
INSERT INTO foo VALUES (847002,'t16','GE1043');
INSERT INTO foo VALUES (847003,'sub-alpha','GESS90');

SELECT json_build_object('turbines',json_object_agg(serial_num,json_build_object('name',name,'type',type)))
FROM foo;

SELECT json_object_agg(name, type) FROM foo;

INSERT INTO foo VALUES (999999, NULL, 'bar');
SELECT json_object_agg(name, type) FROM foo;


SELECT json_object('{}');

SELECT json_object('{}', '{}');

SELECT json_object('{a,1,b,2,3,NULL,"d e f","a b c"}');

SELECT json_object('{{a,1},{b,2},{3,NULL},{"d e f","a b c"}}');

SELECT json_object('{a,b,c}');

SELECT json_object('{{a},{b}}');

SELECT json_object('{{a,b,c},{b,c,d}}');

SELECT json_object('{{{a,b},{c,d}},{{b,c},{d,e}}}');


select json_object('{a,b,c,"d e f"}','{1,2,3,"a b c"}');

SELECT json_object('{{a,1},{b,2},{3,NULL},{"d e f","a b c"}}', '{{a,1},{b,2},{3,NULL},{"d e f","a b c"}}');


select json_object('{a,b,c,"d e f",g}','{1,2,3,"a b c"}');

select json_object('{a,b,c,"d e f"}','{1,2,3,"a b c",g}');


select json_object('{a,b,NULL,"d e f"}','{1,2,3,"a b c"}');


select json_object('{a,b,"","d e f"}','{1,2,3,"a b c"}');



select * from json_to_record('{"a":1,"b":"foo","c":"bar"}')
    as x(a int, b text, d text);

select * from json_to_recordset('[{"a":1,"b":"foo","d":false},{"a":2,"b":"bar","c":true}]')
    as x(a int, b text, c boolean);

select * from json_to_recordset('[{"a":1,"b":{"d":"foo"},"c":true},{"a":2,"c":false,"b":{"d":"bar"}}]')
    as x(a int, b json, c boolean);

select *, c is null as c_is_null
from json_to_record('{"a":1, "b":{"c":16, "d":2}, "x":8, "ca": ["1 2", 3], "ia": [[1,2],[3,4]], "r": {"a": "aaa", "b": 123}}'::json)
    as t(a int, b json, c text, x int, ca char(5)[], ia int[][], r jpop);

select *, c is null as c_is_null
from json_to_recordset('[{"a":1, "b":{"c":16, "d":2}, "x":8}]'::json)
    as t(a int, b json, c text, x int);

select * from json_to_record('{"ia": null}') as x(ia _int4);
select * from json_to_record('{"ia": 123}') as x(ia _int4);
select * from json_to_record('{"ia": [1, "2", null, 4]}') as x(ia _int4);
select * from json_to_record('{"ia": [[1, 2], [3, 4]]}') as x(ia _int4);
select * from json_to_record('{"ia": [[1], 2]}') as x(ia _int4);
select * from json_to_record('{"ia": [[1], [2, 3]]}') as x(ia _int4);

select * from json_to_record('{"ia2": [1, 2, 3]}') as x(ia2 int[][]);
select * from json_to_record('{"ia2": [[1, 2], [3, 4]]}') as x(ia2 int4[][]);
select * from json_to_record('{"ia2": [[[1], [2], [3]]]}') as x(ia2 int4[][]);

select * from json_to_record('{"out": {"key": 1}}') as x(out json);
select * from json_to_record('{"out": [{"key": 1}]}') as x(out json);
select * from json_to_record('{"out": "{\"key\": 1}"}') as x(out json);
select * from json_to_record('{"out": {"key": 1}}') as x(out jsonb);
select * from json_to_record('{"out": [{"key": 1}]}') as x(out jsonb);
select * from json_to_record('{"out": "{\"key\": 1}"}') as x(out jsonb);


select json_strip_nulls(null);

select json_strip_nulls('1');

select json_strip_nulls('"a string"');

select json_strip_nulls('null');

select json_strip_nulls('[1,2,null,3,4]');

select json_strip_nulls('{"a":1,"b":null,"c":[2,null,3],"d":{"e":4,"f":null}}');

select json_strip_nulls('[1,{"a":1,"b":null,"c":2},3]');

select json_strip_nulls('{"a": {"b": null, "c": null}, "d": {} }');

select to_tsvector('{"a": "aaa bbb ddd ccc", "b": ["eee fff ggg"], "c": {"d": "hhh iii"}}'::json);

select to_tsvector('simple', '{"a": "aaa bbb ddd ccc", "b": ["eee fff ggg"], "c": {"d": "hhh iii"}}'::json);

select to_tsvector('english', '{"a": "aaa in bbb ddd ccc", "b": ["the eee fff ggg"], "c": {"d": "hhh. iii"}}'::json);

select to_tsvector('english', '{"a": "aaa in bbb ddd ccc", "b": 123, "c": 456}'::json);

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"all"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"key"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"string"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"numeric"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"boolean"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '["string", "numeric"]');

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"all"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"key"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"string"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"numeric"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"boolean"');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '["string", "numeric"]');

select to_tsvector('""'::json);
select to_tsvector('{}'::json);
select to_tsvector('[]'::json);
select to_tsvector('null'::json);

select json_to_tsvector('""'::json, '"all"');
select json_to_tsvector('{}'::json, '"all"');
select json_to_tsvector('[]'::json, '"all"');
select json_to_tsvector('null'::json, '"all"');

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '""');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '{}');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '[]');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, 'null');
select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '["all", null]');

select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'));
select ts_headline('english', '{"a": "aaa bbb", "b": {"c": "ccc ddd fff"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'));
select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'), 'StartSel = <, StopSel = >');
select ts_headline('english', '{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'), 'StartSel = <, StopSel = >');

select ts_headline('null'::json, tsquery('aaa & bbb'));
select ts_headline('{}'::json, tsquery('aaa & bbb'));
select ts_headline('[]'::json, tsquery('aaa & bbb'));
