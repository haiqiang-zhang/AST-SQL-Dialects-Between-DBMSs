CREATE TABLE t (c VARCHAR(128));
INSERT INTO t VALUES
    (REPEAT('a', 128)),
    (REPEAT('b', 128)),
    (REPEAT('c', 128)),
    (REPEAT('d', 128));
