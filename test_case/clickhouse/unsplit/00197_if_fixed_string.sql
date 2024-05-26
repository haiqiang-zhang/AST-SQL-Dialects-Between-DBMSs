SELECT number % 2 ? toString(number) : toString(-number) FROM system.numbers LIMIT 10;
SELECT number % 2 ? toFixedString(toString(number), 2) : toFixedString(toString(-number), 2) FROM system.numbers LIMIT 10;
SELECT number % 2 ? toFixedString(toString(number), 2) : toString(-number) FROM system.numbers LIMIT 10;
SELECT number % 2 ? 'Hello' : 'Goodbye' FROM system.numbers LIMIT 10;
