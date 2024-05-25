DROP TABLE IF EXISTS base;
DROP TABLE IF EXISTS copy_without_comment;
DROP TABLE IF EXISTS copy_with_comment;
CREATE TABLE base (a Int32) ENGINE = TinyLog COMMENT 'original comment';
CREATE TABLE copy_without_comment AS base;
CREATE TABLE copy_with_comment AS base COMMENT 'new comment';
