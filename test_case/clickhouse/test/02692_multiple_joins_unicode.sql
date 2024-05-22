DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS sales;
CREATE TABLE store (id UInt32, "ÃÂ¥ÃÂÃÂÃÂ§ÃÂ§ÃÂ°" String, "ÃÂ§ÃÂÃÂ¶ÃÂ¦ÃÂÃÂ" String) ENGINE=MergeTree() Order by id;
CREATE TABLE location (id UInt32, name String) ENGINE=MergeTree() Order by id;
CREATE TABLE sales ("ÃÂ¦ÃÂÃÂ¥ÃÂ¦ÃÂÃÂ" Date, "ÃÂ¥ÃÂºÃÂÃÂ©ÃÂÃÂº" UInt32, "ÃÂ¥ÃÂÃÂ°ÃÂ¥ÃÂÃÂ" UInt32, "ÃÂ©ÃÂÃÂÃÂ¥ÃÂÃÂ®ÃÂ©ÃÂ¢ÃÂ" Float32) ENGINE=MergeTree() Order by "ÃÂ¦ÃÂÃÂ¥ÃÂ¦ÃÂÃÂ";
INSERT INTO store VALUES (1,'ÃÂ¥ÃÂºÃÂÃÂ©ÃÂÃÂº1','ÃÂ¥ÃÂÃÂ¯ÃÂ§ÃÂÃÂ¨'),(2,'ÃÂ¥ÃÂºÃÂÃÂ©ÃÂÃÂº2','ÃÂ¥ÃÂÃÂÃÂ§ÃÂÃÂ¨');
INSERT INTO location VALUES (1,'ÃÂ¤ÃÂ¸ÃÂÃÂ¦ÃÂµÃÂ·ÃÂ¥ÃÂ¸ÃÂ'),(2,'ÃÂ¥ÃÂÃÂÃÂ¤ÃÂºÃÂ¬ÃÂ¥ÃÂ¸ÃÂ');
INSERT INTO sales VALUES ('2021-01-01',1,1,10),('2021-01-02',2,2,20);
SELECT
    `ÃÂ¦ÃÂÃÂ¥ÃÂ¦ÃÂÃÂ`,
    location.name,
    store.`ÃÂ§ÃÂÃÂ¶ÃÂ¦ÃÂÃÂ`
FROM sales
LEFT JOIN store ON store.id = `ÃÂ¥ÃÂºÃÂÃÂ©ÃÂÃÂº`
LEFT JOIN location ON location.id = `ÃÂ¥ÃÂÃÂ°ÃÂ¥ÃÂÃÂ`
ORDER BY 1, 2, 3;
DROP TABLE store;
DROP TABLE location;
DROP TABLE sales;
