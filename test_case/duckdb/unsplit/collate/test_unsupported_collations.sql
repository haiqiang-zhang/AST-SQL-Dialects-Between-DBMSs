CREATE TABLE collate_test(s VARCHAR COLLATE blabla);
CREATE TABLE collate_test(s INTEGER COLLATE blabla);
CREATE TABLE collate_test(s VARCHAR COLLATE NOACCENT.NOACCENT);
CREATE TABLE collate_test(s VARCHAR COLLATE 1);
CREATE TABLE collate_test(s VARCHAR COLLATE 'hello');
PRAGMA default_collation='blabla';
