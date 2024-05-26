DROP TABLE IF EXISTS data_null;
DROP TABLE IF EXISTS set_null;
DROP TABLE IF EXISTS cannot_be_nullable;
SET data_type_default_nullable='false';
CREATE TABLE data_null (
    a INT NULL,
    b INT NOT NULL,
    c Nullable(INT),
    d INT
) engine=Memory();
INSERT INTO data_null VALUES (NULL, 2, NULL, 4);
