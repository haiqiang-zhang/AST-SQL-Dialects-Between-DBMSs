CREATE TABLE DEFAULT_TBL (i int DEFAULT 100,
	x text DEFAULT 'vadim', f float8 DEFAULT 123.456);
INSERT INTO DEFAULT_TBL VALUES (1, 'thomas', 57.0613);
INSERT INTO DEFAULT_TBL VALUES (1, 'bruce');
INSERT INTO DEFAULT_TBL (i, f) VALUES (2, 987.654);
INSERT INTO DEFAULT_TBL (x) VALUES ('marc');
INSERT INTO DEFAULT_TBL VALUES (3, null, 1.0);