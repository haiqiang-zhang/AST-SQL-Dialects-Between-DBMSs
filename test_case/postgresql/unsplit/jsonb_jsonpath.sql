select jsonb '{"a": 12}' @? '$';
select jsonb '{"a": 12}' @? '1';
select jsonb '{"a": 12}' @? '$.a.b';
select jsonb '{"a": 12}' @? '$.b';
select jsonb '{"a": 12}' @? '$.a + 2';
select jsonb '{"a": 12}' @? '$.b + 2';
select jsonb '{"a": {"a": 12}}' @? '$.a.a';
select jsonb '{"a": {"a": 12}}' @? '$.*.a';
select jsonb '{"b": {"a": 12}}' @? '$.*.a';
select jsonb '{"b": {"a": 12}}' @? '$.*.b';
select jsonb '{"b": {"a": 12}}' @? 'strict $.*.b';
select jsonb '{}' @? '$.*';
select jsonb '{"a": 1}' @? '$.*';
select jsonb '{"a": {"b": 1}}' @? 'lax $.**{1}';
select jsonb '{"a": {"b": 1}}' @? 'lax $.**{2}';
select jsonb '{"a": {"b": 1}}' @? 'lax $.**{3}';
select jsonb '[]' @? '$[*]';
select jsonb '[1]' @? '$[*]';
select jsonb '[1]' @? '$[1]';
select jsonb '[1]' @? 'strict $[1]';
select jsonb_path_query('[1]', 'strict $[1]', silent => true);
select jsonb '[1]' @? 'lax $[10000000000000000]';
select jsonb '[1]' @? 'strict $[10000000000000000]';
select jsonb '[1]' @? '$[0]';
select jsonb '[1]' @? '$[0.3]';
select jsonb '[1]' @? '$[0.5]';
select jsonb '[1]' @? '$[0.9]';
select jsonb '[1]' @? '$[1.2]';
select jsonb '[1]' @? 'strict $[1.2]';
select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$ ? (@.a[*] >  @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$ ? (@.a[*] >= @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,"5"]}' @? '$ ? (@.a[*] >= @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,"5"]}' @? 'strict $ ? (@.a[*] >= @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,null]}' @? '$ ? (@.a[*] >= @.b[*])';
select jsonb '1' @? '$ ? ((@ == "1") is unknown)';
select jsonb '1' @? '$ ? ((@ == 1) is unknown)';
select jsonb '[{"a": 1}, {"a": 2}]' @? '$[0 to 1] ? (@.a > 1)';
select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'lax $[*].a', silent => false);
select jsonb '{"a": {"b": 1}}' @? '$.**.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{0}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{1}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{0 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{1 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{1 to 2}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{0}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{0 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1 to 2}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{2 to 3}.b ? ( @ > 0)';
select
	x, y,
	jsonb_path_query(
		'[true, false, null]',
		'$[*] ? (@ == true  &&  ($x == true && $y == true) ||
				 @ == false && !($x == true && $y == true) ||
				 @ == null  &&  ($x == true && $y == true) is unknown)',
		jsonb_build_object('x', x, 'y', y)
	) as "x && y"
from
	(values (jsonb 'true'), ('false'), ('"null"')) x(x),
	(values (jsonb 'true'), ('false'), ('"null"')) y(y);
select jsonb '{"a": 1, "b":1}' @? '$ ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$ ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.c ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.c ? ($.c.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.* ? (@.a == @.b)';
select jsonb '{"a": 1, "b":1}' @? '$.** ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.** ? (@.a == @.b)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == - 1)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == -1)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == -@.b)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == - @.b)';
select jsonb '{"c": {"a": 0, "b":1}}' @? '$.** ? (@.a == 1 - @.b)';
select jsonb '{"c": {"a": 2, "b":1}}' @? '$.** ? (@.a == 1 - - @.b)';
select jsonb '{"c": {"a": 0, "b":1}}' @? '$.** ? (@.a == 1 - +@.b)';
select jsonb '[1,2,3]' @? '$ ? (+@[*] > +2)';
select jsonb '[1,2,3]' @? '$ ? (+@[*] > +3)';
select jsonb '[1,2,3]' @? '$ ? (-@[*] < -2)';
select jsonb '[1,2,3]' @? '$ ? (-@[*] < -3)';
select jsonb '1' @? '$ ? ($ > 0)';
select jsonb '["1",2,0,3]' @? '-$[*]';
select jsonb '[1,"2",0,3]' @? '-$[*]';
select jsonb '["1",2,0,3]' @? 'strict -$[*]';
select jsonb '[1,"2",0,3]' @? 'strict -$[*]';
select jsonb '2' @? '$ == "2"';
select jsonb '2' @@ '$ > 1';
select jsonb '2' @@ '$ <= 1';
select jsonb '2' @@ '$ == "2"';
select jsonb '2' @@ '1';
select jsonb '{}' @@ '$';
select jsonb '[]' @@ '$';
select jsonb '[1,2,3]' @@ '$[*]';
select jsonb '[]' @@ '$[*]';
select jsonb_path_match('[[1, true], [2, false]]', 'strict $[*] ? (@[0] > $x) [1]', '{"x": 1}');
select jsonb '{"a": 1, "b": [1, 2]}' @? 'lax $.keyvalue()';
select jsonb '{"a": 1, "b": [1, 2]}' @? 'lax $.keyvalue().key';
select jsonb '"10-03-2017"' @? '$.datetime("dd-mm-yyyy")';
set time zone '+00';
set time zone '+10';
set time zone default;
set time zone '+00';
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ == "10.03.2017".datetime("dd.mm.yyyy"))');
set time zone default;
SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}]', '$[*].a');
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {}]', 'strict $[*].a', silent => true);
SELECT jsonb '[{"a": 1}, {"a": 2}]' @? '$[*].a ? (@ > 1)';
SELECT jsonb '[{"a": 1}, {"a": 2}]' @? '$[*] ? (@.a > 2)';
SELECT jsonb '[{"a": 1}, {"a": 2}]' @@ '$[*].a > 1';
SELECT jsonb '[{"a": 1}, {"a": 2}]' @@ '$[*].a > 2';
WITH str(j, num) AS
(
	SELECT jsonb_build_object('s', s), num
	FROM unnest('{"", "a", "ab", "abc", "abcd", "b", "A", "AB", "ABC", "ABc", "ABcD", "B"}'::text[]) WITH ORDINALITY AS a(s, num)
)
SELECT
	s1.j, s2.j,
	jsonb_path_query_first(s1.j, '$.s < $s', vars => s2.j) lt,
	jsonb_path_query_first(s1.j, '$.s <= $s', vars => s2.j) le,
	jsonb_path_query_first(s1.j, '$.s == $s', vars => s2.j) eq,
	jsonb_path_query_first(s1.j, '$.s >= $s', vars => s2.j) ge,
	jsonb_path_query_first(s1.j, '$.s > $s', vars => s2.j) gt
FROM str s1, str s2
ORDER BY s1.num, s2.num;
