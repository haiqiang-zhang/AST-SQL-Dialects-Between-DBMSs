SELECT count(), min(x), max(x), sum(x), uniqExact(x) FROM modify_sample SAMPLE 0.1;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE modify_sample_old (d Date DEFAULT '2000-01-01', x UInt8, y UInt64) ENGINE = MergeTree(d, (x, y), 8192);
DROP TABLE modify_sample;
DROP TABLE modify_sample_old;
