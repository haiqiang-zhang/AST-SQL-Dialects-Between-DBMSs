DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
(    
    FirstName Nullable(String),
    LastName String, 
    Occupation String,
    Education String,
    Age Nullable(UInt8)
) ENGINE = Memory;
INSERT INTO Customers VALUES ('Theodore','Diaz','Skilled Manual','Bachelors',28), ('Stephanie','Cox','Management abcd defg','Bachelors',33),('Peter','Nara','Skilled Manual','Graduate Degree',26),('Latoya','Shen','Professional','Graduate Degree',25),('Apple','','Skilled Manual','Bachelors',28),(NULL,'why','Professional','Partial College',38);
DROP TABLE IF EXISTS Versions;
CREATE TABLE Versions
(    
    Version String
) ENGINE = Memory;
INSERT INTO Versions VALUES ('1.2.3.4'),('1.2'),('1.2.3'),('1');
set dialect='kusto';
