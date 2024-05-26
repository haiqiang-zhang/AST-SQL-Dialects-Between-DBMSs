SELECT multiMatchAny(arrayJoin(['hello', 'world', 'hellllllllo', 'wororld', 'abc']), ['hel+o', 'w(or)*ld']);
SET allow_hyperscan = 0;
SELECT multiSearchAny(arrayJoin(['hello', 'world', 'hello, world', 'abc']), ['hello', 'world']);
