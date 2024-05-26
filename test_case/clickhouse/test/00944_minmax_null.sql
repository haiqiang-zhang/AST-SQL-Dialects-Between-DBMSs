SELECT count() FROM min_max_with_nullable_string WHERE nullable_str = '.';
INSERT INTO min_max_with_nullable_string(t, nullable_str) VALUES (now(), '.') (now(), '.');
INSERT INTO min_max_with_nullable_string(t, nullable_str) VALUES (now(), NULL) (now(), '.') (now(), NULL) (now(), '.') (now(), NULL);
DROP TABLE min_max_with_nullable_string;
