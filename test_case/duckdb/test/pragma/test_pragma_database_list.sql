PRAGMA database_list();
PRAGMA database_list

query III nosort dblist
SELECT * FROM pragma_database_list

query II
SELECT name, file FROM pragma_database_list;
