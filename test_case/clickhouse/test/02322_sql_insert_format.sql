set schema_inference_use_cache_for_file=0;
select * from file(02322_data.sql, 'MySQLDump');
select * from file(02322_data.sql, 'MySQLDump');