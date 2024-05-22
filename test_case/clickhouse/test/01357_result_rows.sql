set log_queries = 1;
select count() > 0 from system.settings;
system flush logs;
