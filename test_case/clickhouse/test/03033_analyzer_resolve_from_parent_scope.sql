WITH (SELECT v FROM vecs_Float32 limit 1) AS a SELECT count(dp) FROM (SELECT dotProduct(a, v) AS dp FROM vecs_Float32);
