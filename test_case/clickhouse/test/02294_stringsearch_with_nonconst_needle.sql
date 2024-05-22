drop table if exists non_const_needle;
create table non_const_needle
  (id UInt32, haystack String, needle String)
  engine = MergeTree()
  order by id;
insert into non_const_needle values (1, 'Hello', '') (2, 'Hello', '%') (3, 'Hello', '%%') (4, 'Hello', '%%%') (5, 'Hello', '%_%') (6, 'Hello', '_') (7, 'Hello', '_%') (8, 'Hello', '%_') (9, 'Hello', 'H%o') (10, 'hello', 'H%0') (11, 'hello', 'h%o') (12, 'Hello', 'h%o') (13, 'OHello', '%lhell%') (14, 'OHello', '%hell%') (15, 'hEllo', '%HEL%') (16, 'abcdef', '%aBc%def%') (17, 'ABCDDEF', '%abc%def%') (18, 'Abc\nDef', '%abc%def%') (19, 'abc\ntdef', '%abc%def%') (20, 'abct\ndef', '%abc%dEf%') (21, 'abc\n\ndeF', '%abc%def%') (22, 'abc\n\ntdef', '%abc%deF%') (23, 'Abc\nt\ndef', '%abc%def%') (24, 'abct\n\ndef', '%abc%def%') (25, 'ab\ndef', '%Abc%def%') (26, 'aBc\nef', '%ABC%DEF%') (27, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ') (28, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¾ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ') (29, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¾ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ') (30, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¿ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ½ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¿%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµ%') (31, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¿ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ½ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµ%') (32, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¾ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ%') (33, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¾ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ', '%ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ%') (34, 'Hello', '.*') (35, 'Hello', '.*ell.*') (36, 'Hello', 'o$') (37, 'Hello', 'hE.*lO');
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
select 1 = multiSearchAnyUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£']));
select 1 = multiSearchAnyCaseInsensitiveUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD']));
select 'MULTISEARCHFIRSTINDEX';
select 0 = multiSearchFirstIndex('Hello World', CAST([], 'Array(String)'));
select 1 = multiSearchFirstIndex(materialize('Hello World'), materialize(['orld']));
select 0 = multiSearchFirstIndex(materialize('Hello World'), materialize(['Hallo', 'Welt']));
select 2 = multiSearchFirstIndex(materialize('Hello World'), materialize(['Hallo', 'orld']));
select 1 = multiSearchFirstIndexCaseInsensitive(materialize('Hello World'), materialize(['WORLD']));
select 2 = multiSearchFirstIndexUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£']));
select 1 = multiSearchFirstIndexCaseInsensitiveUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD']));
select 'MULTISEARCHFIRSTPOSITION';
select 0 = multiSearchFirstPosition('Hello World', CAST([], 'Array(String)'));
select 8 = multiSearchFirstPosition(materialize('Hello World'), materialize(['orld']));
select 0 = multiSearchFirstPosition(materialize('Hello World'), materialize(['Hallo', 'Welt']));
select 8 = multiSearchFirstPosition(materialize('Hello World'), materialize(['Hallo', 'orld']));
select 7 = multiSearchFirstPositionCaseInsensitive(materialize('Hello World'), materialize(['WORLD']));
select 13 = multiSearchFirstPositionUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD', 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£']));
select 7 = multiSearchFirstPositionCaseInsensitiveUTF8(materialize('Hello World ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£'), materialize(['WORLD']));
