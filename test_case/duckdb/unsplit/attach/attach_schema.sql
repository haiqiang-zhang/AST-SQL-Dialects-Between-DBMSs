PRAGMA enable_verification;
ATTACH DATABASE ':memory:' AS new_database;;
CREATE SCHEMA new_database.s1.xxx;;
CREATE SCHEMA IF NOT EXISTS new_database.s1.xxx;;
CREATE SCHEMA new_database.s1;;
