SELECT * FROM CIRCLE_TBL;
SELECT center(f1) AS center
  FROM CIRCLE_TBL;
SELECT radius(f1) AS radius
  FROM CIRCLE_TBL;
SELECT diameter(f1) AS diameter
  FROM CIRCLE_TBL;
SELECT f1 FROM CIRCLE_TBL WHERE radius(f1) < 5;
SELECT f1 FROM CIRCLE_TBL WHERE diameter(f1) >= 10;
SELECT c1.f1 AS one, c2.f1 AS two, (c1.f1 <-> c2.f1) AS distance
  FROM CIRCLE_TBL c1, CIRCLE_TBL c2
  WHERE (c1.f1 < c2.f1) AND ((c1.f1 <-> c2.f1) > 0)
  ORDER BY distance, area(c1.f1), area(c2.f1);
