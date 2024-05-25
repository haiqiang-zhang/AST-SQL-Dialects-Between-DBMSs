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
PRAGMA foreign_keys=ON;
CREATE TABLE "xx1"("xx2" TEXT PRIMARY KEY, "xx3" TEXT);
INSERT INTO "xx1"("xx2","xx3") VALUES('abc','def');
CREATE TABLE "xx4"("xx5" TEXT REFERENCES "xx1" ON DELETE CASCADE);
INSERT INTO "xx4"("xx5") VALUES('abc');
INSERT INTO "xx1"("xx2","xx3") VALUES('uvw','xyz');
SELECT 1, "xx5" FROM "xx4";
DELETE FROM "xx1";
SELECT 2, "xx5" FROM "xx4";
PRAGMA foreign_keys=ON;
CREATE TABLE """1"("""2" TEXT PRIMARY KEY, """3" TEXT);
INSERT INTO """1"("""2","""3") VALUES('abc','def');
CREATE TABLE """4"("""5" TEXT REFERENCES """1" ON DELETE CASCADE);
INSERT INTO """4"("""5") VALUES('abc');
INSERT INTO """1"("""2","""3") VALUES('uvw','xyz');
SELECT 1, """5" FROM """4";
DELETE FROM """1";
SELECT 2, """5" FROM """4";
PRAGMA table_info="""1";
CREATE TABLE t11(
    x INTEGER PRIMARY KEY, 
    parent REFERENCES t11 ON DELETE CASCADE
  );
INSERT INTO t11 VALUES (1, NULL), (2, 1), (3, 2);
CREATE TABLE Foo (
    Id INTEGER PRIMARY KEY, 
    ParentId INTEGER REFERENCES Foo(Id) ON DELETE CASCADE, C1
  );
INSERT OR REPLACE INTO Foo(Id, ParentId, C1) VALUES (1, null, 'A');
INSERT OR REPLACE INTO Foo(Id, ParentId, C1) VALUES (2, 1, 'A-2-1');
INSERT OR REPLACE INTO Foo(Id, ParentId, C1) VALUES (3, 2, 'A-3-2');
INSERT OR REPLACE INTO Foo(Id, ParentId, C1) VALUES (4, 3, 'A-4-3');
CREATE TABLE p1(x, y);
CREATE UNIQUE INDEX p1x ON p1(x) WHERE y<2;
INSERT INTO p1 VALUES(1, 1);
CREATE TABLE c1(a REFERENCES p1(x));
CREATE UNIQUE INDEX p1x2 ON p1(x);
INSERT INTO c1 VALUES(1);
PRAGMA foreign_keys=OFF;
INSERT INTO t1 VALUES(1,2,3);
DROP TABLE t1;
CREATE TABLE t1(a,b,c AS(1),d, FOREIGN KEY(c,d,b,a,b,d,b,c) REFERENCES t0);
PRAGMA writable_schema=ON;
PRAGMA foreign_keys = ON;
CREATE TABLE sqlite_stat1 (tbl INTEGER PRIMARY KEY DESC, idx UNIQUE DEFAULT NULL) WITHOUT ROWID;
PRAGMA writable_schema=OFF;
CREATE TABLE sqlsim4(stat PRIMARY KEY);
DROP table "sqlsim4";
PRAGMA writable_schema=ON;
UPDATE sqlite_schema SET name='sqlite_autoindex_sqlite_stat1_1' WHERE name='sqlite_autoindex_sqlite_stat1_2';
PRAGMA writable_schema=RESET;
PRAGMA foreign_keys = ON;
DELETE FROM """1";
