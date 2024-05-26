select * from tbl;
select * from tbl;
INSERT INTO tbl VALUES (5,0), (6,0), (7,0) ON CONFLICT (a) DO UPDATE set b = excluded.b;
INSERT INTO tbl VALUES (-1, 0), (5,0), (6,0) ON CONFLICT (a) DO NOTHING;
select max(b) from tbl;
select max(b) from tbl;
