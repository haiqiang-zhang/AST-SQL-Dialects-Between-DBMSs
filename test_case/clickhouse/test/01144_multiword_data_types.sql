SELECT toTypeName((*,)) FROM multiword_types;
CREATE TABLE unsigned_types (
    a TINYINT  SIGNED,
    b INT1     SIGNED,
    c SMALLINT SIGNED,
    d INT      SIGNED,
    e INTEGER  SIGNED,
    f BIGINT   SIGNED,
    g TINYINT  UNSIGNED,
    h INT1     UNSIGNED,
    i SMALLINT UNSIGNED,
    j INT      UNSIGNED,
    k INTEGER  UNSIGNED,
    l BIGINT   UNSIGNED
) ENGINE=Memory;
SHOW CREATE TABLE unsigned_types;
INSERT INTO unsigned_types(a) VALUES (1);
SELECT toTypeName((*,)) FROM unsigned_types;
SELECT CAST('42' AS DOUBLE PRECISION), CAST(42, 'NATIONAL CHARACTER VARYING'), CAST(-1 AS tinyint  UnSiGnEd), CAST(65535, ' sMaLlInT  signed ');
DROP TABLE multiword_types;
DROP TABLE unsigned_types;
