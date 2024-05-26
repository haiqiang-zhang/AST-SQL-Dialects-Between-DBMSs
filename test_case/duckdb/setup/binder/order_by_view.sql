PRAGMA enable_verification;
CREATE TABLE src("Name" VARCHAR, CreatedAt TIMESTAMP, userID VARCHAR, "Version" VARCHAR, Clients BIGINT, HasDocumentation BOOLEAN, HasCustomAddress BOOLEAN, HasHostname BOOLEAN, RunningContainers BIGINT, HasActions BOOLEAN);
CREATE VIEW model AS SELECT DISTINCT on(userID,  date_trunc('day', CreatedAt))  date_trunc('day', CreatedAt) AS CreatedAt, "Version", Clients, HasCustomAddress, HasHostname, RunningContainers, HasDocumentation, HasActions  FROM src WHERE name = 'events' ORDER BY userID, CreatedAt DESC;
