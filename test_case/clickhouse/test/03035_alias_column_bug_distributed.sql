SET allow_experimental_analyzer=1;
DROP TABLE IF EXISTS alias_bug;
DROP TABLE IF EXISTS alias_bug_dist;
CREATE TABLE alias_bug
(
    `src` String,
    `theAlias` String ALIAS trimBoth(src)
)
ENGINE = MergeTree()
ORDER BY src;
INSERT INTO alias_bug VALUES ('SOURCE1');
DROP TABLE IF EXISTS alias_bug;
DROP TABLE IF EXISTS alias_bug_dist;
CREATE TABLE alias_bug
(
    `s` String,
    `src` String,
    `theAlias` String ALIAS trimBoth(src)
)
ENGINE = MergeTree()
ORDER BY src;
DROP TABLE IF EXISTS alias_bug;
DROP TABLE IF EXISTS alias_bug_dist;
