SELECT 'a\_\c\l\i\c\k\h\o\u\s\e', 'a\\_\\c\\l\\i\\c\\k\\h\\o\\u\\s\\e';
select 'aXb' like 'a_b', 'aXb' like 'a\_b', 'a_b' like 'a\_b', 'a_b' like 'a\\_b';
SELECT match('Hello', '\w+'), match('Hello', '\\w+'), match('Hello', '\\\w+'), match('Hello', '\w\+'), match('Hello', 'w+');
