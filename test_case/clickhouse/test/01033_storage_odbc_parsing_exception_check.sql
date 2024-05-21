DROP TABLE IF EXISTS BannerDict;
CREATE TABLE BannerDict (`BannerID` UInt64, `CompaignID` UInt64) ENGINE = ODBC('DSN=pgconn;
Database=postgres', bannerdict);
CREATE TABLE BannerDict (`BannerID` UInt64, `CompaignID` UInt64) ENGINE = ODBC('DSN=pgconn;
Database=postgres', somedb, bannerdict);
SHOW CREATE TABLE BannerDict;
DROP TABLE IF EXISTS BannerDict;