DROP TABLE IF EXISTS tuple;
CREATE TABLE tuple
(
    `j` Tuple(a Int8, b String)
)
ENGINE = Memory;
