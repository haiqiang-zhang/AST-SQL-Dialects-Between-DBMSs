SELECT a, b, 'abc' FROM t1
      UNION
      SELECT b, a, 'xyz' FROM t1
      ORDER BY 2, 3;
