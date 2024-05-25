/*
1 2 3 4 5 6 7 8 9
------------------>
1---3
  2---------7
    3-------------
      4-----7
        5-----8
------------------>
1 2 3 3 4 4 4 2 1  //intersections count for each point
*/

SELECT maxIntersections(start,end) FROM test;
SELECT maxIntersectionsPosition(start,end) FROM test;
DROP TABLE test;
