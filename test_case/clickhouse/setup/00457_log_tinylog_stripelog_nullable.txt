DROP TABLE IF EXISTS nullable_00457;
CREATE TABLE nullable_00457 (s String, ns Nullable(String), narr Array(Nullable(UInt64))) ENGINE = Log;
INSERT INTO nullable_00457 SELECT toString(number), number % 3 = 1 ? toString(number) : NULL, arrayMap(x -> x % 2 = 1 ? x : NULL, range(number)) FROM system.numbers LIMIT 10;
