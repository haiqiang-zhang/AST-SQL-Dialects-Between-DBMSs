SELECT groupArrayInsertAt(toString(number), number * 2) FROM (SELECT * FROM system.numbers LIMIT 10);
SELECT groupArrayInsertAt('-')(toString(number), number * 2) FROM (SELECT * FROM system.numbers LIMIT 10);
SELECT groupArrayInsertAt([123])(range(number), number * 2) FROM (SELECT * FROM system.numbers LIMIT 10);
SELECT number, groupArrayInsertAt(number, number) FROM (SELECT * FROM system.numbers LIMIT 10) GROUP BY number ORDER BY number;
SELECT k, groupArrayInsertAt('-', 10)(toString(x), x) FROM (SELECT number AS k, number AS x FROM system.numbers LIMIT 11) GROUP BY k ORDER BY k;
