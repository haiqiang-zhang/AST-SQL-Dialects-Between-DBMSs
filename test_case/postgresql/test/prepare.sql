SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements;
PREPARE q1 AS SELECT 1 AS a;
EXECUTE q1;
SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements;
DEALLOCATE q1;
PREPARE q1 AS SELECT 2;
EXECUTE q1;
PREPARE q2 AS SELECT 2 AS b;
SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements;
DEALLOCATE PREPARE q1;
SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements;
DEALLOCATE PREPARE q2;
SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements;
PREPARE q2(text) AS
	SELECT datname, datistemplate, datallowconn
	FROM pg_database WHERE datname = $1;
EXECUTE q2('postgres');
SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements
    ORDER BY name;
DEALLOCATE ALL;
SELECT name, statement, parameter_types FROM pg_prepared_statements
    ORDER BY name;
