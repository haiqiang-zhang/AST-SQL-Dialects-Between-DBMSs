CREATE VIEW v1(x,y) AS
    WITH t1(a,b) AS (VALUES(1,2))
    SELECT * FROM nosuchtable JOIN t1;
