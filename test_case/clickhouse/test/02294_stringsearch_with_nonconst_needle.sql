select 'LIKE';
select id, haystack, needle, like(haystack, needle)
  from non_const_needle
  order by id;
select 'NOT LIKE';
select id, haystack, needle, not like(haystack, needle)
  from non_const_needle
  order by id;
select 'ILIKE';
select id, haystack, needle, ilike(haystack, needle)
  from non_const_needle
  order by id;
select 'NOT ILIKE';
select id, haystack, needle, not ilike(haystack, needle)
  from non_const_needle
  order by id;
select 'MATCH';
select id, haystack, needle, match(haystack, needle)
  from non_const_needle
  order by id;
drop table if exists non_const_needle;
select 'MULTISEARCHANY';
select 0 = multiSearchAny('Hello World', CAST([], 'Array(String)'));
select 1 = multiSearchAny(materialize('Hello World'), materialize(['orld']));
select 0 = multiSearchAny(materialize('Hello World'), materialize(['Hallo', 'Welt']));
select 1 = multiSearchAny(materialize('Hello World'), materialize(['Hallo', 'orld']));
select 1 = multiSearchAnyCaseInsensitive(materialize('Hello World'), materialize(['WORLD']));
select 1 = multiSearchAnyUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£']));
select 1 = multiSearchAnyCaseInsensitiveUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD']));
select 'MULTISEARCHFIRSTINDEX';
select 0 = multiSearchFirstIndex('Hello World', CAST([], 'Array(String)'));
select 1 = multiSearchFirstIndex(materialize('Hello World'), materialize(['orld']));
select 0 = multiSearchFirstIndex(materialize('Hello World'), materialize(['Hallo', 'Welt']));
select 2 = multiSearchFirstIndex(materialize('Hello World'), materialize(['Hallo', 'orld']));
select 1 = multiSearchFirstIndexCaseInsensitive(materialize('Hello World'), materialize(['WORLD']));
select 2 = multiSearchFirstIndexUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£']));
select 1 = multiSearchFirstIndexCaseInsensitiveUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD']));
select 'MULTISEARCHFIRSTPOSITION';
select 0 = multiSearchFirstPosition('Hello World', CAST([], 'Array(String)'));
select 8 = multiSearchFirstPosition(materialize('Hello World'), materialize(['orld']));
select 0 = multiSearchFirstPosition(materialize('Hello World'), materialize(['Hallo', 'Welt']));
select 8 = multiSearchFirstPosition(materialize('Hello World'), materialize(['Hallo', 'orld']));
select 7 = multiSearchFirstPositionCaseInsensitive(materialize('Hello World'), materialize(['WORLD']));
select 13 = multiSearchFirstPositionUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£']));
select 7 = multiSearchFirstPositionCaseInsensitiveUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD']));