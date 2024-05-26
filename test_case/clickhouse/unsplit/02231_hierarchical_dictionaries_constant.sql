DROP TABLE IF EXISTS hierarchy_source_table;
CREATE TABLE hierarchy_source_table (id UInt64, parent_id UInt64) ENGINE = TinyLog;
INSERT INTO hierarchy_source_table VALUES (1, 0), (2, 1), (3, 1), (4, 2);
DROP DICTIONARY IF EXISTS hierarchy_flat_dictionary;
CREATE DICTIONARY hierarchy_flat_dictionary
(
    id UInt64,
    parent_id UInt64 HIERARCHICAL
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE 'hierarchy_source_table'))
LAYOUT(FLAT())
LIFETIME(MIN 1 MAX 1000);
SELECT 'Get hierarchy';
SELECT dictGetHierarchy('hierarchy_flat_dictionary', 0);
SELECT 'Get is in hierarchy';
SELECT dictIsIn('hierarchy_flat_dictionary', 1, 1);
SELECT 'Get children';
SELECT dictGetChildren('hierarchy_flat_dictionary', 0);
SELECT 'Get all descendants';
SELECT dictGetDescendants('hierarchy_flat_dictionary', 0);
SELECT 'Get descendants at first level';
DROP DICTIONARY hierarchy_flat_dictionary;
DROP TABLE hierarchy_source_table;
