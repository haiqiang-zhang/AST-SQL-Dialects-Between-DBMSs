select dictGetString({CLICKHOUSE_DATABASE:String} || '.restricted_dict', 'value', toUInt64(1));
select 'Ok.';
DROP DICTIONARY IF EXISTS {CLICKHOUSE_DATABASE:Identifier}.restricted_dict;