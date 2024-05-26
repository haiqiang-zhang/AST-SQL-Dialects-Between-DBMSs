SELECT * FROM merge(currentDatabase(), '^view_without_sample$') SAMPLE 1 / 100;
DROP TABLE view_without_sample;
