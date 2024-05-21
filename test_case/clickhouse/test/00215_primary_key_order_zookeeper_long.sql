-- Tag no-replicated-database: Old syntax is not allowed
-- no-shared-merge-tree: implemented replacement

DROP TABLE IF EXISTS primary_key;
set allow_deprecated_syntax_for_merge_tree=1;
