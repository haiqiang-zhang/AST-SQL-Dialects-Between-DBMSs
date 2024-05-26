CREATE TABLE t1(a PRIMARY KEY, b);
CREATE TABLE counter(
      i CHECK (i<5), 
      u CHECK (u<10)
    );
INSERT INTO counter VALUES(0, 0);
