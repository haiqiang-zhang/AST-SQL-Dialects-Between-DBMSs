DROP TABLE IF EXISTS enum;
CREATE TABLE enum (x Enum8('Hello' = -100, '\\' = 0, '\t\\t' = 111), y UInt8) ENGINE = TinyLog;
INSERT INTO enum (y) VALUES (0);
INSERT INTO enum (x) VALUES ('\\');
INSERT INTO enum (x) VALUES ('\t\\t');
DROP TABLE enum;
