CREATE MATERIALIZED VIEW mv_00508 TO dst AS SELECT * FROM src;
INSERT INTO src VALUES (1), (2);
SELECT * FROM mv_00508 ORDER BY x;
DETACH TABLE mv_00508;
SELECT * FROM dst ORDER BY x;
USE default;
