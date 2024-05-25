CREATE SEQUENCE seq;
SELECT * FROM pg_sequences

query IIIIII nosort pg_seq
SELECT * FROM pg_catalog.pg_sequences

query IIIII
SELECT sequencename, min_value, max_value, start_value, cycle FROM pg_sequences;
