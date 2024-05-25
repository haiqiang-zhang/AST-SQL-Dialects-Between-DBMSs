OPTIMIZE TABLE index_compact FINAL;
SELECT count() FROM index_compact WHERE b < 10;
DROP TABLE index_compact;
