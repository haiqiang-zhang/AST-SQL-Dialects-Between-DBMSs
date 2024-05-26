CREATE TABLE vals(i INTEGER, v VARCHAR);
INSERT INTO vals VALUES (1, 'hello');
INSERT INTO vals SELECT i, i::VARCHAR FROM generate_series(2,10000) t(i);
INSERT INTO vals SELECT i, i::VARCHAR FROM generate_series(10001,100000) t(i);
