SELECT number % 2 ? 'hello' : 'world' FROM system.numbers LIMIT 5;
SELECT number % 2 ? materialize('hello') : 'world' FROM system.numbers LIMIT 5;
SELECT number % 2 ? toFixedString('hello', 5) : 'world' FROM system.numbers LIMIT 5;
SELECT number % 2 ? toFixedString('hello', 5) : materialize('world') FROM system.numbers LIMIT 5;
