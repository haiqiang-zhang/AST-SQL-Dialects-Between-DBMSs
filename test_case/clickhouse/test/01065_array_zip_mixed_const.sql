SELECT arrayZip([0, 1], ['hello', 'world']);
SELECT arrayZip([0, number], [toString(number), 'world']) FROM numbers(10);
