CREATE TABLE time_zone(f1 INT PRIMARY KEY) ENGINE=MyISAM;
INSERT INTO time_zone VALUES (10);
SELECT * FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND
                                                  TABLE_NAME = 'time_zone';
DROP TABLE time_zone;
