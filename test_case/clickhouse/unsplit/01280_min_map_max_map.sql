select minMap([toInt32(number % 10), number % 10 + 1], [number, 1]) as m, toTypeName(m) from numbers(1, 100);
select minMap([1], [toInt32(number) - 50]) from numbers(1, 100);
select maxMap([1], [toInt32(number) - 50]) from numbers(1, 100);
select minMap(val, cnt) from values ('val Array(UUID), cnt Array(UUID)',
	(['01234567-89ab-cdef-0123-456789abcdef'], ['01111111-89ab-cdef-0123-456789abcdef']),
	(['01234567-89ab-cdef-0123-456789abcdef'], ['02222222-89ab-cdef-0123-456789abcdef']));
select maxMap(val, cnt) from values ('val Array(UUID), cnt Array(UUID)',
	(['01234567-89ab-cdef-0123-456789abcdef'], ['01111111-89ab-cdef-0123-456789abcdef']),
	(['01234567-89ab-cdef-0123-456789abcdef'], ['02222222-89ab-cdef-0123-456789abcdef']));
select sumMap(val, cnt) from values ('val Array(UInt64), cnt Array(UInt64)',  ([1], [0]), ([2], [0]));
