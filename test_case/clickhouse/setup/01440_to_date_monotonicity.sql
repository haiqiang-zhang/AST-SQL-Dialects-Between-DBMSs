DROP TABLE IF EXISTS tdm;
DROP TABLE IF EXISTS tdm2;
CREATE TABLE tdm (x DateTime('Asia/Istanbul')) ENGINE = MergeTree ORDER BY x SETTINGS write_final_mark = 0;
INSERT INTO tdm VALUES (now());
