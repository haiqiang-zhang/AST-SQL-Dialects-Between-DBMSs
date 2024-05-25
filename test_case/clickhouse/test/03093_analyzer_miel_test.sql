SET allow_experimental_analyzer=1;
select app, arrayZip(untuple(sumMap(k.keys, replicate(1, k.keys)))) from test_03093 PREWHERE c > 1 group by app;
select app, arrayZip(untuple(sumMap(k.keys, replicate(1, k.keys)))) from test_03093 WHERE c > 1 group by app;
DROP TABLE IF EXISTS test_03093;
