ATTACH '${S3_ATTACH_DB_PRESIGNED_URL}' AS db (READONLY 1);;
CREATE TABLE db.integers(i INTEGER);;
SELECT * FROM db.all_types;
SELECT * FROM db.all_typez;
DETACH db;
SELECT * FROM db.integral_values;
