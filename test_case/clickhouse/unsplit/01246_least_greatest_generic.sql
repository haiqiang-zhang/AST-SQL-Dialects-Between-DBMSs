SELECT least('hello', 'world');
SELECT greatest('hello', 'world');
SELECT LEAST(-1, 18446744073709551615) x, toTypeName(x);
SELECT LEAST(-1., 18446744073709551615.);
SELECT GREATEST([NULL], [0]);
