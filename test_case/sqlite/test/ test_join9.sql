CREATE TABLE t3(id INTEGER PRIMARY KEY, w TEXT);
CREATE TABLE t4(id INTEGER PRIMARY KEY, x TEXT);
CREATE TABLE t5(id INTEGER PRIMARY KEY, y TEXT);
CREATE TABLE t6(id INTEGER PRIMARY KEY, z INT);
CREATE VIEW dual(dummy) AS VALUES('x');
INSERT INTO t3(id,w) VALUES(2,'two'),(3,'three'),(6,'six'),(7,'seven');
INSERT INTO t4(id,x) VALUES(2,'alice'),(4,'bob'),(6,'cindy'),(8,'dave');
INSERT INTO t5(id,y) VALUES(1,'red'),(2,'orange'),(3,'yellow'),(4,'green'),
                               (5,'blue');
INSERT INTO t6(id,z) VALUES(3,333),(4,444),(5,555),(0,1000),(9,999);
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 LEFT JOIN t5 USING(id) LEFT JOIN t6 USING(id)
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t6 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t4 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t6 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t4 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t5 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, w, x, y, z
      FROM t3 FULL JOIN t4 USING(id)
              NATURAL FULL JOIN t5
              FULL JOIN t6 USING(id)
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      WHERE x<>'bob' OR x IS NULL
      ORDER BY 1;
WITH t7(id,a) AS MATERIALIZED (SELECT * FROM t4 WHERE false)
    SELECT *
      FROM t7 
           JOIN t7 AS t7b USING(id)
           FULL JOIN t3 USING(id);
SELECT *
      FROM (t3 NATURAL FULL JOIN t4)
           NATURAL FULL JOIN
           (t5 NATURAL FULL JOIN t6)
    ORDER BY 1;
