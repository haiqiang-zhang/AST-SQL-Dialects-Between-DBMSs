select number, arrayReduce( 'sumMap', [a],[b]  ) from (select [100,100,200] a,[10,20,30] b, number from numbers(1));
select dumpColumnStructure([a]), arrayReduce('sumMap', [a], [a]) from (select [1, 2] a FROM numbers(2));
