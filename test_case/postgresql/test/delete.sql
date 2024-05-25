DELETE FROM delete_test AS dt WHERE dt.a > 75;
SELECT id, a, char_length(b) FROM delete_test;
DELETE FROM delete_test WHERE a > 25;
SELECT id, a, char_length(b) FROM delete_test;
DROP TABLE delete_test;
