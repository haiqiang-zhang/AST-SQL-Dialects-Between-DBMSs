SELECT id, a, char_length(b) FROM delete_test;
DELETE FROM delete_test WHERE a > 25;
DROP TABLE delete_test;
