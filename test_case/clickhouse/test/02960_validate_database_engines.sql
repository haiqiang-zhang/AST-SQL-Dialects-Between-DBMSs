DROP DATABASE IF EXISTS test2960_valid_database_engine;
CREATE DATABASE test2960_valid_database_engine ENGINE = Atomic;
CREATE DATABASE test2960_database_engine_args_not_allowed ENGINE = Atomic('foo', 'bar');
-- create database with an invalid engine. Should fail.
CREATE DATABASE test2960_invalid_database_engine ENGINE = Foo;
DROP DATABASE IF EXISTS test2960_valid_database_engine;