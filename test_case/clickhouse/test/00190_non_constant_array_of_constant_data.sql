SELECT arrayFilter(x -> notEmpty(concat(x, 'hello')), ['']) FROM system.one ARRAY JOIN [0] AS elem, arrayMap(x -> concat(x, 'hello'), ['']) AS unused WHERE NOT ignore(elem);
SELECT '---';
SELECT '---';
SELECT arrayJoin([0]), replicate('hello', [1]) WHERE NOT ignore(replicate('hello', [1]));
SELECT '---';
SELECT '---';
SELECT '---';
SELECT replicate('hello', emptyArrayString()) FROM system.one ARRAY JOIN emptyArrayString() AS unused WHERE NOT ignore(replicate('hello', emptyArrayString()));
