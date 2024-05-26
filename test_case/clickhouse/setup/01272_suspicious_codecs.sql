DROP TABLE IF EXISTS codecs;
CREATE TABLE codecs
(
    a UInt8 CODEC(LZ4),
    b UInt16 CODEC(ZSTD),
    c Float32 CODEC(Gorilla),
    d UInt8 CODEC(Delta, LZ4),
    e Float64 CODEC(Gorilla, ZSTD),
    f UInt32 CODEC(Delta, Delta, T64),
    g DateTime CODEC(DoubleDelta),
    h DateTime64 CODEC(DoubleDelta, LZ4),
    i String CODEC(NONE)
) ENGINE = MergeTree ORDER BY tuple();
DROP TABLE codecs;
DROP TABLE IF EXISTS codecs1;
DROP TABLE IF EXISTS codecs2;
DROP TABLE IF EXISTS codecs3;
DROP TABLE IF EXISTS codecs4;
DROP TABLE IF EXISTS codecs5;
DROP TABLE IF EXISTS codecs6;
DROP TABLE IF EXISTS codecs7;
DROP TABLE IF EXISTS codecs8;
DROP TABLE IF EXISTS codecs9;
DROP TABLE IF EXISTS codecs10;
DROP TABLE IF EXISTS codecs11;
SET allow_suspicious_codecs = 1;
CREATE TABLE codecs1 (a UInt8 CODEC(NONE, NONE)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs2 (a UInt8 CODEC(NONE, LZ4)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs3 (a UInt8 CODEC(LZ4, NONE)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs4 (a UInt8 CODEC(LZ4, LZ4)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs5 (a UInt8 CODEC(LZ4, ZSTD)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs6 (a UInt8 CODEC(Delta)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs7 (a UInt8 CODEC(Delta, Delta)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs8 (a UInt8 CODEC(LZ4, Delta)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs9 (a UInt8 CODEC(Gorilla)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs10 (a FixedString(2) CODEC(Gorilla)) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE codecs11 (a Decimal(15,5) CODEC(Gorilla)) ENGINE = MergeTree ORDER BY tuple();
SET allow_suspicious_codecs = 0;
