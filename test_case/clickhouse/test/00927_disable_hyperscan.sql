SET allow_hyperscan = 1;
SELECT multiMatchAny(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), ['hel+o', 'w(or)*ld']);
SELECT multiMatchAny(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), materialize(['hel+o', 'w(or)*ld']));
SET allow_hyperscan = 0;
SELECT multiMatchAny(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), ['hel+o', 'w(or)*ld']);
SELECT multiMatchAny(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), materialize(['hel+o', 'w(or)*ld']));
SELECT multiMatchAllIndices(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), ['hel+o', 'w(or)*ld']);
SELECT multiMatchAllIndices(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), materialize(['hel+o', 'w(or)*ld']));
SELECT multiSearchAny(arrayJoin(['hello', 'world', 'hello, world', 'abc']), ['hello', 'world']);