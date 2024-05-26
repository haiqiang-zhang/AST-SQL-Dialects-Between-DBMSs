SELECT quantile(0.8)(a), toTypeName(quantile(0.8)(a)), quantile(0.9)(a), toTypeName(quantile(0.9)(a)) FROM fuse_tbl;
SELECT quantile(a - 1), quantile(b - 1) + 1, quantile(0.8)(b - 1) + 1, quantile(0.8)(b - 1) + 2, quantile(0.9)(b - 1) + 1 FROM fuse_tbl;
EXPLAIN QUERY TREE run_passes = 1 SELECT quantile(0.5)(b), quantile(0.9)(b) from (SELECT x + 1 as b FROM (SELECT quantile(0.5)(b) as x, quantile(0.9)(b) FROM fuse_tbl) GROUP BY x);
DROP TABLE fuse_tbl;
