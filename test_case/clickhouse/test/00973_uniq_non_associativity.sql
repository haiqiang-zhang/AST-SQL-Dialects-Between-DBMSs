SELECT uniq(number) FROM (
          SELECT * FROM part_a
UNION ALL SELECT * FROM part_c
UNION ALL SELECT * FROM part_d
UNION ALL SELECT * FROM part_b);
DROP TABLE part_a;
DROP TABLE part_b;
DROP TABLE part_c;
DROP TABLE part_d;
