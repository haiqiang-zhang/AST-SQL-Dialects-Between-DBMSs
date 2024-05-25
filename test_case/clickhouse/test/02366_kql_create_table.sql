Select * from kql(Customers|project FirstName) limit 1;
DROP TABLE IF EXISTS kql_table1;
CREATE TABLE kql_table1 ENGINE = Memory AS select *, now() as new_column From kql(Customers | project LastName | filter LastName=='Diaz');
select LastName from kql_table1 limit 1;
DROP TABLE IF EXISTS kql_table2;
CREATE TABLE kql_table2
(    
    FirstName Nullable(String),
    LastName String, 
    Age Nullable(UInt8)
) ENGINE = Memory;
INSERT INTO kql_table2 select * from kql(Customers|project FirstName,LastName,Age | filter FirstName=='Theodore');
select * from kql_table2 limit 1;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS kql_table1;
DROP TABLE IF EXISTS kql_table2;
