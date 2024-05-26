drop table if exists t1,t2,t3;
CREATE TABLE t1 (a VARCHAR(200), b TEXT, FULLTEXT (a,b)) charset utf8mb4;
INSERT INTO t1 VALUES('MySQL has now support', 'for full-text search'),
                       ('Full-text indexes', 'are called collections'),
                          ('Only MyISAM tables','support collections'),
             ('Function MATCH ... AGAINST()','is used to do a search'),
        ('Full-text search in MySQL', 'implements vector space model');
