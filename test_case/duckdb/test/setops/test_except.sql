CREATE TABLE a(i INTEGER);
INSERT INTO a VALUES (41), (42), (43);
CREATE TABLE b(i INTEGER);
INSERT INTO b VALUES (40), (43), (43);
select * from a except select * from b order by 1;
select * from a intersect select * from b;
