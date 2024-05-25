SELECT count() FROM (SELECT DISTINCT nowInBlock(), nowInBlock('Pacific/Pitcairn') FROM system.numbers LIMIT 2);
SELECT nowInBlock(NULL) IS NULL;
