CREATE TABLE t1(a INT, b TEXT, c INT, d INT);
INSERT INTO t1(a,b,c,d) VALUES
    (1, '{"x":1}', 12,  3),
    (1, '{"x":2}',  4,  5),
    (1, '{"x":1}',  6, 11),
    (2, '{"x":1}', 22,  3),
    (2, '{"x":2}',  4,  5),
    (3, '{"x":1}',  6,  7);
CREATE INDEX t1x ON t1(d, a, b->>'x', c);