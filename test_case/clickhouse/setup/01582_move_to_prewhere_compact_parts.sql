SET optimize_move_to_prewhere = 1;
SET convert_query_to_cnf = 0;
DROP TABLE IF EXISTS prewhere_move;
CREATE TABLE prewhere_move (x Int, y String) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO prewhere_move SELECT number, toString(number) FROM numbers(1000);
