drop table if exists t1, t2;
CREATE TABLE t1 (
       id           VARCHAR(80) NOT NULL PRIMARY KEY,
       sujet        VARCHAR(80),
       motsclefs    TEXT,
       texte        MEDIUMTEXT,
       FULLTEXT(sujet, motsclefs, texte)
);
INSERT INTO t1 VALUES('123','toto','essai','test');
INSERT INTO t1 VALUES('456','droit','penal','lawyer');
INSERT INTO t1 VALUES('789','aaaaa','bbbbb','cccccc');
CREATE TABLE t2 (
       id         VARCHAR(255) NOT NULL,
       author     VARCHAR(255) NOT NULL
);
INSERT INTO t2 VALUES('123', 'moi');
INSERT INTO t2 VALUES('123', 'lui');
INSERT INTO t2 VALUES('456', 'lui');
