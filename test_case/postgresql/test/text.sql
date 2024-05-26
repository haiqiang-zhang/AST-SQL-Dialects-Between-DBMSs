SELECT text 'this is a text string' = text 'this is a text string' AS true;
SELECT text 'this is a text string' = text 'this is a text strin' AS false;
select 'four: '::text || 2+2;
select 'four: ' || 2+2;
select concat('one');
select concat_ws('#','one');
select reverse('abcde');
select i, left('ahoj', i), right('ahoj', i) from generate_series(-5, 5) t(i) order by i;
select quote_literal('');
select concat(variadic '{}'::int[]) = '';
select format(NULL);
select format(string_agg('%s',','), variadic array_agg(i))
from generate_series(1,200) g(i);
