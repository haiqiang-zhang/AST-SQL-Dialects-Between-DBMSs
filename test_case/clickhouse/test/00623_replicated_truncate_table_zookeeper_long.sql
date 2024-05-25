set allow_deprecated_syntax_for_merge_tree=1;
SELECT '======Before Truncate======';
SELECT '======After Truncate And Empty======';
SELECT '======After Truncate And Insert Data======';
DROP TABLE IF EXISTS replicated_truncate1;
DROP TABLE IF EXISTS replicated_truncate2;
