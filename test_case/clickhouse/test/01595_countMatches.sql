select 'basic';
select countMatches('', 'foo');
select 'case sensitive';
select countMatches(concat(toString(number), 'foofoo'), 'foo') from numbers(2);
select 'case insensitive';
select countMatchesCaseInsensitive('foobarfoo', 'FOo');
select countMatchesCaseInsensitive(concat(toString(number), 'Foofoo'), 'foo') from numbers(2);
select 'errors';
select 'FixedString';
