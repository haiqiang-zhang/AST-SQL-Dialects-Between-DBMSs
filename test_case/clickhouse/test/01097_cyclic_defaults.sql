DROP TABLE IF EXISTS table_with_cyclic_defaults;
CREATE TABLE table_with_cyclic_defaults (a String) ENGINE = Memory;
SELECT 1;
DROP TABLE IF EXISTS table_with_cyclic_defaults;
