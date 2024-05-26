PRAGMA enable_verification;
CREATE TABLE issue2549 AS SELECT * FROM (VALUES
	(0, 1, 614),
	(1, 1, null),
	(2, 1, null),
	(3, 1, 639),
	(4, 1, 2027)
) tbl(id, user_id, order_id);
CREATE TABLE IF NOT EXISTS issue6635(index INTEGER, data INTEGER);
insert into issue6635 values 
	(1,1),
	(2,2),
	(3,NULL),
	(4,NULL),
	(5,5),
	(6,NULL),
	(7,NULL);
