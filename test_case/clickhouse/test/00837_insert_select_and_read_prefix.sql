DROP TABLE IF EXISTS file;
CREATE TABLE file (s String, n UInt32) ENGINE = File(CSVWithNames);
DROP TABLE file;
