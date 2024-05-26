SELECT
    range(1),
    arrayMap(x -> arrayMap(x -> x, range(x)), [1])
SETTINGS allow_experimental_analyzer = 0;
