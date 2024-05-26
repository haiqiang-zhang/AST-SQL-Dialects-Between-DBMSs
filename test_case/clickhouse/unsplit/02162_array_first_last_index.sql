SELECT 'ArrayFirstIndex constant predicate';
SELECT arrayFirstIndex(x -> 1, emptyArrayUInt8());
SELECT 'ArrayFirstIndex non constant predicate';
SELECT 'ArrayLastIndex constant predicate';
SELECT arrayLastIndex(x -> 1, emptyArrayUInt8());
SELECT 'ArrayLastIndex non constant predicate';
