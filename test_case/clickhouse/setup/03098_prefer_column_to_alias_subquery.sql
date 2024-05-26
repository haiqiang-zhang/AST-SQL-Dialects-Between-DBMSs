DROP TABLE IF EXISTS clickhouse_alias_issue_1;
DROP TABLE IF EXISTS clickhouse_alias_issue_2;
CREATE TABLE clickhouse_alias_issue_1 (
    id bigint,
    column_1 Nullable(Float32)
) Engine=Memory;
CREATE TABLE clickhouse_alias_issue_2 (
    id bigint,
    column_2 Nullable(Float32)
) Engine=Memory;
SET allow_experimental_analyzer = 1;
INSERT INTO `clickhouse_alias_issue_1`
VALUES (1, 100), (2, 200), (3, 300);
INSERT INTO `clickhouse_alias_issue_2`
VALUES (1, 10), (2, 20), (3, 30);
