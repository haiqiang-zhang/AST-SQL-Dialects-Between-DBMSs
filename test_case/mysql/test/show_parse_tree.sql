    JOIN tab t2 ON t1.col1=t2.col2 JOIN tab t3 ON t1.col1 <= t3.col3;

-- Case
SHOW PARSE_TREE SELECT CASE a WHEN b THEN c WHEN d THEN e ELSE f END,
                       CASE a WHEN b THEN c END,
                       CASE WHEN a THEN b ELSE c END;
       CASE a
       WHEN
          CASE WHEN a1 THEN b2 END
       THEN c
       ELSE f END;

-- Charsets.
SHOW PARSE_TREE SELECT db.func(), char(col1), char(col1 USING utf8mb4), concat(a,b), concat(a,b) COLLATE utf8mb4_turkish_ci;
