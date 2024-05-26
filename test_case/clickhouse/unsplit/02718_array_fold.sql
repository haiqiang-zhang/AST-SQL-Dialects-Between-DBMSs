SELECT '-- Negative tests';
SELECT '-- Const arrays';
SELECT arrayFold( acc,x -> acc+x*2,  [1, 2, 3, 4], toInt64(3));
SELECT '-- Non-const arrays';
SELECT '-- Bug 57458';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab (line String, patterns Array(String)) ENGINE = MergeTree ORDER BY line;
INSERT INTO tab VALUES ('abcdef', ['c']), ('ghijkl', ['h', 'k']), ('mnopqr', ['n']);
DROP TABLE tab;
CREATE TABLE tab (line String) ENGINE = Memory();
INSERT INTO tab VALUES ('xxx..yyy..'), ('..........'), ('..xx..yyy.'), ('..........'), ('xxx.......');
SELECT
    line,
    splitByNonAlpha(line),
    arrayFold(
        (acc, str) -> position(line, str),
        splitByNonAlpha(line),
        0::UInt64
    )
FROM
    tab;
DROP TABLE tab;
SELECT ' -- Bug 57816';
