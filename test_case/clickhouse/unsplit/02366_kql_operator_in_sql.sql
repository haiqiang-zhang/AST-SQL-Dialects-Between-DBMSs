DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
(    
    FirstName Nullable(String),
    LastName String, 
    Occupation String,
    Education String,
    Age Nullable(UInt8)
) ENGINE = Memory;
INSERT INTO Customers VALUES  ('Theodore','Diaz','Skilled Manual','Bachelors',28),('Stephanie','Cox','Management abcd defg','Bachelors',33),('Peter','Nara','Skilled Manual','Graduate Degree',26),('Latoya','Shen','Professional','Graduate Degree',25),('Apple','','Skilled Manual','Bachelors',28),(NULL,'why','Professional','Partial College',38);
Select '-- #1 --';
select * from kql($$Customers | where FirstName !in ('Peter', 'Latoya')$$);
Select '-- #2 --';
Select '-- #3 --';
Select '-- #4 --';
Select '-- #5 --';
Select '-- #6 --';
Select '-- #7 --';
Select '-- #8 --';
Select '-- #9 --';
Select '-- #10 --';
Select '-- #11 --';
Select '-- #12 --';
Select '-- #13 --';
Select '-- #14 --';
Select '-- #15 --';
DROP TABLE IF EXISTS Customers;
