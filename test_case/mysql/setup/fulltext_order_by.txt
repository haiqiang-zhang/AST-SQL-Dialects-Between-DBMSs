DROP TABLE IF EXISTS t1,t2,t3;
CREATE TABLE t1 (
  a INT AUTO_INCREMENT PRIMARY KEY,
  message CHAR(20),
  FULLTEXT(message)
) comment = 'original testcase by sroussey@network54.com';
INSERT INTO t1 (message) VALUES ("Testing"),("table"),("testbug"),
        ("steve"),("is"),("cool"),("steve is cool");
