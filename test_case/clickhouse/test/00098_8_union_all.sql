SELECT DomainID FROM (SELECT DISTINCT 1 AS DomainID, 'abc' AS Domain UNION ALL SELECT 2 AS DomainID, 'def' AS Domain) ORDER BY DomainID ASC;
