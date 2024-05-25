OPTIMIZE TABLE collapsing PARTITION tuple() FINAL;
SELECT * FROM collapsing ORDER BY key;
DROP TABLE collapsing;
