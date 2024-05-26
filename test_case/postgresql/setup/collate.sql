CREATE SCHEMA collate_tests;
SET search_path = collate_tests;
CREATE TABLE collate_test1 (
    a int,
    b text COLLATE "C" NOT NULL
);
CREATE TABLE collate_test_like (
    LIKE collate_test1
);
CREATE TABLE collate_test2 (
    a int,
    b text COLLATE "POSIX"
);
INSERT INTO collate_test1 VALUES (1, 'abc'), (2, 'Abc'), (3, 'bbc'), (4, 'ABD');
INSERT INTO collate_test2 SELECT * FROM collate_test1;
