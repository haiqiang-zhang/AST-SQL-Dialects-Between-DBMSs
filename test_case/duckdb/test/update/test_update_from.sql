CREATE TABLE test (a INTEGER);;
INSERT INTO test VALUES (3);
CREATE  TABLE src (a INTEGER);;
INSERT INTO src VALUES (2);
UPDATE test SET a=test.a+s.a FROM src s;
UPDATE test SET a=test.a+t.a FROM test t;
UPDATE test SET a=t.a+s.a FROM test t, src s;
UPDATE test SET a=s.q FROM (SELECT a+1 as q FROM src) s;
CREATE VIEW vt AS (SELECT 17 as v);
UPDATE test SET a=v FROM vt;
UPDATE test SET a=s.a FROM src s WHERE s.a = 2;
UPDATE test t SET a=1 FROM src s WHERE s.a = t.a;
UPDATE test t SET a=9 FROM src s WHERE s.a=t.a;
INSERT INTO src VALUES (7);
UPDATE test SET a=s.a FROM src s;
CREATE TABLE terms(docid INTEGER, term INTEGER);;
CREATE TABLE docs(id INTEGER, len INTEGER);;
insert into docs values (1, 0), (2, 0);;
insert into terms values (1, 1);;
insert into terms values (2, 1);;
insert into terms values (2, 2);;
insert into terms values (2, 3);;
UPDATE docs
SET len = sq.len
FROM (
    SELECT docid AS id, count(term) AS len
    FROM terms
    GROUP BY docid
    ORDER BY docid
) AS sq
WHERE docs.id = sq.id;;
SELECT * FROM test;
SELECT * FROM src;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
SELECT * FROM test;
select * from docs;;
