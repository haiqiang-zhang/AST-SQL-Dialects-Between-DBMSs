CREATE TABLE v0 ( c1 INT );;
INSERT INTO v0 VALUES (1), (2), (3), (4) RETURNING * EXCLUDE c1;;
INSERT INTO v0 VALUES (1), (2), (3), (4), (0);;
DELETE from v0 WHERE c1 = 0 RETURNING * EXCLUDE c1;;
UPDATE v0 SET c1 = 0 WHERE true RETURNING * EXCLUDE c1;;
INSERT INTO v0 BY POSITION ( SELECT TRUE ) OFFSET 1 ROWS RETURNING v0 . * EXCLUDE c1 ;;
SELECT * FROM v0;;
select * from v0 where c1 = 0;;
Select * from v0 order by all;;
