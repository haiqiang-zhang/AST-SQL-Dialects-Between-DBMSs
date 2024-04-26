let $ddse_table_names = test.ddse_table_names;
let $dd_table_names = test.dd_table_names;

SET debug = '+d,skip_dd_table_access_check';

CREATE TABLE dd_check_table (id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
   t TEXT NOT NULL,
   row_hash VARCHAR(64) DEFAULT NULL);

-- Expression representing the DD table ids
let $dd_table_ids =
  SELECT id FROM mysql.tables
  WHERE schema_id = 1
  AND name IN (SELECT name FROM $dd_table_names UNION
               SELECT name FROM $ddse_table_names);

-- Schema meta data excluding timestamps. Id is fixed even across versions.
INSERT INTO dd_check_table(t)
  SELECT CONCAT(id, '-', catalog_id, '-',
    name, '-', default_collation_id, '-',
    IFNULL(options, 'NULL'))
  FROM mysql.schemata
  WHERE name = 'mysql';

-- Tablespace meta data excluding timestamps. Filter out server version. Id is fixed.
INSERT INTO dd_check_table(t)
  SELECT CONCAT(id, '-', name, '-',
    IFNULL(options, 'NULL'), '-',
    IFNULL(INSERT(se_private_data, 
             INSTR(se_private_data, 'server_version'),
             20, 'server_version=x'),
      'NULL'),
    '-', comment, '-', engine)
  FROM mysql.tablespaces
  WHERE name = 'mysql';

-- Subset of definitions from tables, not including
-- timestamps, partitioning, view definitions and
-- default values
eval INSERT INTO dd_check_table(t)
  SELECT CONCAT(id, '-', name, '-', type, '-',
    engine, '-', collation_id, '-',
    comment, '-', hidden, '-',
    IFNULL(options, 'NULL'), '-',
    IFNULL(se_private_data, 'NULL'), '-',
    se_private_id, '-',
    tablespace_id)
  FROM mysql.tables
  WHERE id IN ($dd_table_ids)
  ORDER BY id;

-- Subset of definitions from columns, not including
-- default_values.
eval INSERT INTO dd_check_table(t)
  SELECT CONCAT(id, '-', table_id, '-', name, '-',
    ordinal_position, '-', type, '-', is_nullable, '-',
    IFNULL(is_zerofill, 'NULL'), '-',
    IFNULL(is_unsigned, 'NULL'), '-',
    IFNULL(char_length, 'NULL'), '-',
    IFNULL(numeric_precision, 'NULL'), '-',
    IFNULL(numeric_scale, 'NULL'), '-',
    IFNULL(datetime_precision, 'NULL'), '-',
    IFNULL(collation_id, 'NULL'), '-',
    IFNULL(default_option, 'NULL'), '-',
    IFNULL(update_option, 'NULL'), '-',
    IFNULL(is_auto_increment, 'NULL'), '-',
    comment, '-',
    hidden, '-',
    IFNULL(options, 'NULL'), '-',
    IFNULL(se_private_data, 'NULL'))
  FROM mysql.columns
  WHERE table_id IN ($dd_table_ids)
  ORDER BY id;

-- Definitions from indexes.
eval INSERT INTO dd_check_table(t)
  SELECT CONCAT(
    id, '-',
    table_id, '-',
    name, '-',
    type, '-',
    algorithm, '-',
    is_algorithm_explicit, '-',
    is_visible, '-',
    is_generated, '-',
    hidden, '-',
    ordinal_position, '-',
    comment, '-',
    IFNULL(options, 'NULL'), '-',
    IFNULL(se_private_data, 'NULL'), '-',
    IFNULL(tablespace_id, 'NULL'), '-',
    engine)
  FROM mysql.indexes
  WHERE table_id IN ($dd_table_ids)
  ORDER BY id;

