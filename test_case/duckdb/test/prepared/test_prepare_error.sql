PREPARE v1 AS SELECT ?::VARCHAR::INT;
EXECUTE v1('hello');
EXECUTE v1('3');
