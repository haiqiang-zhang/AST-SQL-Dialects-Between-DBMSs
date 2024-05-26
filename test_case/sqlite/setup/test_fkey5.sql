PRAGMA foreign_key_list(c5);
CREATE TABLE k1(x REFERENCES s1);
PRAGMA foreign_key_check(k1);
INSERT INTO k1 VALUES(NULL);
PRAGMA foreign_key_check(k1);
INSERT INTO k1 VALUES(1);
PRAGMA foreign_key_check(k1);
CREATE TABLE k2(x, y, FOREIGN KEY(x, y) REFERENCES s1(a, b));
PRAGMA foreign_key_check(k2);
INSERT INTO k2 VALUES(NULL, 'five');
PRAGMA foreign_key_check(k2);
INSERT INTO k2 VALUES('one', NULL);
PRAGMA foreign_key_check(k2);
INSERT INTO k2 VALUES('six', 'seven');
PRAGMA foreign_key_check(k2);
CREATE TABLE p30 (id INTEGER PRIMARY KEY);
CREATE TABLE IF NOT EXISTS c30 (
      line INTEGER, 
      master REFERENCES p30(id), 
      PRIMARY KEY(master)
  ) WITHOUT ROWID;
INSERT INTO p30 (id) VALUES (1);
INSERT INTO c30 (master, line)  VALUES (1, 999);
PRAGMA foreign_key_check;
INSERT INTO c30 VALUES(45, 45);
PRAGMA foreign_key_check;
CREATE TABLE tt(y);
CREATE TABLE c11(x REFERENCES tt(y));
