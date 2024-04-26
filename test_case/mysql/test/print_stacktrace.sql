SET GLOBAL debug='+d,print_stacktrace';
SELECT CONCAT("Please inspect mysqld server log,",
              " look for print_stacktrace.\n") as Hello;
SET GLOBAL debug='-d,print_stacktrace';
