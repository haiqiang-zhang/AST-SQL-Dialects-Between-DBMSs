SELECT pe, pe.values.a FROM (SELECT * FROM t2) ARRAY JOIN pe SETTINGS allow_experimental_analyzer = 1;
SELECT p, p.values.a FROM (SELECT * FROM t2) ARRAY JOIN pe AS p SETTINGS allow_experimental_analyzer = 1;
SELECT pe, pe.values.a FROM t2 ARRAY JOIN pe;
SELECT p, p.values.a FROM t2 ARRAY JOIN pe AS p;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
