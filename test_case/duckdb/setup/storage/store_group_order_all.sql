PRAGMA disable_checkpoint_on_shutdown;
PRAGMA wal_autocheckpoint='1TB';
CREATE TABLE integers(g integer, i integer);
INSERT INTO integers values (0, 1), (0, 2), (1, 3), (1, NULL);
CREATE VIEW v1 AS SELECT g, i, g%2, SUM(i), SUM(g) FROM integers GROUP BY ALL ORDER BY ALL;
CREATE VIEW v2 AS SELECT g, i, g%2, SUM(i), SUM(g) FROM integers GROUP BY ALL ORDER BY ALL DESC NULLS LAST;
