DROP TABLE IF EXISTS t1,t2;
CREATE TABLE t1(
product VARCHAR(32),
country_id INTEGER NOT NULL,
year INTEGER,
profit INTEGER);
INSERT INTO t1  VALUES ( 'Computer', 2,2000, 1200),
( 'TV', 1, 1999, 150),
( 'Calculator', 1, 1999,50),
( 'Computer', 1, 1999,1500),
( 'Computer', 1, 2000,1500),
( 'TV', 1, 2000, 150),
( 'TV', 2, 2000, 100),
( 'TV', 2, 2000, 100),
( 'Calculator', 1, 2000,75),
( 'Calculator', 2, 2000,75),
( 'TV', 1, 1999, 100),
( 'Computer', 1, 1999,1200),
( 'Computer', 2, 2000,1500),
( 'Calculator', 2, 2000,75),
( 'Phone', 3, 2003,10);
CREATE TABLE t2 (
country_id INTEGER PRIMARY KEY,
country CHAR(20) NOT NULL);
INSERT INTO t2 VALUES (1, 'USA'),(2,'India'), (3,'Finland');
