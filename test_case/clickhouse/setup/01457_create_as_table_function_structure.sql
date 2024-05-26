SET prefer_localhost_replica = 1;
DROP DATABASE IF EXISTS test_01457;
CREATE DATABASE test_01457;
CREATE TABLE tmp (n Int8) ENGINE=Memory;
CREATE TABLE test_01457.tf_numbers (number String) AS numbers(1);
