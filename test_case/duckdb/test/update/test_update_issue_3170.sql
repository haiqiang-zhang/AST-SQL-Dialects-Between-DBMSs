PRAGMA enable_verification;
CREATE TABLE student(id INTEGER, name VARCHAR, PRIMARY KEY(id));;
INSERT INTO student SELECT i, 'creator' FROM RANGE(260001) tbl(i);
UPDATE student SET name = 'updator0' WHERE id = 122879;
UPDATE student SET name = 'updator1' WHERE id = 122881;
UPDATE student SET name = 'updator2' WHERE id = 245780;
UPDATE student SET name = 'updator3' WHERE id = 150881;
CREATE TABLE student(id INTEGER, name VARCHAR, PRIMARY KEY(id));;
insert into student select i, 'creator' from range(130001) tbl(i);;
update student set name = 'updator' where id = 122881;;
SELECT name FROM student WHERE id = 122879;
SELECT name FROM student WHERE id = 122881;
SELECT name FROM student WHERE id = 245780;
SELECT name FROM student WHERE id = 150881;
SELECT name FROM student WHERE id = 122879;
SELECT name FROM student WHERE id = 122881;
SELECT name FROM student WHERE id = 245780;
SELECT name FROM student WHERE id = 150881;
select id, name from student where id=122881;;
select id, name from student where id=122881;;
select id, name from student where id=122881;;
