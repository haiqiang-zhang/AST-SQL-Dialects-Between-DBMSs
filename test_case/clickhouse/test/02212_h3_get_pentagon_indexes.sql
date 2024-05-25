SELECT h3GetPentagonIndexes(resolution) AS indexes from table1 order by indexes;
DROP TABLE table1;
SELECT '-- test for const cols';
SELECT h3GetPentagonIndexes(arrayJoin([0,1,2,3,4,5,6,7,8,9,10]));
