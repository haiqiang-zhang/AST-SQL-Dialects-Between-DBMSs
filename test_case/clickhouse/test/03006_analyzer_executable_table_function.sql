SELECT
    toFixedString(toFixedString(toLowCardinality(toFixedString('--------------------', toNullable(20))), toLowCardinality(20)), 20),
    *
FROM executable('data String', SETTINGS max_command_execution_time = 100);