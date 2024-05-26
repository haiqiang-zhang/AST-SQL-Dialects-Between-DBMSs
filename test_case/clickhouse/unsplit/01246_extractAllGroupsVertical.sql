SELECT '1 group, multiple matches, String and FixedString';
SELECT extractAllGroupsVertical('hello world', '(\\w+)');
SELECT 'mutiple groups, multiple matches';
SELECT 'big match';
SELECT
    length(haystack), length(matches[1]), length(matches), arrayMap((x) -> length(x), arrayMap(x -> x[1], matches))
FROM (
    SELECT
        repeat('abcdefghijklmnopqrstuvwxyz', number * 10) AS haystack,
        extractAllGroupsVertical(haystack, '(abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz)') AS matches
    FROM numbers(3)
);
SELECT 'lots of matches';
SELECT
    length(haystack), length(matches[1]), length(matches), arrayReduce('sum', arrayMap((x) -> length(x), arrayMap(x -> x[1], matches)))
FROM (
    SELECT
        repeat('abcdefghijklmnopqrstuvwxyz', number * 10) AS haystack,
        extractAllGroupsVertical(haystack, '(\\w)') AS matches
    FROM numbers(3)
);
SELECT 'lots of groups';
