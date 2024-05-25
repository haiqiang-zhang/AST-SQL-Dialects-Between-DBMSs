DROP TABLE IF EXISTS 02501_test;
DROP TABLE IF EXISTS 02501_dist;
DROP VIEW IF EXISTS 02501_view;
CREATE TABLE 02501_test(`a` UInt64) ENGINE = Memory;
CREATE VIEW 02501_view(`a` UInt64) AS SELECT a FROM 02501_dist;
insert into 02501_test values(5),(6),(7),(8);
DROP TABLE IF EXISTS 02501_test;
DROP TABLE IF EXISTS 02501_dist;
DROP VIEW IF EXISTS 02501_view;
