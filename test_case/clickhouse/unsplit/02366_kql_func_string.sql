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

--     '1.2.3',
--     '1'
-- ]

DROP TABLE IF EXISTS Versions;
CREATE TABLE Versions
(    
    Version String
) ENGINE = Memory;
INSERT INTO Versions VALUES ('1.2.3.4'),('1.2'),('1.2.3'),('1');
set dialect='kusto';
print '-- test String Functions --';
print '-- Customers |where Education contains \'degree\'';
Customers |where Education contains 'degree' | order by LastName;
print '';
print '-- Customers |where Education !contains \'degree\'';
Customers |where Education !contains 'degree' | order by LastName;
print '';
print '-- Customers |where Education contains \'Degree\'';
Customers |where Education contains 'Degree' | order by LastName;
print '';
print '-- Customers |where Education !contains \'Degree\'';
Customers |where Education !contains 'Degree' | order by LastName;
print '';
print '-- Customers | where FirstName endswith \'RE\'';
Customers | where FirstName endswith 'RE' | order by LastName;
print '';
print '-- Customers | where ! FirstName endswith \'RE\'';
Customers | where FirstName ! endswith 'RE' | order by LastName;
print '';
print '--Customers | where FirstName endswith_cs \'re\'';
Customers | where FirstName endswith_cs 're' | order by LastName;
print '';
print '-- Customers | where FirstName !endswith_cs \'re\'';
Customers | where FirstName !endswith_cs 're' | order by LastName;
print '';
print '-- Customers | where Occupation == \'Skilled Manual\'';
Customers | where Occupation == 'Skilled Manual' | order by LastName;
print '';
print '-- Customers | where Occupation != \'Skilled Manual\'';
Customers | where Occupation != 'Skilled Manual' | order by LastName;
print '';
print '-- Customers | where Occupation has \'skilled\'';
Customers | where Occupation has 'skilled' | order by LastName;
print '';
print '-- Customers | where Occupation !has \'skilled\'';
Customers | where Occupation !has 'skilled' | order by LastName;
print '';
print '-- Customers | where Occupation has \'Skilled\'';
Customers | where Occupation has 'Skilled'| order by LastName;
print '';
print '-- Customers | where Occupation !has \'Skilled\'';
Customers | where Occupation !has 'Skilled'| order by LastName;
print '';
print '-- Customers | where Occupation hasprefix_cs \'Ab\'';
Customers | where Occupation hasprefix_cs 'Ab'| order by LastName;
print '';
print '-- Customers | where Occupation !hasprefix_cs \'Ab\'';
Customers | where Occupation !hasprefix_cs 'Ab'| order by LastName;
print '';
print '-- Customers | where Occupation hasprefix_cs \'ab\'';
Customers | where Occupation hasprefix_cs 'ab'| order by LastName;
print '';
print '-- Customers | where Occupation !hasprefix_cs \'ab\'';
Customers | where Occupation !hasprefix_cs 'ab'| order by LastName;
print '';
print '-- Customers | where Occupation hassuffix \'Ent\'';
Customers | where Occupation hassuffix 'Ent'| order by LastName;
print '';
print '-- Customers | where Occupation !hassuffix \'Ent\'';
Customers | where Occupation !hassuffix 'Ent'| order by LastName;
print '';
print '-- Customers | where Occupation hassuffix \'ent\'';
Customers | where Occupation hassuffix 'ent'| order by LastName;
print '';
print '-- Customers | where Occupation hassuffix \'ent\'';
Customers | where Occupation hassuffix 'ent'| order by LastName;
print '';
print '-- Customers |where Education in (\'Bachelors\',\'High School\')';
Customers |where Education in ('Bachelors','High School')| order by LastName;
print '';
print '-- Customers | where Education !in (\'Bachelors\',\'High School\')';
Customers | where Education !in ('Bachelors','High School')| order by LastName;
print '';
print '-- Customers | where FirstName matches regex \'P.*r\'';
Customers | where FirstName matches regex 'P.*r'| order by LastName;
print '';
print '-- Customers | where FirstName startswith \'pet\'';
Customers | where FirstName startswith 'pet'| order by LastName;
print '';
print '-- Customers | where FirstName !startswith \'pet\'';
Customers | where FirstName !startswith 'pet'| order by LastName;
print '';
print '-- Customers | where FirstName startswith_cs \'pet\'';
Customers | where FirstName startswith_cs 'pet'| order by LastName;
print '';
print '-- Customers | where FirstName !startswith_cs \'pet\'';
Customers | where FirstName !startswith_cs 'pet'| order by LastName;
print '';
print '-- Customers | where isempty(LastName)';
Customers | where isempty(LastName);
print '';
print '-- Customers | where isnotempty(LastName)';
Customers | where isnotempty(LastName);
print '';
print '-- Customers | where isnotnull(FirstName)';
Customers | where isnotnull(FirstName)| order by LastName;
print '';
print '-- Customers | where isnull(FirstName)';
Customers | where isnull(FirstName)| order by LastName;
print '';
print '-- Customers | project url_decode(\'https%3A%2F%2Fwww.test.com%2Fhello%20word\') | take 1';
Customers | project url_decode('https%3A%2F%2Fwww.test.com%2Fhello%20word') | take 1;
print '';
print '-- Customers | project url_encode(\'https://www.test.com/hello word\') | take 1';
Customers | project url_encode('https://www.test.com/hello word') | take 1;
print '';
print '-- Customers | project name_abbr = strcat(substring(FirstName,0,3), \' \', substring(LastName,2))';
Customers | project name_abbr = strcat(substring(FirstName,0,3), ' ', substring(LastName,2))| order by LastName;
print '';
print '-- Customers | project name = strcat(FirstName, \' \', LastName)';
Customers | project name = strcat(FirstName, ' ', LastName)| order by LastName;
print '';
print '-- Customers | project FirstName, strlen(FirstName)';
Customers | project FirstName, strlen(FirstName)| order by LastName;
print '';
print '-- Customers | project strrep(FirstName,2,\'_\')';
Customers | project strrep(FirstName,2,'_')| order by LastName;
print '';
print '-- Customers | project toupper(FirstName)';
Customers | project toupper(FirstName)| order by LastName;
print '';
print '-- Customers | project tolower(FirstName)';
Customers | project tolower(FirstName)| order by LastName;
print '';
