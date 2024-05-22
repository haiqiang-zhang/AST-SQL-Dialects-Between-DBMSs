DROP TABLE IF EXISTS tuple;
CREATE TABLE tuple
(
    `j` Tuple(a Int8, b String)
)
ENGINE = Memory;
DESC tuple;
DROP TABLE tuple;
CREATE TABLE tuple ENGINE = Memory AS SELECT CAST((1, 'Test'), 'Tuple(a Int8,  b String)') AS j;
DESC tuple;
DROP TABLE tuple;
