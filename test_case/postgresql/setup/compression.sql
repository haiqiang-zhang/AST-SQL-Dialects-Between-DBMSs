SET default_toast_compression = 'pglz';
CREATE TABLE cmdata(f1 text COMPRESSION pglz);
CREATE INDEX idx ON cmdata(f1);
INSERT INTO cmdata VALUES(repeat('1234567890', 1000));
CREATE TABLE cmdata1(f1 TEXT COMPRESSION lz4);
INSERT INTO cmdata1 VALUES(repeat('1234567890', 1004));
