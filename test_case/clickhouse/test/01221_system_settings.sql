select * from system.settings where name = 'send_timeout';
select * from system.merge_tree_settings order by length(description) limit 1;
with [
    'Seconds',
    'Bool',
    'Int64',
    'String',
    'Float',
    'UInt64',
    'MaxThreads'
] as types select hasAll(arrayDistinct(groupArray(type)), types) from system.merge_tree_settings;