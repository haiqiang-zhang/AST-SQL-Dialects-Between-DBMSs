CREATE TABLE data_horizontal (
    key Int
)
Engine=MergeTree()
ORDER BY key;
INSERT INTO data_horizontal VALUES (1);