SELECT *
      FROM t3 NATURAL FULL JOIN 
           (t4 NATURAL FULL JOIN
            (t5 NATURAL FULL JOIN t6))
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
               t4 FULL JOIN (
                   t5 FULL JOIN t6 USING(id)
               ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 RIGHT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 LEFT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
WITH t56(id,y,z) AS (SELECT * FROM t5 FULL JOIN t6 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t4 JOIN t56 USING(id)
    ORDER BY 1;
SELECT id,x,y,z
      FROM t4 INNER JOIN (t5 FULL JOIN t6 USING(id)) USING(id)
     ORDER BY 1;
SELECT id,x,y,z
      FROM t4 FULL JOIN t5 USING(id) INNER JOIN t6 USING(id)
     ORDER BY 1;
WITH t45(id,x,y) AS (SELECT * FROM t4 FULL JOIN t5 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t45 JOIN t6 USING(id)
    ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 LEFT JOIN t5 USING(id) LEFT JOIN t6 USING(id)
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t6 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t4 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t6 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t4 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t5 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, w, x, y, z
      FROM t3 FULL JOIN t4 USING(id)
              NATURAL FULL JOIN t5
              FULL JOIN t6 USING(id)
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      WHERE x<>'bob' OR x IS NULL
      ORDER BY 1;
WITH t7(id,a) AS MATERIALIZED (SELECT * FROM t4 WHERE false)
    SELECT *
      FROM t7 
           JOIN t7 AS t7b USING(id)
           FULL JOIN t3 USING(id);
SELECT *
      FROM (t3 NATURAL FULL JOIN t4)
           NATURAL FULL JOIN
           (t5 NATURAL FULL JOIN t6)
    ORDER BY 1;
SELECT *
      FROM t3 NATURAL FULL JOIN 
           (t4 NATURAL FULL JOIN
            (t5 NATURAL FULL JOIN t6))
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
               t4 FULL JOIN (
                   t5 FULL JOIN t6 USING(id)
               ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 RIGHT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 LEFT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
WITH t56(id,y,z) AS (SELECT * FROM t5 FULL JOIN t6 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t4 JOIN t56 USING(id)
    ORDER BY 1;
SELECT id,x,y,z
      FROM t4 INNER JOIN (t5 FULL JOIN t6 USING(id)) USING(id)
     ORDER BY 1;
SELECT id,x,y,z
      FROM t4 FULL JOIN t5 USING(id) INNER JOIN t6 USING(id)
     ORDER BY 1;
WITH t45(id,x,y) AS (SELECT * FROM t4 FULL JOIN t5 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t45 JOIN t6 USING(id)
    ORDER BY 1;
CREATE TABLE t3x(id INTEGER PRIMARY KEY, w TEXT);
CREATE TABLE t4x(id INTEGER PRIMARY KEY, x TEXT);
CREATE TABLE t5x(id INTEGER PRIMARY KEY, y TEXT);
CREATE TABLE t6x(id INTEGER PRIMARY KEY, z INT);
INSERT INTO t3x(id,w) VALUES(2,'two'),(3,'three'),(6,'six'),(7,'seven');
INSERT INTO t4x(id,x) VALUES(2,'alice'),(4,'bob'),(6,'cindy'),(8,'dave');
INSERT INTO t5x(id,y) VALUES(1,'red'),(2,'orange'),(3,'yellow'),(4,'green'),
                               (5,'blue');
INSERT INTO t6x(id,z) VALUES(3,333),(4,444),(5,555),(0,1000),(9,999);
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 LEFT JOIN t5 USING(id) LEFT JOIN t6 USING(id)
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t6 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t4 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t6 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t4 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t5 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, w, x, y, z
      FROM t3 FULL JOIN t4 USING(id)
              NATURAL FULL JOIN t5
              FULL JOIN t6 USING(id)
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      WHERE x<>'bob' OR x IS NULL
      ORDER BY 1;
WITH t7(id,a) AS MATERIALIZED (SELECT * FROM t4 WHERE false)
    SELECT *
      FROM t7 
           JOIN t7 AS t7b USING(id)
           FULL JOIN t3 USING(id);
SELECT *
      FROM (t3 NATURAL FULL JOIN t4)
           NATURAL FULL JOIN
           (t5 NATURAL FULL JOIN t6)
    ORDER BY 1;
SELECT *
      FROM t3 NATURAL FULL JOIN 
           (t4 NATURAL FULL JOIN
            (t5 NATURAL FULL JOIN t6))
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
               t4 FULL JOIN (
                   t5 FULL JOIN t6 USING(id)
               ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 RIGHT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 LEFT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
WITH t56(id,y,z) AS (SELECT * FROM t5 FULL JOIN t6 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t4 JOIN t56 USING(id)
    ORDER BY 1;
SELECT id,x,y,z
      FROM t4 INNER JOIN (t5 FULL JOIN t6 USING(id)) USING(id)
     ORDER BY 1;
SELECT id,x,y,z
      FROM t4 FULL JOIN t5 USING(id) INNER JOIN t6 USING(id)
     ORDER BY 1;
WITH t45(id,x,y) AS (SELECT * FROM t4 FULL JOIN t5 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t45 JOIN t6 USING(id)
    ORDER BY 1;
CREATE TABLE t3a(id INTEGER PRIMARY KEY, w TEXT);
CREATE TABLE t3b(id INTEGER PRIMARY KEY, w TEXT);
CREATE TABLE t4a(id INTEGER PRIMARY KEY, x TEXT);
CREATE TABLE t4b(id INTEGER PRIMARY KEY, x TEXT);
CREATE TABLE t5a(id INTEGER PRIMARY KEY, y TEXT);
CREATE TABLE t5b(id INTEGER PRIMARY KEY, y TEXT);
CREATE TABLE t6a(id INTEGER PRIMARY KEY, z INT);
CREATE TABLE t6b(id INTEGER PRIMARY KEY, z INT);
INSERT INTO t3a(id,w) VALUES(2,'two'),(3,'three');
INSERT INTO t3b(id,w) VALUES(6,'six'),(7,'seven');
INSERT INTO t4a(id,x) VALUES(2,'alice'),(4,'bob');
INSERT INTO t4b(id,x) VALUES(6,'cindy'),(8,'dave');
INSERT INTO t5a(id,y) VALUES(1,'red'),(2,'orange'),(3,'yellow');
INSERT INTO t5b(id,y) VALUES(4,'green'),(5,'blue');
INSERT INTO t6a(id,z) VALUES(3,333),(4,444);
INSERT INTO t6b(id,z) VALUES(5,555),(0,1000),(9,999);
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 LEFT JOIN t5 USING(id) LEFT JOIN t6 USING(id)
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t6 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t4 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t6 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t4 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t5 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, w, x, y, z
      FROM t3 FULL JOIN t4 USING(id)
              NATURAL FULL JOIN t5
              FULL JOIN t6 USING(id)
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      WHERE x<>'bob' OR x IS NULL
      ORDER BY 1;
WITH t7(id,a) AS MATERIALIZED (SELECT * FROM t4 WHERE false)
    SELECT *
      FROM t7 
           JOIN t7 AS t7b USING(id)
           FULL JOIN t3 USING(id);
SELECT *
      FROM (t3 NATURAL FULL JOIN t4)
           NATURAL FULL JOIN
           (t5 NATURAL FULL JOIN t6)
    ORDER BY 1;
SELECT *
      FROM t3 NATURAL FULL JOIN 
           (t4 NATURAL FULL JOIN
            (t5 NATURAL FULL JOIN t6))
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
               t4 FULL JOIN (
                   t5 FULL JOIN t6 USING(id)
               ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 RIGHT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 LEFT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
WITH t56(id,y,z) AS (SELECT * FROM t5 FULL JOIN t6 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t4 JOIN t56 USING(id)
    ORDER BY 1;
SELECT id,x,y,z
      FROM t4 INNER JOIN (t5 FULL JOIN t6 USING(id)) USING(id)
     ORDER BY 1;
SELECT id,x,y,z
      FROM t4 FULL JOIN t5 USING(id) INNER JOIN t6 USING(id)
     ORDER BY 1;
WITH t45(id,x,y) AS (SELECT * FROM t4 FULL JOIN t5 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t45 JOIN t6 USING(id)
    ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL LEFT JOIN t5 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 LEFT JOIN t5 USING(id) LEFT JOIN t6 USING(id)
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY 1;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL RIGHT JOIN t4 NATURAL LEFT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL RIGHT JOIN t5 NATURAL RIGHT JOIN t6
     ORDER BY id;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY 1;
SELECT *, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t5 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t4 NATURAL FULL JOIN t6 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t4 NATURAL FULL JOIN t6
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t5 NATURAL FULL JOIN t6 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t4 NATURAL FULL JOIN t5
     ORDER BY id;
SELECT id, x, y, z, t4.id, t5.id, t6.id
      FROM t6 NATURAL FULL JOIN t5 NATURAL FULL JOIN t4
     ORDER BY id;
SELECT id, w, x, y, z
      FROM t3 FULL JOIN t4 USING(id)
              NATURAL FULL JOIN t5
              FULL JOIN t6 USING(id)
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      ORDER BY 1;
SELECT id, w, x, y, z
       FROM t3 JOIN dual AS d1 ON true
               FULL JOIN t4 USING(id)
               JOIN dual AS d2 ON true
               NATURAL FULL JOIN t5
               JOIN dual AS d3 ON true
               FULL JOIN t6 USING(id)
               CROSS JOIN dual AS d4
      WHERE x<>'bob' OR x IS NULL
      ORDER BY 1;
WITH t7(id,a) AS MATERIALIZED (SELECT * FROM t4 WHERE false)
    SELECT *
      FROM t7 
           JOIN t7 AS t7b USING(id)
           FULL JOIN t3 USING(id);
SELECT *
      FROM (t3 NATURAL FULL JOIN t4)
           NATURAL FULL JOIN
           (t5 NATURAL FULL JOIN t6)
    ORDER BY 1;
SELECT *
      FROM t3 NATURAL FULL JOIN 
           (t4 NATURAL FULL JOIN
            (t5 NATURAL FULL JOIN t6))
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
                t4 FULL JOIN (
                    t5 FULL JOIN t6 USING (id)
                ) USING(id)
           ) USING(id)
    ORDER BY 1;
SELECT *
      FROM t3 FULL JOIN (
               t4 FULL JOIN (
                   t5 FULL JOIN t6 USING(id)
               ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 RIGHT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
SELECT *
      FROM t3 FULL JOIN (
                t4 LEFT JOIN (
                    t5 FULL JOIN t6 USING(id)
                ) USING(id)
           ) AS j1 ON j1.id=t3.id
     ORDER BY coalesce(t3.id,j1.id);
WITH t56(id,y,z) AS (SELECT * FROM t5 FULL JOIN t6 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t4 JOIN t56 USING(id)
    ORDER BY 1;
SELECT id,x,y,z
      FROM t4 INNER JOIN (t5 FULL JOIN t6 USING(id)) USING(id)
     ORDER BY 1;
SELECT id,x,y,z
      FROM t4 FULL JOIN t5 USING(id) INNER JOIN t6 USING(id)
     ORDER BY 1;
WITH t45(id,x,y) AS (SELECT * FROM t4 FULL JOIN t5 USING(id) LIMIT 50)
    SELECT id,x,y,z FROM t45 JOIN t6 USING(id)
    ORDER BY 1;
