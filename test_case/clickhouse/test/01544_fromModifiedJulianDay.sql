SELECT 'Invocation with constant';
SELECT fromModifiedJulianDay(-1);
SELECT 'or null';
SELECT fromModifiedJulianDayOrNull(59154);
SELECT 'Invocation with Int32 column';
DROP TABLE IF EXISTS fromModifiedJulianDay_test;
CREATE TABLE fromModifiedJulianDay_test (d Int32) ENGINE = Memory;
INSERT INTO fromModifiedJulianDay_test VALUES (-1), (0), (59154);
DROP TABLE fromModifiedJulianDay_test;
