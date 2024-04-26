SET optimizer_switch='hash_set_operations=off';
SET optimizer_switch='hash_set_operations=default';
let $char_type=VARCHAR(60);
let $char_type=TEXT;
CREATE TABLE t(i INT) ENGINE=innodb;

INSERT INTO t
   WITH RECURSIVE cte AS (
      SELECT 0 AS i
      UNION
      SELECT 1 AS i
      UNION
      SELECT i+2 FROM cte
      WHERE i+2 < 1024
   )
   SELECT i FROM cte;

-- insert one duplicate of each row
INSERT INTO t select i FROM  t;
SET SESSION set_operations_buffer_size = 16384;
SELECT * FROM (SELECT * FROM t INTERSECT SELECT * FROM t) AS derived ORDER BY i LIMIT 2;
SET SESSION set_operations_buffer_size = default;

DROP TABLE t;
