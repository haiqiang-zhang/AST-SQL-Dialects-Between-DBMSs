CREATE TABLE t(i,j,k,m,n);
CREATE INDEX ijk ON t(i,j,k);
CREATE INDEX jmn ON t(j,m,n);
INSERT INTO t VALUES(3, 3, 'three', 3, 'tres');
INSERT INTO t VALUES(2, 2, 'two', 2, 'dos');
INSERT INTO t VALUES(1, 1, 'one', 1, 'uno');
INSERT INTO t VALUES(4, 4, 'four', 4, 'cuatro');
