CREATE TABLE dd_check_table (id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
   t TEXT NOT NULL,
   row_hash VARCHAR(64) DEFAULT NULL);
UPDATE dd_check_table SET row_hash = SHA2(t, 256);
CREATE TABLE whole_schema(row_checksums LONGTEXT, checksum VARCHAR(64));
INSERT INTO whole_schema (row_checksums)
  SELECT GROUP_CONCAT(row_hash ORDER BY id)
    FROM dd_check_table;
UPDATE whole_schema SET checksum = SHA2(row_checksums, 256);
CREATE TABLE dd_published_schema(
  version VARCHAR(20),
  lctn BOOL,
  checksum VARCHAR(64),
  PRIMARY KEY (version, lctn));
INSERT INTO dd_published_schema
  VALUES ('80004', 0,
    '7de8b2fe214be4dbb15c3d8e4c08ab74f190bca269dd08861a4cf66ea5de1804');
INSERT INTO dd_published_schema
  VALUES ('80004', 1,
    'f607ab08b2d2b2d93d8867ad75116655d9c942647245d7846be440ec916c440f');
INSERT INTO dd_published_schema
  VALUES ('80011', 0,
    'e849364aeb724ff89f9d4d01bea6e933b9f0ef5087b4098a83acbe584a2f0702');
INSERT INTO dd_published_schema
  VALUES ('80011', 1,
    'ac9e620d1fcd8389cce7660c7f7bbc0acbe3a31fd52799ef8816981bf6de73fd');
INSERT INTO dd_published_schema
  VALUES ('80012', 0,
    '99a69f08be21df8b57153fa84f393dee3deb01ad43551d7268718db479c4d102');
INSERT INTO dd_published_schema
  VALUES ('80012', 1,
    '3ae447b4c0b3d3575978bad87c6d8b47de6066a28d408d2ba563fb7b84f6fdfa');
INSERT INTO dd_published_schema
  VALUES ('80013', 0,
    '2839a06b849f7f622b51ddc9ad8c8b73d8d8437a930ddbdc7224e76ab0ea65c5');
INSERT INTO dd_published_schema
  VALUES ('80013', 1,
    'cabd11189d82dd3f93c9affa5a998d684f8ed617848d9787a38ba098472bae02');
INSERT INTO dd_published_schema
  VALUES ('80014', 0,
    'a1602dbb8a2af87654c3880adb8dfb977d2f0fab6e3a54d8b44f5ceff7782959');
INSERT INTO dd_published_schema
  VALUES ('80014', 1,
    'cc5651651505fe0a4ebccb74d82e6fcd9555a4bd29478e21637c95da98f4537c');
INSERT INTO dd_published_schema
  VALUES('80016', 0,
    '53c96d1a123e9b4370aef8e9f0d0396860f78f7dd0b8e6ce89faa9c3fddd1da6');
INSERT INTO dd_published_schema
  VALUES('80016', 1,
    '4dfe903c56e29601504a494bcc881055115b2f5d32cee32462708c233f5e1434');
INSERT INTO dd_published_schema
  VALUES('80017', 0,
    '096c3d8c87873eb917cb03cd0a701f74e49587904836061ef9ca33c253eeb3ca');
INSERT INTO dd_published_schema
  VALUES('80017', 1,
    '76c4ef5922cfd8e2a736e538ada4b03b6b122fbd0df2ac5abfbd999e3316b17b');
INSERT INTO dd_published_schema
  VALUES('80021', 0,
    '80557e59b7af79e8a43e4b5efb7d5bab6a2db966935f0fe411b05b81cfdd1252');
INSERT INTO dd_published_schema
  VALUES('80021', 1,
    '1e886824945b448e2636e16360fc2078c33cf7980d07d13d62913d8a1d33e7f5');
INSERT INTO dd_published_schema
  VALUES('80022', 0,
    '5329f0032a5ea7cae6adcbfa5519c2aca93f8eacc99db4d9ff463320196e87e5');
INSERT INTO dd_published_schema
  VALUES('80022', 1,
    '90493021c4a9565f9bd050481f046dbf7e0741f647397a1d8b46aaadd8581484');
INSERT INTO dd_published_schema
  VALUES('80023', 0,
    'ba451f47c6774de7dddec4417b8a923e9ada805ec9ca68e9ef56b3ba6bd414f3');
INSERT INTO dd_published_schema
  VALUES('80023', 1,
    '6e3311099b985c198bb3acbc88495825847dac79588dea4f0be2e4219ad7c52b');
INSERT INTO dd_published_schema
  VALUES('80200', 0,
    'a3e8513fa7db0783beba8ced3371196cc20ecb05291a6d0cdef545f1a4e8be25');
INSERT INTO dd_published_schema
  VALUES('80200', 1,
    '8ee19626f672bcb6e487fe3555cc9580e9de021144aa047a09446244002aaa05');
