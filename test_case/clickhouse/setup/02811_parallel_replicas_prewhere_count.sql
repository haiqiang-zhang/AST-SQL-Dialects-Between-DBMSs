DROP TABLE IF EXISTS users;
CREATE TABLE users (uid Int16, name String, age Int16) ENGINE=MergeTree() ORDER BY uid;
INSERT INTO users VALUES (111, 'JFK', 33);
INSERT INTO users VALUES (6666, 'KLM', 48);
INSERT INTO users VALUES (88888, 'AMS', 50);