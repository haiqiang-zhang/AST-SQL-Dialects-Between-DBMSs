CREATE TABLE integers(i integer);
SELECT * FROM pg_attribute

query IIIIII nosort pg_attribute
SELECT * FROM pg_catalog.pg_attribute

statement ok
CREATE TABLE integers(i integer)

query III
select relname, attname, attnum from pg_attribute join pg_class on (pg_attribute.attrelid=pg_class.oid) where relname='integers' and attnum>=0;;
