CREATE TABLE t1(
      a INT PRIMARY KEY,
      b INT
           REFERENCES t1 ON DELETE CASCADE
           REFERENCES t2,
      c TEXT,
      FOREIGN KEY (b,c) REFERENCES t2(x,y) ON UPDATE CASCADE
    ) WITHOUT rowid;
CREATE TABLE t2(
      x INT PRIMARY KEY,
      y TEXT
    ) WITHOUT rowid;
CREATE TABLE t3(
      a INT REFERENCES t2,
      b INT REFERENCES t1,
      FOREIGN KEY (a,b) REFERENCES t2(x,y)
    );
CREATE TABLE t4(a int primary key) WITHOUT rowid;
CREATE TABLE t5(x references t4);
CREATE TABLE t6(x references t4);
CREATE TABLE t7(x references t4);
CREATE TABLE t8(x references t4);
CREATE TABLE t9(x references t4);
CREATE TABLE t10(x references t4);
DROP TABLE t7;
DROP TABLE t9;
DROP TABLE t5;
DROP TABLE t8;
DROP TABLE t6;
DROP TABLE t10;
CREATE TABLE t5(a PRIMARY KEY, b, c) WITHOUT rowid;
CREATE TABLE t6(
      d REFERENCES t5,
      e REFERENCES t5(c)
    );
PRAGMA foreign_key_list(t6);
CREATE TABLE t7(d, e, f,
      FOREIGN KEY (d, e) REFERENCES t5(a, b)
    );
PRAGMA foreign_key_list(t7);
CREATE TABLE t8(d, e, f,
      FOREIGN KEY (d, e) REFERENCES t5 ON DELETE CASCADE ON UPDATE SET NULL
    );
PRAGMA foreign_key_list(t8);
CREATE TABLE t9(d, e, f,
      FOREIGN KEY (d, e) REFERENCES t5 ON DELETE CASCADE ON UPDATE SET DEFAULT
    );
PRAGMA foreign_key_list(t9);