PRAGMA foreign_keys = OFF;
CREATE TABLE t1(c1 one);
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 one two);
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 one two three);
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 one two three four);
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 one two three four(14));
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 one two three four(14, 22));
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 var(+14, -22.3));
PRAGMA foreign_keys = OFF;
DROP table "t1";
CREATE TABLE t1(c1 var(1.0e10));
PRAGMA foreign_keys = OFF;
DROP table "t1";
PRAGMA foreign_keys = OFF;
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text PRIMARY KEY);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text PRIMARY KEY ASC);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text PRIMARY KEY DESC);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT cons PRIMARY KEY DESC);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text NOT NULL);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT nm NOT NULL);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text NULL);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT nm NULL);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text UNIQUE);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT un UNIQUE);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CHECK(c1!=0));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT chk CHECK(c1!=0));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text DEFAULT 1);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text DEFAULT -1);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text DEFAULT +1);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text DEFAULT -45.8e22);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text DEFAULT (1+1));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT "1 2" DEFAULT (1+1));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text COLLATE nocase);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 text CONSTRAINT 'a x' COLLATE nocase);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 REFERENCES t2);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 CONSTRAINT abc REFERENCES t2);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 
      PRIMARY KEY NOT NULL UNIQUE CHECK(c1 IS 'ten') DEFAULT 123 REFERENCES t1
    );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1 
      REFERENCES t1 DEFAULT 123 CHECK(c1 IS 'ten') UNIQUE NOT NULL PRIMARY KEY 
    );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
PRAGMA foreign_keys = OFF;
DROP table "t2";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, PRIMARY KEY(c1));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, PRIMARY KEY(c1, c2));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, PRIMARY KEY(c1, c2) ON CONFLICT IGNORE);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, UNIQUE(c1));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, UNIQUE(c1, c2));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, UNIQUE(c1, c2) ON CONFLICT IGNORE);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, CHECK(c1 IS NOT c2));
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
CREATE TABLE t1(c1, c2, FOREIGN KEY(c1) REFERENCES t2);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY);
PRAGMA foreign_keys = OFF;
DROP table "t2";
CREATE TABLE t1(
           col1,
           col2 TEXT,
           col3 INTEGER UNIQUE,
           col4 VARCHAR(10, 10) PRIMARY KEY,
           "name with spaces" REFERENCES t1
         );
PRAGMA foreign_keys = OFF;
DROP table "t1";
PRAGMA foreign_keys = OFF;
CREATE TABLE t2(a, b, c);
CREATE TABLE t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMP TABLE t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMPORARY TABLE t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TABLE IF NOT EXISTS t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMP TABLE IF NOT EXISTS t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMPORARY TABLE IF NOT EXISTS t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TABLE main.t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMP TABLE temp.t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMPORARY TABLE temp.t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TABLE IF NOT EXISTS main.t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMP TABLE IF NOT EXISTS temp.t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMPORARY TABLE IF NOT EXISTS temp.t1(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TABLE t1 AS SELECT * FROM t2;
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TEMP TABLE t1 AS SELECT c, b, a FROM t2;
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
CREATE TABLE t1 AS SELECT count(*), max(b), min(a) FROM t2;
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t1";
CREATE TABLE t2(a, b, c);
PRAGMA foreign_keys = OFF;
DROP table "t2";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH FULL 
    ON DELETE SET NULL ON UPDATE RESTRICT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) 
    ON DELETE RESTRICT ON UPDATE SET NULL MATCH FULL 
    NOT DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH PARTIAL 
    ON DELETE SET NULL ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH PARTIAL 
    ON DELETE RESTRICT ON UPDATE SET DEFAULT 
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH PARTIAL 
    ON DELETE RESTRICT ON UPDATE RESTRICT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH PARTIAL 
    ON DELETE NO ACTION ON UPDATE SET DEFAULT NOT DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH SIMPLE 
    ON DELETE SET NULL ON UPDATE CASCADE NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH SIMPLE 
    ON DELETE SET DEFAULT ON UPDATE SET NULL DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH SIMPLE 
    ON DELETE SET DEFAULT  NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH SIMPLE 
    ON DELETE RESTRICT ON UPDATE SET DEFAULT NOT DEFERRABLE INITIALLY DEFERRED
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH SIMPLE 
    ON DELETE RESTRICT ON UPDATE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH SIMPLE 
    ON DELETE NO ACTION ON UPDATE SET DEFAULT NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH STICK 
    ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) MATCH STICK 
    ON UPDATE SET NULL NOT DEFERRABLE INITIALLY DEFERRED
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x)
    ON DELETE SET NULL ON UPDATE NO ACTION DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) ON DELETE RESTRICT ON UPDATE NO ACTION NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2(x) NOT DEFERRABLE INITIALLY DEFERRED
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH FULL 
    ON DELETE SET NULL ON UPDATE SET NULL DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH FULL 
    ON DELETE SET NULL ON UPDATE SET DEFAULT NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH FULL ON DELETE SET DEFAULT ON UPDATE SET NULL 
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH FULL 
    ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH PARTIAL 
    ON DELETE SET NULL ON UPDATE RESTRICT NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH PARTIAL 
    ON DELETE SET NULL ON UPDATE NO ACTION DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH PARTIAL ON DELETE CASCADE ON UPDATE SET DEFAULT 
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH PARTIAL NOT DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH SIMPLE 
    ON DELETE SET DEFAULT ON UPDATE CASCADE DEFERRABLE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH STICK 
    ON DELETE SET NULL ON UPDATE NO ACTION DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH STICK 
    ON DELETE NO ACTION ON UPDATE SET DEFAULT NOT DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 MATCH STICK 
    ON UPDATE SET DEFAULT DEFERRABLE INITIALLY IMMEDIATE
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
CREATE TABLE t1(a 
    REFERENCES t2 
    ON DELETE RESTRICT ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
  );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
DROP table "t1";
CREATE TABLE t2(x PRIMARY KEY, y);
CREATE TABLE t3(i, j, UNIQUE(i, j) );
PRAGMA foreign_keys = OFF;
DROP table "t2";
DROP table "t3";