-- Definitions from index_column_usage.
eval INSERT INTO dd_check_table(t)
  SELECT CONCAT(
    index_id, '-',
    ordinal_position, '-',
    column_id, '-',
    IFNULL(length, 'NULL'), '-',
    `order`, '-',
    hidden)
  FROM mysql.index_column_usage
  WHERE index_id IN (
    SELECT id FROM mysql.indexes WHERE table_id IN ($dd_table_ids)
  )
  ORDER BY index_id, column_id;

-- Definitions from foreign_keys.
eval INSERT INTO dd_check_table(t)
  SELECT CONCAT(
    id, '-',
    schema_id, '-',
    table_id, '-',
    name, '-',
    IFNULL(unique_constraint_name, 'NULL'), '-',
    match_option, '-',
    update_rule, '-',
    delete_rule, '-',
    referenced_table_catalog, '-',
    referenced_table_schema, '-',
    referenced_table_name, '-',
    IFNULL(options, 'NULL'))
  FROM mysql.foreign_keys
  WHERE table_id IN ($dd_table_ids)
  ORDER BY id;

-- Definitions from foreign_key_column_usage.
eval INSERT INTO dd_check_table(t)
  SELECT CONCAT(
    foreign_key_id, '-',
    ordinal_position, '-',
    column_id, '-',
    referenced_column_name)
  FROM mysql.foreign_key_column_usage
  WHERE foreign_key_id IN (
    SELECT id FROM mysql.foreign_keys WHERE table_id IN ($dd_table_ids)
  )
  ORDER BY foreign_key_id, ordinal_position;

-- Create checksums for each row.
UPDATE dd_check_table SET row_hash = SHA2(t, 256);

-- And then a checksum of all rows. We need about 1500 rows of varchar(64)
-- concatenated.
SET @old_group_concat_max_len = @@group_concat_max_len;
SET group_concat_max_len = 100000;

CREATE TABLE whole_schema(row_checksums LONGTEXT, checksum VARCHAR(64));
INSERT INTO whole_schema (row_checksums)
  SELECT GROUP_CONCAT(row_hash ORDER BY id)
    FROM dd_check_table;
UPDATE whole_schema SET checksum = SHA2(row_checksums, 256);

let $assert_cond = "[SELECT LENGTH(row_checksums) FROM whole_schema]"
                    < @@group_concat_max_len;

-- Insert historical records of DD version numbers and checksums. For a
-- new DD version, add a new row below. Please read the comments at the
-- beginning of the test file to make sure this is done correctly. Note
-- that the checksums are different depending on case sensitivity of the
-- underlying file system. Hence, the lctn field is used as a discriminator
-- (lctn = lower case table names).

CREATE TABLE dd_published_schema(
  version VARCHAR(20),
  lctn BOOL,
  checksum VARCHAR(64),
  PRIMARY KEY (version, lctn));

-- Checksums with ids.
INSERT INTO dd_published_schema
  VALUES ('80004', 0,
    '7de8b2fe214be4dbb15c3d8e4c08ab74f190bca269dd08861a4cf66ea5de1804');
INSERT INTO dd_published_schema
  VALUES ('80004', 1,
    'f607ab08b2d2b2d93d8867ad75116655d9c942647245d7846be440ec916c440f');
INSERT INTO dd_published_schema
  VALUES ('80011', 0,
    'e849364aeb724ff89f9d4d01bea6e933b9f0ef5087b4098a83acbe584a2f0702');
INSERT INTO dd_published_schema
  VALUES ('80011', 1,
    'ac9e620d1fcd8389cce7660c7f7bbc0acbe3a31fd52799ef8816981bf6de73fd');
INSERT INTO dd_published_schema
  VALUES ('80012', 0,
    '99a69f08be21df8b57153fa84f393dee3deb01ad43551d7268718db479c4d102');
INSERT INTO dd_published_schema
  VALUES ('80012', 1,
    '3ae447b4c0b3d3575978bad87c6d8b47de6066a28d408d2ba563fb7b84f6fdfa');
