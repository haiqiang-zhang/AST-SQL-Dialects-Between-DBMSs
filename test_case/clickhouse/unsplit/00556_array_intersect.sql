select arrayIntersect([], []);
select toTypeName(arrayIntersect([(1, ['a', 'b']), (Null, ['c'])], [(2, ['c', Null]), (1, ['a', 'b'])]));
