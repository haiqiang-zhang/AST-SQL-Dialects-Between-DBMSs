CREATE TABLE foo (key int, INDEX i1 key TYPE minmax GRANULARITY 1) Engine=MergeTree() ORDER BY key;
CREATE TABLE as_foo AS foo;
DROP TABLE foo;
DROP TABLE as_foo;
