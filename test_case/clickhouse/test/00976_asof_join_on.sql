SELECT A.a, A.t, B.b, B.t FROM A ASOF LEFT JOIN B ON A.a == B.b AND A.t >= B.t ORDER BY (A.a, A.t);
SELECT count() FROM A ASOF LEFT JOIN B ON A.a == B.b AND B.t <= A.t;
SELECT A.a, A.t, B.b, B.t FROM A ASOF INNER JOIN B ON B.t <= A.t AND A.a == B.b ORDER BY (A.a, A.t);
SELECT '-';
SELECT A.a, A.t, B.b, B.t FROM A ASOF JOIN B ON A.a == B.b AND A.t <= B.t ORDER BY (A.a, A.t);
SELECT '-';
SELECT A.a, A.t, B.b, B.t FROM A ASOF JOIN B ON A.a == B.b AND B.t >= A.t ORDER BY (A.a, A.t);
SELECT '-';
SELECT A.a, A.t, B.b, B.t FROM A ASOF JOIN B ON A.a == B.b AND A.t > B.t ORDER BY (A.a, A.t);
SELECT '-';
SELECT A.a, A.t, B.b, B.t FROM A ASOF JOIN B ON A.a == B.b AND A.t < B.t ORDER BY (A.a, A.t);
SELECT A.a, A.t, B.b, B.t FROM A
ASOF INNER JOIN (SELECT * FROM B UNION ALL SELECT 1, 3) AS B ON B.t <= A.t AND A.a == B.b
WHERE B.t != 3 ORDER BY (A.a, A.t);
DROP TABLE A;
DROP TABLE B;
