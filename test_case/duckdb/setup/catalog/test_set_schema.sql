CREATE SCHEMA test;
CREATE SCHEMA out_of_path;
SET SESSION schema = 'test';
CREATE TABLE main.main_table(j INTEGER);
CREATE TABLE test_table(i INTEGER);
CREATE TABLE out_of_path.oop_table(k INTEGER);
