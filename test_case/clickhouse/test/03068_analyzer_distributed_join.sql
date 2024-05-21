-- Closes: https://github.com/ClickHouse/ClickHouse/issues/6571

SET allow_experimental_analyzer=1;
SET joined_subquery_requires_alias=0;
SET joined_subquery_requires_alias=1;
