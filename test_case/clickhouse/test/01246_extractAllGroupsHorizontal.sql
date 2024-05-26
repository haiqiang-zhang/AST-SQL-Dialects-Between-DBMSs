SELECT '1 group, multiple matches, String and FixedString';
SELECT extractAllGroupsHorizontal('hello world', '(\\w+)');
SELECT 'mutiple groups, multiple matches';
SELECT 'big match';
SELECT
    length(haystack), length(matches), length(matches[1]), arrayMap((x) -> length(x), matches[1])
FROM (
    SELECT
           repeat('abcdefghijklmnopqrstuvwxyz', number * 10) AS haystack,
           extractAllGroupsHorizontal(haystack, '(abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz)') AS matches
    FROM numbers(3)
);
SELECT 'lots of matches';
SELECT
    length(haystack), length(matches), length(matches[1]), arrayReduce('sum', arrayMap((x) -> length(x), matches[1]))
FROM (
    SELECT
        repeat('abcdefghijklmnopqrstuvwxyz', number * 10) AS haystack,
        extractAllGroupsHorizontal(haystack, '(\\w)') AS matches
    FROM numbers(3)
);
SELECT 'lots of groups';
