CREATE TABLE LINE_TBL (s line);
INSERT INTO LINE_TBL VALUES ('{0,-1,5}');
INSERT INTO LINE_TBL VALUES ('{1,0,5}');
INSERT INTO LINE_TBL VALUES ('{0,3,0}');
INSERT INTO LINE_TBL VALUES (' (0,0), (6,6)');
INSERT INTO LINE_TBL VALUES ('10,-10 ,-5,-4');
INSERT INTO LINE_TBL VALUES ('[-1e6,2e2,3e5, -4e1]');
INSERT INTO LINE_TBL VALUES ('{3,NaN,5}');
INSERT INTO LINE_TBL VALUES ('{NaN,NaN,NaN}');
INSERT INTO LINE_TBL VALUES ('[(1,3),(2,3)]');
INSERT INTO LINE_TBL VALUES (line(point '(3,1)', point '(3,2)'));
select * from LINE_TBL;
select '{nan, 1, nan}'::line = '{nan, 1, nan}'::line as true,
	   '{nan, 1, nan}'::line = '{nan, 2, nan}'::line as false;
SELECT pg_input_is_valid('{1, 1}', 'line');
SELECT * FROM pg_input_error_info('{1, 1}', 'line');
