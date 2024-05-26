SELECT 'ArrayFirst constant predicate';
SELECT arrayFirstOrNull(x -> 1, emptyArrayUInt8());
SELECT 'ArrayFirst non constant predicate';
SELECT 'ArrayFirst with Null';
SELECT 'ArrayLast constant predicate';
SELECT arrayLastOrNull(x -> 1, emptyArrayUInt8());
SELECT 'ArrayLast non constant predicate';
SELECT 'ArrayLast with Null';
