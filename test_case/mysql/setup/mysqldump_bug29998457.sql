CREATE DATABASE test_bug29998457;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
pk INT,
v1 VARCHAR(255),
v2 VARCHAR(255),
v3 VARCHAR(255),
v4 VARCHAR(128),
v5 VARCHAR(64),
v6 VARCHAR(16),
v7 VARCHAR(16),
v8 VARCHAR(8),
v9 VARBINARY(32),
v10 VARBINARY(32));