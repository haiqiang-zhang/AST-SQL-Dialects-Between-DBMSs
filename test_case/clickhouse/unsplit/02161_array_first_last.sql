SELECT 'ArrayFirst constant predicate';
SELECT arrayFirst(x -> 1, emptyArrayUInt8());
SELECT 'ArrayFirst non constant predicate';
SELECT 'ArrayLast constant predicate';
SELECT arrayLast(x -> 1, emptyArrayUInt8());
SELECT 'ArrayLast non constant predicate';
