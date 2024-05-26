select 'if with one LC argument';
select if(0, toLowCardinality('a'), 'b');
select if(number % 2, toLowCardinality('a'), 'b') from numbers(2);
select 'if with LC and NULL arguments';
select 'if with two LC arguments';
