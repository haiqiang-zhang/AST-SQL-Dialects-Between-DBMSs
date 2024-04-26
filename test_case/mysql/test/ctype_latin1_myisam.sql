
-- The include file ctype_numconv.inc have some MyISAM specific tests

--echo --
--echo -- Start of 5.5 tests
--echo --

--source include/ctype_numconv.inc

--echo --
--echo -- Bug#11764503 (Bug#57341) Query in EXPLAIN shows wrong characters
--echo --
-- Test latin1 client erroneously started with --default-character-set=utf8mb3
-- EXPLAIN output should still be pretty readable.
-- We're using 'Ã³' (\xC3\xB3) as a magic sequence:
-- - it's "LATIN CAPITAL LETTER A WITH TILDE ABOVE + SUPERSCRIPT 3" in latin1
-- - it's "LATIN SMALL LETTER O WITH ACUTE ABOVE" in utf8mb3.
SET NAMES utf8mb3;
SET NAMES latin1;
