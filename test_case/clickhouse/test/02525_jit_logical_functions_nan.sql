SELECT NOT NOT cos(MAX(pow(1523598955, 763027371))) FROM numbers(1) SETTINGS compile_expressions = 0;
SELECT not(not(materialize(nan))) FROM numbers(1) SETTINGS compile_expressions = 0;
