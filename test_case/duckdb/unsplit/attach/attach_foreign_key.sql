ATTACH DATABASE ':memory:' AS db1;
CREATE TABLE album(artistid INTEGER, albumname TEXT, albumcover TEXT, UNIQUE (artistid, albumname));
