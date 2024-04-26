
let $engine=innodb;

SET debug= '+d,bug30769515_QUERY_INTERRUPTED';
SELECT a, b, MAX(d), MIN(d) FROM t
WHERE (a > 6) AND (c = 3 OR c = 40) AND
      (d = 11 OR d = 12)
GROUP BY a, b;
SET debug= '-d,bug30769515_QUERY_INTERRUPTED';


ALTER TABLE t DROP KEY k1;
ALTER TABLE t ADD KEY k1(a, b DESC, c, d DESC);
SET debug= '+d,bug30769515_QUERY_INTERRUPTED';
SELECT a, b, MAX(d), MIN(d) FROM t
WHERE (a > 6) AND (c = 3 OR c = 40) AND
      (d = 11 OR d = 12)
GROUP BY a, b;
SET debug= '-d,bug30769515_QUERY_INTERRUPTED';

DROP TABLE t;
