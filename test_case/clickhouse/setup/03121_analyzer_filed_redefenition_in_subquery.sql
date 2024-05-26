SET allow_experimental_analyzer=1;
drop table if exists test_subquery;
CREATE TABLE test_subquery
ENGINE = Memory AS
SELECT 'base' AS my_field;
