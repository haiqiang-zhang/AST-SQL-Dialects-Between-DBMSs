CREATE TABLE mt_match_pk (v String) ENGINE = MergeTree ORDER BY v SETTINGS index_granularity = 1;
INSERT INTO mt_match_pk VALUES ('a'), ('aaa'), ('aba'), ('bac'), ('acccca');
SET force_primary_key = 1;
SELECT count() FROM mt_match_pk WHERE match(v, '^a');
