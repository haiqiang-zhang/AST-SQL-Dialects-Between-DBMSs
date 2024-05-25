DROP TABLE IF EXISTS upyachka;
CREATE TABLE upyachka (x UInt64) ENGINE = Memory;
DESC TABLE merge(currentDatabase(), 'upyachka');
DROP TABLE upyachka;
