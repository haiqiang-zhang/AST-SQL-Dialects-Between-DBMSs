DROP TABLE IF EXISTS decimal;
CREATE TABLE IF NOT EXISTS decimal
(
    a DEC(9, 3),
    b DEC(18, 9),
    c DEC(38, 18)
) ENGINE = Memory;
INSERT INTO decimal (a, b, c) VALUES (42.0, -42.0, 42) (0.42, -0.42, .42) (42.42, -42.42, 42.42);
DROP TABLE IF EXISTS decimal;
