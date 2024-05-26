SELECT JSON(NULL);
SELECT pg_typeof(JSON('{ "a" : 1 } '));
EXPLAIN (VERBOSE, COSTS OFF) SELECT JSON('123');
SELECT JSON_OBJECT();
SELECT JSON_ARRAY();
SELECT	JSON_ARRAYAGG(i) IS NULL,
		JSON_ARRAYAGG(i RETURNING jsonb) IS NULL
FROM generate_series(1, 0) i;
SELECT	JSON_ARRAYAGG(NULL),
		JSON_ARRAYAGG(NULL RETURNING jsonb)
FROM generate_series(1, 5);
SELECT
	JSON_ARRAYAGG(bar) as no_options,
	JSON_ARRAYAGG(bar RETURNING jsonb) as returning_jsonb,
	JSON_ARRAYAGG(bar ABSENT ON NULL) as absent_on_null,
	JSON_ARRAYAGG(bar ABSENT ON NULL RETURNING jsonb) as absentonnull_returning_jsonb,
	JSON_ARRAYAGG(bar NULL ON NULL) as null_on_null,
	JSON_ARRAYAGG(bar NULL ON NULL RETURNING jsonb) as nullonnull_returning_jsonb,
	JSON_ARRAYAGG(foo) as row_no_options,
	JSON_ARRAYAGG(foo RETURNING jsonb) as row_returning_jsonb,
	JSON_ARRAYAGG(foo ORDER BY bar) FILTER (WHERE bar > 2) as row_filtered_agg,
	JSON_ARRAYAGG(foo ORDER BY bar RETURNING jsonb) FILTER (WHERE bar > 2) as row_filtered_agg_returning_jsonb
FROM
	(VALUES (NULL), (3), (1), (NULL), (NULL), (5), (2), (4), (NULL)) foo(bar);
SELECT
	bar, JSON_ARRAYAGG(bar) FILTER (WHERE bar > 2) OVER (PARTITION BY foo.bar % 2)
FROM
	(VALUES (NULL), (3), (1), (NULL), (NULL), (5), (2), (4), (NULL), (5), (4)) foo(bar);
SELECT	JSON_OBJECTAGG('key': 1) IS NULL,
		JSON_OBJECTAGG('key': 1 RETURNING jsonb) IS NULL
WHERE FALSE;
SELECT
	JSON_OBJECTAGG(k: v),
	JSON_OBJECTAGG(k: v NULL ON NULL),
	JSON_OBJECTAGG(k: v ABSENT ON NULL),
	JSON_OBJECTAGG(k: v RETURNING jsonb),
	JSON_OBJECTAGG(k: v NULL ON NULL RETURNING jsonb),
	JSON_OBJECTAGG(k: v ABSENT ON NULL RETURNING jsonb)
FROM
	(VALUES (1, 1), (1, NULL), (2, NULL), (3, 3)) foo(k, v);
EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_OBJECT('foo' : '1' FORMAT JSON, 'bar' : 'baz' RETURNING json);
CREATE VIEW json_object_view AS
SELECT JSON_OBJECT('foo' : '1' FORMAT JSON, 'bar' : 'baz' RETURNING json);
DROP VIEW json_object_view;
SELECT to_json(a) AS a, JSON_OBJECTAGG(k : v WITH UNIQUE KEYS) OVER (ORDER BY k)
FROM (VALUES (1,1), (2,2)) a(k,v);
EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAY('1' FORMAT JSON, 2 RETURNING json);
CREATE VIEW json_array_view AS
SELECT JSON_ARRAY('1' FORMAT JSON, 2 RETURNING json);
DROP VIEW json_array_view;
EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i;
EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING text) OVER (PARTITION BY i % 2)
FROM generate_series(1,5) i;
CREATE VIEW json_objectagg_view AS
SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i;
DROP VIEW json_objectagg_view;
EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i;
EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING text) OVER (PARTITION BY i % 2)
FROM generate_series(1,5) i;
CREATE VIEW json_arrayagg_view AS
SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i;
DROP VIEW json_arrayagg_view;
CREATE VIEW json_array_subquery_view AS
SELECT JSON_ARRAY(SELECT i FROM (VALUES (1), (2), (NULL), (4)) foo(i) RETURNING jsonb);
DROP VIEW json_array_subquery_view;
SELECT NULL IS JSON;
SELECT NULL IS NOT JSON;
SELECT NULL::json IS JSON;
SELECT NULL::jsonb IS JSON;
SELECT NULL::text IS JSON;
SELECT NULL::bytea IS JSON;
SELECT '' IS JSON;
CREATE TABLE test_is_json (js text);
INSERT INTO test_is_json VALUES
 (NULL),
 (''),
 ('123'),
 ('"aaa "'),
 ('true'),
 ('null'),
 ('[]'),
 ('[1, "2", {}]'),
 ('{}'),
 ('{ "a": 1, "b": null }'),
 ('{ "a": 1, "a": null }'),
 ('{ "a": 1, "b": [{ "a": 1 }, { "a": 2 }] }'),
 ('{ "a": 1, "b": [{ "a": 1, "b": 0, "a": 2 }] }'),
 ('aaa'),
 ('{a:1}'),
 ('["a",]');
SELECT
	js,
	js IS JSON "IS JSON",
	js IS NOT JSON "IS NOT JSON",
	js IS JSON VALUE "IS VALUE",
	js IS JSON OBJECT "IS OBJECT",
	js IS JSON ARRAY "IS ARRAY",
	js IS JSON SCALAR "IS SCALAR",
	js IS JSON WITHOUT UNIQUE KEYS "WITHOUT UNIQUE",
	js IS JSON WITH UNIQUE KEYS "WITH UNIQUE"
FROM
	test_is_json;
EXPLAIN (VERBOSE, COSTS OFF)
SELECT '1' IS JSON AS "any", ('1' || i) IS JSON SCALAR AS "scalar", '[]' IS NOT JSON ARRAY AS "array", '{}' IS JSON OBJECT WITH UNIQUE AS "object" FROM generate_series(1, 3) i;
CREATE VIEW is_json_view AS
SELECT '1' IS JSON AS "any", ('1' || i) IS JSON SCALAR AS "scalar", '[]' IS NOT JSON ARRAY AS "array", '{}' IS JSON OBJECT WITH UNIQUE AS "object" FROM generate_series(1, 3) i;
DROP VIEW is_json_view;
