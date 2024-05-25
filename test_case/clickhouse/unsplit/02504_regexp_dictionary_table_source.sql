DROP DICTIONARY IF EXISTS regexp_dict1;
DROP TABLE IF EXISTS regexp_dictionary_source_table;
CREATE TABLE regexp_dictionary_source_table
(
    id UInt64,
    parent_id UInt64,
    regexp String,
    keys   Array(String),
    values Array(String),
) ENGINE=TinyLog;
DROP table IF EXISTS needle_table;
CREATE TABLE needle_table
(
    key String
)
ENGINE=TinyLog;
INSERT INTO needle_table select concat(toString(number + 30), '/tclwebkit', toString(number)) from system.numbers limit 15;
select * from needle_table;
truncate table regexp_dictionary_source_table;
truncate table regexp_dictionary_source_table;
-- test priority
truncate table regexp_dictionary_source_table;
INSERT INTO regexp_dictionary_source_table VALUES (1, 0, '(\d+)/tclwebkit', ['name', 'version'], ['Android', '$1']);
INSERT INTO regexp_dictionary_source_table VALUES (3, 1, '33/tclwebkit', ['name'], ['Android1']);
INSERT INTO regexp_dictionary_source_table VALUES (2, 0, '33/tclwebkit', ['version', 'comment'], ['13', 'matched 3']);
truncate table regexp_dictionary_source_table;
DROP DICTIONARY IF EXISTS regexp_dict1;
DROP TABLE IF EXISTS regexp_dictionary_source_table;
DROP TABLE IF EXISTS needle_table;
