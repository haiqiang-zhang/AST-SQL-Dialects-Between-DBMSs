SELECT uniq(x) FROM (SELECT arrayJoin([[], ['a'], ['a', 'b'], []]) AS x);
SELECT uniqExact(x) FROM (SELECT arrayJoin([[], ['a'], ['a', 'b'], []]) AS x);
SELECT uniqUpTo(3)(x) FROM (SELECT arrayJoin([[], ['a'], ['a', 'b'], []]) AS x);
