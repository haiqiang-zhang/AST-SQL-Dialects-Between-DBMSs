BEGIN TRANSACTION;
CREATE TABLE integers(i INTEGER, j INTEGER, CHECK(i+j<10));