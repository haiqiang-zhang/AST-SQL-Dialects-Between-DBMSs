PRAGMA enable_verification;
CREATE TABLE test_structs(i STRUCT(a integer, b bool));
INSERT INTO test_structs VALUES ({'a': 1, 'b': true}), ({'a': 2, 'b': false}), (NULL), ({'a': 3, 'b': true}), ({'a': NULL, 'b': NULL});
CREATE TABLE string_structs(s STRUCT(a varchar, b varchar));
INSERT INTO string_structs VALUES ({'a': 'foo', 'b': 'bar'}), ({'a': 'baz', 'b': 'qux'}), (NULL), ({'a': 'foo', 'b': NULL});
CREATE TABLE large_structs(i STRUCT(a integer, b bool));
INSERT INTO large_structs SELECT {'a': n, 'b': n % 2 = 0} FROM generate_series(200000) as t(n);
CREATE TABLE nested_structs(s STRUCT(a STRUCT(b integer, c bool), d STRUCT(e integer, f varchar)));
INSERT INTO nested_structs VALUES
	({'a': {'b': 1, 'c': false}, 'd': {'e': 2, 'f': 'foo'}}),
	(NULL),
	({'a': {'b': 3, 'c': true}, 'd': {'e': 4, 'f': 'bar'}}),
	({'a': {'b': NULL, 'c': true}, 'd': {'e': 5, 'f': 'qux'}}),
	({'a': NULL, 'd': NULL});
