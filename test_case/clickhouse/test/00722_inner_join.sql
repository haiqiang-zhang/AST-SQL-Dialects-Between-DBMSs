SELECT count(t.database)
    FROM (SELECT * FROM system.tables WHERE name = 'one') AS t
    JOIN system.databases AS db ON t.database = db.name;
DROP TABLE one;
