
CREATE USER b30896461_test1@localhost;
CREATE USER b30896461_test2@localhost;

CREATE SCHEMA `B30896461`;

CREATE FUNCTION `B30896461`.`testFn`() RETURNS INTEGER DETERMINISTIC RETURN 1;
SELECT `B30896461`.`testFn`();
SELECT `B30896461`.`testfn`();
let $lctn= query_get_value(SHOW VARIABLES LIKE 'lower_case_table_names', Value, 1);
{
  -- Must pass in casemode 0 and 2
  echo -- testing database casemode;
  SELECT `b30896461`.`testfn`();
{
  -- Must fail in casemode 1
  echo -- testing database casemode;
  SELECT `b30896461`.`testfn`();
SELECT `B30896461`.`testFn`();
SELECT `B30896461`.`testfn`();
let $lctn= query_get_value(SHOW VARIABLES LIKE 'lower_case_table_names', Value, 1);
{
  -- Must pass in casemode 0 and 2
  echo -- testing database casemode;
  SELECT `b30896461`.`testfn`();
{
  -- Must fail in casemode 1
  echo -- testing database casemode;
  SELECT `b30896461`.`testfn`();

DROP USER b30896461_test1@localhost, b30896461_test2@localhost;
DROP SCHEMA `B30896461`;
