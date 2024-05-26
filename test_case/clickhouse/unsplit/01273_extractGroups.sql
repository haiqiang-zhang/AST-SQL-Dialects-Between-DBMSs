SELECT '0 groups, zero matches';
SELECT '1 group, multiple matches, String and FixedString';
SELECT extractGroups('hello world', '(\\w+) (\\w+)');
SELECT 'multiple matches';
SELECT 'big match';
SELECT
    length(haystack), length(matches), arrayMap((x) -> length(x), matches)
FROM (
    SELECT
        repeat('abcdefghijklmnopqrstuvwxyz', number * 10) AS haystack,
        extractGroups(haystack, '(abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz)') AS matches
    FROM numbers(3)
);
SELECT 'lots of matches';
SELECT
    length(haystack), length(matches), arrayReduce('sum', arrayMap((x) -> length(x), matches))
FROM (
    SELECT
        repeat('abcdefghijklmnopqrstuvwxyz', number * 10) AS haystack,
        extractGroups(haystack, '(\\w)') AS matches
    FROM numbers(3)
);
SELECT 'lots of groups';
