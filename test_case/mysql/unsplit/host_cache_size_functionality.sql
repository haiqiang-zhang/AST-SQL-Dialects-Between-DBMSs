SELECT COUNT(@@GLOBAL.Host_Cache_Size);
select @@global.Host_Cache_Size=@Default_host_cache_size;
SELECT @@GLOBAL.Host_Cache_Size;
select @@global.Host_Cache_Size=@Default_host_cache_size;
SELECT COUNT(@@GLOBAL.Host_Cache_Size);
select @@global.Host_Cache_Size=@Default_host_cache_size;
SELECT @@GLOBAL.Host_Cache_Size = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='Host_Cache_Size';
SELECT COUNT(@@GLOBAL.Host_Cache_Size);
SELECT COUNT(VARIABLE_VALUE)
FROM performance_schema.global_variables 
WHERE VARIABLE_NAME='Host_Cache_Size';
SELECT @@Host_Cache_Size = @@GLOBAL.Host_Cache_Size;
SELECT COUNT(@@GLOBAL.Host_Cache_Size);
