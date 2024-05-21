DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS sales;
CREATE TABLE store (id UInt32, "åç§°" String, "ç¶æ" String) ENGINE=MergeTree() Order by id;
CREATE TABLE location (id UInt32, name String) ENGINE=MergeTree() Order by id;
CREATE TABLE sales ("æ¥æ" Date, "åºéº" UInt32, "å°å" UInt32, "éå®é¢" Float32) ENGINE=MergeTree() Order by "æ¥æ";
INSERT INTO store VALUES (1,'åºéº1','å¯ç¨'),(2,'åºéº2','åç¨');
INSERT INTO location VALUES (1,'ä¸æµ·å¸'),(2,'åäº¬å¸');
INSERT INTO sales VALUES ('2021-01-01',1,1,10),('2021-01-02',2,2,20);
SELECT
    `æ¥æ`,
    location.name,
    store.`ç¶æ`
FROM sales
LEFT JOIN store ON store.id = `åºéº`
LEFT JOIN location ON location.id = `å°å`
ORDER BY 1, 2, 3;
DROP TABLE store;
DROP TABLE location;
DROP TABLE sales;