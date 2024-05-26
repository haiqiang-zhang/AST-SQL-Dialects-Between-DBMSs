SELECT count() FROM generate_series(5, 4);
SELECT sum(generate_series) FROM generate_series(4, 1008, 4) WHERE generate_series % 7 = 1;
SELECT * FROM generate_series(5, 4);
