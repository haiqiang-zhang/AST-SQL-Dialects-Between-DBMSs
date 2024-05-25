select length(hex(generateUUIDv4()));
with generateUUIDv4() as uuid,
    replace(toString(uuid), '-', '') as str1,
    lower(hex(uuid)) as str2
select str1 = str2;
select lower(hex(toUUID('00000000-80e7-46f8-0000-9d773a2fd319')));
select length(bin(generateUUIDv4()));
select bin(toUUID('00000000-80e7-46f8-0000-9d773a2fd319'));
