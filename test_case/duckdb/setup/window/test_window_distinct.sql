PRAGMA enable_verification;
CREATE TABLE figure1 AS 
	SELECT * 
	FROM VALUES 
			(1, 'a'),
			(2, 'b'),
			(3, 'b'),
			(4, 'c'),
			(5, 'c'),
			(6, 'b'),
			(7, 'c'),
			(8, 'a')
		v(i, s);
INSERT INTO figure1 VALUES 
	(9, NULL),
	(NULL, 'b'),
	(NULL, NULL),;
CREATE TABLE nested AS
	SELECT 
		i, 
		s, 
		{"m": i % 2, "s": s} AS n,
		[(i % 2)::VARCHAR, s] AS l,
		i * i AS r
	FROM figure1;
