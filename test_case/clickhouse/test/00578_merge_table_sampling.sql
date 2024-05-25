SELECT * FROM merge(currentDatabase(), '^numbers\\d+$') SAMPLE 0.01;
DROP TABLE numbers1;
DROP TABLE numbers2;
