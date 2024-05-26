DROP TABLE IF EXISTS prewhere_defaults;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE prewhere_defaults (d Date DEFAULT '2000-01-01', k UInt64 DEFAULT 0, x UInt16) ENGINE = MergeTree(d, k, 1);
INSERT INTO prewhere_defaults (x) VALUES (1);
SET max_block_size = 1;
