select match('a key="v" ', 'key="(.*?)"');
select match(materialize('a key="v" '), 'key="(.*?)"');
select match('\0 key="v" ', 'key="(.*?)"');
select match(materialize('\0 key="v" '), 'key="(.*?)"');
select multiMatchAny('\0 key="v" ', ['key="(.*?)"']);
select multiMatchAny(materialize('\0 key="v" '), ['key="(.*?)"']);
select unhex('34') || ' key="v" ' as haystack, length(haystack), extract( haystack, 'key="(.*?)"') as needle;
select unhex('00') || ' key="v" ' as haystack, length(haystack), extract( haystack, 'key="(.*?)"') as needle;
select number as char_code,  extract( char(char_code) || ' key="v" ' as haystack, 'key="(.*?)"') as needle from numbers(256);
