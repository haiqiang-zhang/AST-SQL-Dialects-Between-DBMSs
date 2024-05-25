
--     'Peter', 'Nara', 'Skilled Manual', 'Graduate Degree', 26, 
--     'Latoya', 'Shen', 'Professional', 'Graduate Degree', 25, 
--     'Joshua', 'Lee', 'Professional', 'Partial College', 26, 
--     'Edward', 'Hernandez', 'Skilled Manual', 'High School', 36, 
--     'Dalton', 'Wood', 'Professional', 'Partial College', 42, 
--     'Christine', 'Nara', 'Skilled Manual', 'Partial College', 33, 
--     'Cameron', 'Rodriguez', 'Professional', 'Partial College', 28, 
--     'Angel', 'Stewart', 'Professional', 'Partial College', 46, 
--     'Apple', '', 'Skilled Manual', 'Bachelors', 28, 
--     dynamic(null), 'why', 'Professional', 'Partial College', 38
-- ]

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
(    
    FirstName Nullable(String),
    LastName String, 
    Occupation String,
    Education String,
    Age Nullable(UInt8)
) ENGINE = Memory;
INSERT INTO Customers VALUES  ('Theodore','Diaz','Skilled Manual','Bachelors',28),('Stephanie','Cox','Management abcd defg','Bachelors',33),('Peter','Nara','Skilled Manual','Graduate Degree',26),('Latoya','Shen','Professional','Graduate Degree',25),('Joshua','Lee','Professional','Partial College',26),('Edward','Hernandez','Skilled Manual','High School',36),('Dalton','Wood','Professional','Partial College',42),('Christine','Nara','Skilled Manual','Partial College',33),('Cameron','Rodriguez','Professional','Partial College',28),('Angel','Stewart','Professional','Partial College',46),('Apple','','Skilled Manual','Bachelors',28),(NULL,'why','Professional','Partial College',38);
drop table if exists EventLog;
create table EventLog
(
    LogEntry String,
    Created Int64
) ENGINE = Memory;
insert into EventLog values ('Darth Vader has entered the room.', 546), ('Rambo is suspciously looking at Darth Vader.', 245234), ('Darth Sidious electrocutes both using Force Lightning.', 245554);
drop table if exists Dates;
create table Dates
(
    EventTime DateTime,
) ENGINE = Memory;
set dialect='kusto';
Customers | summarize count(), min(Age), max(Age), avg(Age), sum(Age);
Customers | summarize count(), min(Age), max(Age), avg(Age), sum(Age) by Occupation | order by Occupation;
Customers | summarize countif(Age>40) by Occupation | order by Occupation;
Customers | summarize MyMax = maxif(Age, Age<40) by Occupation | order by Occupation;
Customers | summarize MyMin = minif(Age, Age<40) by Occupation | order by Occupation;
Customers | summarize MyAvg = avgif(Age, Age<40) by Occupation | order by Occupation;
Customers | summarize MySum = sumif(Age, Age<40) by Occupation | order by Occupation;
Customers | summarize dcount(Education);
Customers | summarize dcountif(Education, Occupation=='Professional');
Customers | summarize count_ = count() by bin(Age, 10) | order by count_ asc;
Customers | summarize job_count = count() by Occupation | where job_count > 0 | order by Occupation;