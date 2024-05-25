SELECT * FROM t3;
DELETE FROM t3;
INSERT INTO t3(t3_a) SELECT 1 UNION SELECT 2 UNION SELECT 3;
SELECT * FROM t3;
CREATE TABLE InventoryControl (
    InventoryControlId INTEGER PRIMARY KEY AUTOINCREMENT,
    SKU INTEGER NOT NULL,
    Variant INTEGER NOT NULL DEFAULT 0,
    ControlDate DATE NOT NULL,
    ControlState INTEGER NOT NULL DEFAULT -1,
    DeliveredQty VARCHAR(30)
  );
CREATE TABLE InventoryItem (
    SKU INTEGER NOT NULL,
    Variant INTEGER NOT NULL DEFAULT 0,
    DeptCode INTEGER NOT NULL,
    GroupCode INTEGER NOT NULL,
    ItemDescription VARCHAR(120) NOT NULL,
    PRIMARY KEY(SKU, Variant)
  );
INSERT INTO InventoryItem VALUES(220,0,1,170,'Scoth Tampon Recurer');
INSERT INTO InventoryItem VALUES(31,0,1,110,'Fromage');
CREATE TABLE TransactionDetail (
    TransactionId INTEGER NOT NULL,
    SKU INTEGER NOT NULL,
    Variant INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY(TransactionId, SKU, Variant)
  );
INSERT INTO TransactionDetail(TransactionId, SKU, Variant) VALUES(44, 31, 0);
INSERT INTO InventoryControl(SKU, Variant, ControlDate) SELECT 
      II.SKU AS SKU, II.Variant AS Variant, '2011-08-30' AS ControlDate 
      FROM InventoryItem II;
SELECT SKU, DeliveredQty FROM InventoryControl WHERE SKU=31;
SELECT CASE WHEN DeliveredQty=10 THEN 'TEST PASSED!' ELSE 'TEST FAILED!' END 
  FROM InventoryControl WHERE SKU=31;
