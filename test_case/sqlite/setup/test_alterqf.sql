CREATE TABLE t1(a, b, c);
CREATE TABLE x1(
      one, two, three, PRIMARY KEY(one), 
      CHECK (three!="xyz"), CHECK (two!="one")
  ) WITHOUT ROWID;
CREATE INDEX x1i ON x1(one+"two"+"four") WHERE "five";
ALTER TABLE x1 RENAME two TO 'four';
