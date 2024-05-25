SELECT count() FROM min_max_with_nullable_string WHERE nullable_str = '.';
INSERT INTO min_max_with_nullable_string(t, nullable_str) VALUES (now(), '.') (now(), '.');
SELECT count() FROM min_max_with_nullable_string WHERE nullable_str = '.';
INSERT INTO min_max_with_nullable_string(t, nullable_str) VALUES (now(), NULL) (now(), '.') (now(), NULL) (now(), '.') (now(), NULL);
SELECT count() FROM min_max_with_nullable_string WHERE nullable_str = '.';
SELECT count() FROM min_max_with_nullable_string WHERE nullable_str = '';
DROP TABLE min_max_with_nullable_string;
