CREATE SCHEMA test;
CREATE TABLE test.documents(id VARCHAR, body VARCHAR);
INSERT INTO test.documents VALUES ('doc1', ' QUÃÂÃÂÃÂÃÂCKING+QUÃÂÃÂÃÂÃÂCKING+QUÃÂÃÂÃÂÃÂCKING'), ('doc2', ' BÃÂÃÂÃÂÃÂRKING+BÃÂÃÂÃÂÃÂRKING+BÃÂÃÂÃÂÃÂRKING+BÃÂÃÂÃÂÃÂRKING'), ('doc3', ' MÃÂÃÂÃÂÃÂOWING+MÃÂÃÂÃÂÃÂOWING+MÃÂÃÂÃÂÃÂOWING+MÃÂÃÂÃÂÃÂOWING+MÃÂÃÂÃÂÃÂOWING+999');
SET SCHEMA='test';
PRAGMA create_fts_index('documents', 'id', 'body');
SET SCHEMA='main';
SET SCHEMA='test';
PRAGMA drop_fts_index('documents');
