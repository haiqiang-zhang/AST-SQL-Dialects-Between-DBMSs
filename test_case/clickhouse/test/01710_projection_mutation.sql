ALTER TABLE t UPDATE value = 0 WHERE (value > 0) AND (created_at >= '2021-12-21') SETTINGS optimize_use_projections = 1;
DROP TABLE IF EXISTS t;
