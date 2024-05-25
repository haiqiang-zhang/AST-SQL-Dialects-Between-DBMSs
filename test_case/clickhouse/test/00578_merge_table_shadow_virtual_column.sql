SELECT count() FROM merge(currentDatabase(), '^numbers\\d+$') WHERE _table=1;
DROP TABLE numbers1;
DROP TABLE numbers2;
