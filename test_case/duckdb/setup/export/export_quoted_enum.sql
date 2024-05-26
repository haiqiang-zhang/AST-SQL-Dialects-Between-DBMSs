BEGIN TRANSACTION;
CREATE TYPE "group" AS ENUM ( 'one', 'two');
CREATE TABLE table1(col1 "group");
