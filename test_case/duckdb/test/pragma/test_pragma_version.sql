PRAGMA version;;
select * from pragma_version();;
select library_version from pragma_version();;
PRAGMA platform;;
select * from pragma_platform();;
select platform from pragma_platform();;
SELECT count(*) FROM pragma_version() WHERE library_version LIKE 'v%';;
