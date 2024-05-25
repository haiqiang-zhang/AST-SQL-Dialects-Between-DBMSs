DROP TABLE IF EXISTS part_b;
DROP TABLE IF EXISTS part_c;
DROP TABLE IF EXISTS part_d;
CREATE TABLE part_a ENGINE = TinyLog AS SELECT * FROM
(
WITH
    number AS k1,
    bitXor(k1, bitShiftRight(k1, 33)) AS k2,
    k2 * 0xff51afd7ed558ccd AS k3,
    bitXor(k3, bitShiftRight(k3, 33)) AS k4,
    k4 * 0xc4ceb9fe1a85ec53 AS k5,
    bitXor(k5, bitShiftRight(k5, 33)) AS k6,
    k6 AS hash,
    bitShiftRight(hash, 15) % 0x20000 AS place,
    hash % 2 = 0 AS will_remain
SELECT hash, number, place FROM system.numbers WHERE place >= 90000 AND place < 131062 AND NOT will_remain LIMIT 1 BY place LIMIT 41062
) ORDER BY place;
CREATE TABLE part_b ENGINE = TinyLog AS SELECT * FROM
(
WITH
    number AS k1,
    bitXor(k1, bitShiftRight(k1, 33)) AS k2,
    k2 * 0xff51afd7ed558ccd AS k3,
    bitXor(k3, bitShiftRight(k3, 33)) AS k4,
    k4 * 0xc4ceb9fe1a85ec53 AS k5,
    bitXor(k5, bitShiftRight(k5, 33)) AS k6,
    k6 AS hash,
    bitShiftRight(hash, 15) % 0x20000 AS place,
    hash % 2 = 0 AS will_remain
SELECT hash, number, place FROM system.numbers WHERE place >= 50000 AND place < 90000 AND will_remain LIMIT 1 BY place LIMIT 40000
) ORDER BY place;
CREATE TABLE part_c ENGINE = TinyLog AS SELECT * FROM
(
WITH
    number AS k1,
    bitXor(k1, bitShiftRight(k1, 33)) AS k2,
    k2 * 0xff51afd7ed558ccd AS k3,
    bitXor(k3, bitShiftRight(k3, 33)) AS k4,
    k4 * 0xc4ceb9fe1a85ec53 AS k5,
    bitXor(k5, bitShiftRight(k5, 33)) AS k6,
    k6 AS hash,
    bitShiftRight(hash, 15) % 0x20000 AS place,
    hash % 2 = 0 AS will_remain
SELECT hash, number, place FROM system.numbers WHERE place >= 131052 AND place < 131062 AND will_remain AND hash NOT IN (SELECT hash FROM part_a) LIMIT 1 BY place LIMIT 10
) ORDER BY place;
CREATE TABLE part_d ENGINE = TinyLog AS SELECT * FROM
(
WITH
    number AS k1,
    bitXor(k1, bitShiftRight(k1, 33)) AS k2,
    k2 * 0xff51afd7ed558ccd AS k3,
    bitXor(k3, bitShiftRight(k3, 33)) AS k4,
    k4 * 0xc4ceb9fe1a85ec53 AS k5,
    bitXor(k5, bitShiftRight(k5, 33)) AS k6,
    k6 AS hash,
    bitShiftRight(hash, 15) % 0x20000 AS place,
    hash % 2 = 0 AS will_remain
SELECT hash, number, place FROM system.numbers WHERE place >= 131062 AND will_remain LIMIT 1 BY place LIMIT 10
) ORDER BY place;
SET max_threads = 1;
SELECT uniq(number) FROM (
          SELECT * FROM part_a
UNION ALL SELECT * FROM part_c
UNION ALL SELECT * FROM part_d
UNION ALL SELECT * FROM part_b);
SELECT uniq(number) FROM (
          SELECT * FROM part_a
UNION ALL SELECT * FROM part_c
UNION ALL SELECT * FROM part_d
UNION ALL SELECT * FROM part_b
UNION ALL SELECT * FROM part_d);
DROP TABLE part_a;
DROP TABLE part_b;
DROP TABLE part_c;
DROP TABLE part_d;