INSERT INTO dd_published_schema
  VALUES ('80013', 0,
    '2839a06b849f7f622b51ddc9ad8c8b73d8d8437a930ddbdc7224e76ab0ea65c5');
INSERT INTO dd_published_schema
  VALUES ('80013', 1,
    'cabd11189d82dd3f93c9affa5a998d684f8ed617848d9787a38ba098472bae02');
INSERT INTO dd_published_schema
  VALUES ('80014', 0,
    'a1602dbb8a2af87654c3880adb8dfb977d2f0fab6e3a54d8b44f5ceff7782959');
INSERT INTO dd_published_schema
  VALUES ('80014', 1,
    'cc5651651505fe0a4ebccb74d82e6fcd9555a4bd29478e21637c95da98f4537c');
INSERT INTO dd_published_schema
  VALUES('80016', 0,
    '53c96d1a123e9b4370aef8e9f0d0396860f78f7dd0b8e6ce89faa9c3fddd1da6');
INSERT INTO dd_published_schema
  VALUES('80016', 1,
    '4dfe903c56e29601504a494bcc881055115b2f5d32cee32462708c233f5e1434');
INSERT INTO dd_published_schema
  VALUES('80017', 0,
    '096c3d8c87873eb917cb03cd0a701f74e49587904836061ef9ca33c253eeb3ca');
INSERT INTO dd_published_schema
  VALUES('80017', 1,
    '76c4ef5922cfd8e2a736e538ada4b03b6b122fbd0df2ac5abfbd999e3316b17b');
INSERT INTO dd_published_schema
  VALUES('80021', 0,
    '80557e59b7af79e8a43e4b5efb7d5bab6a2db966935f0fe411b05b81cfdd1252');
INSERT INTO dd_published_schema
  VALUES('80021', 1,
    '1e886824945b448e2636e16360fc2078c33cf7980d07d13d62913d8a1d33e7f5');
INSERT INTO dd_published_schema
  VALUES('80022', 0,
    '5329f0032a5ea7cae6adcbfa5519c2aca93f8eacc99db4d9ff463320196e87e5');
INSERT INTO dd_published_schema
  VALUES('80022', 1,
    '90493021c4a9565f9bd050481f046dbf7e0741f647397a1d8b46aaadd8581484');
INSERT INTO dd_published_schema
  VALUES('80023', 0,
    'ba451f47c6774de7dddec4417b8a923e9ada805ec9ca68e9ef56b3ba6bd414f3');
INSERT INTO dd_published_schema
  VALUES('80023', 1,
    '6e3311099b985c198bb3acbc88495825847dac79588dea4f0be2e4219ad7c52b');
INSERT INTO dd_published_schema
  VALUES('80200', 0,
    'a3e8513fa7db0783beba8ced3371196cc20ecb05291a6d0cdef545f1a4e8be25');
 INSERT INTO dd_published_schema
  VALUES('80200', 1,
    '8ee19626f672bcb6e487fe3555cc9580e9de021144aa047a09446244002aaa05');
SELECT IFNULL(CONCAT('The schema checksum corresponds to DD version ',
                     version, '.'),
              CONCAT('No DD version found with schema checksum ',
                     whole_schema.checksum, '.')) AS CHECK_STATUS
  FROM dd_published_schema
    RIGHT OUTER JOIN whole_schema
    ON dd_published_schema.checksum= whole_schema.checksum;

-- Please read the comments at the beginning of the test file to make sure an
-- error in the assert below is handled correctly.

let $assert_cond = "[SELECT COUNT(version)
                       FROM dd_published_schema, whole_schema
                       WHERE dd_published_schema.checksum =
                             whole_schema.checksum
                       AND lctn = @@global.lower_case_file_system]" = 1;

SET group_concat_max_len = @old_group_concat_max_len;
            $dd_table_names, $ddse_table_names;
SET debug = '-d,skip_dd_table_access_check';
