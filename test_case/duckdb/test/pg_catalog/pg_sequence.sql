CREATE SEQUENCE seq;
SELECT * FROM pg_sequence

query IIIIII nosort pg_seq
SELECT * FROM pg_catalog.pg_sequence

query IIIII
SELECT seqstart, seqincrement, seqmax, seqmin, seqcycle FROM pg_sequence;
