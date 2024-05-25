CREATE TABLE source_package_status
          (bug_name TEXT NOT NULL,
           package INTEGER NOT NULL,
           vulnerable INTEGER NOT NULL,
           urgency TEXT NOT NULL,
           PRIMARY KEY (bug_name, package));
CREATE INDEX source_package_status_package
              ON source_package_status(package);
CREATE TABLE source_packages
              (name TEXT NOT NULL,
              release TEXT NOT NULL,
              subrelease TEXT NOT NULL,
              archive TEXT NOT NULL,
              version TEXT NOT NULL,
              version_id INTEGER NOT NULL DEFAULT 0,
              PRIMARY KEY (name, release, subrelease, archive));
CREATE TABLE bugs
          (name TEXT NOT NULL PRIMARY KEY,
           cve_status TEXT NOT NULL
               CHECK (cve_status IN
                      ('', 'CANDIDATE', 'ASSIGNED', 'RESERVED', 'REJECTED')),
           not_for_us INTEGER NOT NULL CHECK (not_for_us IN (0, 1)),
           description TEXT NOT NULL,
           release_date TEXT NOT NULL,
           source_file TEXT NOT NULL,
           source_line INTEGER NOT NULL);
CREATE TABLE package_notes
          (id INTEGER NOT NULL PRIMARY KEY,
           bug_name TEXT NOT NULL,
           package TEXT NOT NULL,
           fixed_version TEXT
               CHECK (fixed_version IS NULL OR fixed_version <> ''),
           fixed_version_id INTEGER NOT NULL DEFAULT 0,
           release TEXT NOT NULL,
           package_kind TEXT NOT NULL DEFAULT 'unknown',
           urgency TEXT NOT NULL,
           bug_origin TEXT NOT NULL DEFAULT '');
CREATE INDEX package_notes_package
              ON package_notes(package);
CREATE UNIQUE INDEX package_notes_bug
              ON package_notes(bug_name, package, release);
CREATE TABLE debian_bugs
          (bug INTEGER NOT NULL,
           note INTEGER NOT NULL,
           PRIMARY KEY (bug, note));
CREATE VIEW debian_cve AS
              SELECT DISTINCT debian_bugs.bug, st.bug_name
              FROM package_notes, debian_bugs, source_package_status AS st
              WHERE package_notes.bug_name = st.bug_name
              AND debian_bugs.note = package_notes.id
              ORDER BY debian_bugs.bug;
EXPLAIN QUERY PLAN 
  SELECT
    st.bug_name,
    (SELECT ALL debian_cve.bug FROM debian_cve
      WHERE debian_cve.bug_name = st.bug_name
      ORDER BY debian_cve.bug),
    sp.release
  FROM
     source_package_status AS st,
     source_packages AS sp,
     bugs
  WHERE
     sp.rowid = st.package
     AND st.bug_name = bugs.name
     AND ( st.bug_name LIKE 'CVE-%' OR st.bug_name LIKE 'TEMP-%' )
     AND ( sp.release = 'sid' OR sp.release = 'stretch' OR sp.release = 'jessie'
            OR sp.release = 'wheezy' OR sp.release = 'squeeze' )
  ORDER BY sp.name, st.bug_name, sp.release, sp.subrelease;
CREATE TABLE one(o);
INSERT INTO one DEFAULT VALUES;
CREATE TABLE t1(x, z);
INSERT INTO t1 VALUES('aaa', 4.0);
INSERT INTO t1 VALUES('aaa', 4.0);
CREATE VIEW vvv AS
    SELECT * FROM t1
    UNION ALL
    SELECT 0, 0 WHERE 0;
SELECT (
      SELECT sum(z) FROM vvv WHERE x='aaa'
  ) FROM one;
DROP TABLE t1;
CREATE TABLE t1(aaa);
INSERT INTO t1(aaa) VALUES(9);
SELECT (
    SELECT aaa FROM t1 GROUP BY (
      SELECT bbb FROM (
        SELECT ccc AS bbb FROM (
           SELECT 1 ccc
        ) WHERE rowid IS NOT 1
      ) WHERE bbb = 1
    )
  );
-- This is the original test case reported on the mailing list
  CREATE TABLE artists (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    name varchar(255)
  );
CREATE TABLE albums (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    name varchar(255),
    artist_id integer REFERENCES artists
  );
INSERT INTO artists (name) VALUES ('Ar');
INSERT INTO albums (name, artist_id) VALUES ('Al', 1);
SELECT artists.*
  FROM artists
  INNER JOIN artists AS 'b' ON (b.id = artists.id)
  WHERE (artists.id IN (
    SELECT albums.artist_id
    FROM albums
    WHERE ((name = 'Al')
      AND (albums.artist_id IS NOT NULL)
      AND (albums.id IN (
        SELECT id
        FROM (
          SELECT albums.id,
                 row_number() OVER (
                   PARTITION BY albums.artist_id
                   ORDER BY name
                 ) AS 'x'
          FROM albums
          WHERE (name = 'Al')
        ) AS 't1'
        WHERE (x = 1)
      ))
      AND (albums.id IN (1, 2)))
  ));
CREATE TABLE t2 (b);
INSERT INTO t2 (b) VALUES (104);
CREATE TABLE t3 (c);
INSERT INTO t3 (c) VALUES (104);
CREATE TABLE t4 (d);
INSERT INTO t4 (d) VALUES (104);
CREATE TABLE t5(a, b, c, d);
CREATE INDEX t5a ON t5(a);
CREATE INDEX t5b ON t5(b);
CREATE TABLE t6(e);
INSERT INTO t6 VALUES(1);
INSERT INTO t5 VALUES(1,1,1,1), (2,2,2,2);
SELECT * FROM t5 WHERE (a=1 OR b=2) AND c IN (
    SELECT e FROM (SELECT DISTINCT e FROM t6) WHERE e=1
  );
INSERT INTO t2 VALUES(3);
