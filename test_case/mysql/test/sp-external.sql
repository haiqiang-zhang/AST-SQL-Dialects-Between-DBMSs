
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE SQL
  BEGIN RETURN a-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_name = "foo" //
DROP FUNCTION foo//

--echo -- SQL is default
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_name = "foo" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION JAVASCRIPT(x INTEGER) RETURNS INTEGER DETERMINISTIC
LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT JAVASCRIPT(2)//
DROP FUNCTION JAVASCRIPT//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE PYTHON
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE RUBY
AS $$
  x-1
$$
//
SHOW CREATE FUNCTION foo//
--replace_column 6 <modified> 7 <created>
SHOW FUNCTION STATUS WHERE Name = 'foo'//
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo -- Test lower-case
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE javascript
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo -- Test mixed-case
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE jAvaScRIpt
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo -- Any valid identifier can be used for language name
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE JAVA1
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE $NOLANG
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC
LANGUAGE $$JAVASCRIPT
AS $$
  return x-1;
//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE 123j
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE __
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC
LANGUAGE "JAVASCRIPT"
AS $$
  return x-1;
//


--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC
LANGUAGE 'JAVASCRIPT'
AS $$
  return x-1;
//


--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE " "
AS $$
  return x-1;
//


--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE J?
AS $$
  return x-1;
//


--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC
LANGUAGE \JAVASCRIPT
AS $$
  return x-1;
//


--echo -- An identifier may not consist solely of digits
--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE 123
AS $$
  return x-1;
//


--echo -- MySQL allows multiple clauses for the same characteristics
--echo -- (This is not according to SQL standard). Last one will take effect.
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
LANGUAGE JAVASCRIPT DETERMINISTIC LANGUAGE SQL
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE SQL DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo -- Multiple languages in one clause is not allowed
--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE SQL DETERMINISTIC LANGUAGE JAVASCRIPT PYTHON
AS $$
  return x-1;
//


--echo Check "weird" white space before and after JAVASCRIPT.
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE
JAVASCRIPT

  AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE	
	 JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE	  	 JAVASCRIPT  DETERMINISTIC	
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE
-- Comment
JAVASCRIPT
-- Comment
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo The language will here be interpreted to be BEGIN
--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE
BEGIN RETURN a-1;
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
LANGUAGE SQL DETERMINISTIC LANGUAGE
BEGIN RETURN a-1;
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE
BEGIN a-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE
AS $$
  return x-1;
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
LANGUAGE JAVASCRIPT DETERMINISTIC LANGUAGE
AS $$
  return x-1;
//

--echo --Combinations with other characteristics
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC NO SQL
LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//


CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC NO SQL
LANGUAGE SQL
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE SQL NO SQL
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE JAVASCRIPT
CONTAINS SQL
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//


CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC READS SQL DATA
LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//


CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE JAVASCRIPT
MODIFIES SQL DATA
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE SQL
CONTAINS SQL
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC READS SQL DATA
LANGUAGE SQL
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE SQL
MODIFIES SQL DATA
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER NOT DETERMINISTIC LANGUAGE SQL
  BEGIN RETURN a-1;
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER NOT DETERMINISTIC
LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo -- This is not SQL
--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE SQL
AS $$ return a-1;
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
BEGIN RETURN a-1;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_name = "bar" //
DROP PROCEDURE bar//

--echo -- SQL is default
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

--echo -- Currently, no other language than SQL is supported
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_name = "bar" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP PROCEDURE bar//

CREATE PROCEDURE JAVASCRIPT(a INTEGER) DETERMINISTIC
LANGUAGE JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL JAVASCRIPT(2)//
DROP procedure JAVASCRIPT//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE PYTHON
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE RUBY
AS $$ b = a $$ //
SHOW CREATE procedure bar//
--replace_column 6 <modified> 7 <created>
SHOW PROCEDURE STATUS WHERE Name = 'bar'//
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo -- Test lower-case
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE javascript
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo -- Test mixed-case
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE jAvaScRIpt
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo -- Any valid identifier can be used for language name
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE JAVA1
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE $NOLANG
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE $$JAVASCRIPT
AS $$ let b = a;

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE 123j
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE __
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE "JAVASCRIPT"
AS $$ let b = a;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE 'JAVASCRIPT'
AS $$ let b = a;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE " "
AS $$ let b = a;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE J?
AS $$ let b = a;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE \JAVASCRIPT
AS $$ let b = a;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE 123
AS $$ let b = a;
CREATE PROCEDURE bar(a INTEGER)
LANGUAGE JAVASCRIPT DETERMINISTIC LANGUAGE SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER)
LANGUAGE SQL DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo -- Multiple languages in one clause is not allowed
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
LANGUAGE SQL DETERMINISTIC LANGUAGE JAVASCRIPT PYTHON
AS $$ b = a $$ //

--echo Check "weird" white space before and after JAVASCRIPT.
CREATE PROCEDURE bar(a INTEGER)
LANGUAGE
JAVASCRIPT

AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
LANGUAGE	
	 JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
LANGUAGE	  	 JAVASCRIPT  DETERMINISTIC	
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
LANGUAGE
-- Comment
JAVASCRIPT
-- Comment
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo The language will here be interpreted to be BEGIN
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE
BEGIN DECLARE b INTEGER DEFAULT a;
CREATE PROCEDURE bar(a INTEGER)
LANGUAGE SQL DETERMINISTIC LANGUAGE
BEGIN DECLARE b INTEGER DEFAULT a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE
BEGIN a-1;
CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC NO SQL
LANGUAGE JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC NO SQL
LANGUAGE SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE SQL NO SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE JAVASCRIPT
CONTAINS SQL
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC READS SQL DATA
LANGUAGE JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE JAVASCRIPT
MODIFIES SQL DATA
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE SQL
CONTAINS SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC READS SQL DATA
LANGUAGE SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER) DETERMINISTIC LANGUAGE SQL
MODIFIES SQL DATA
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER) NOT DETERMINISTIC LANGUAGE SQL
  BEGIN DECLARE b INTEGER DEFAULT a;
DROP PROCEDURE bar//

CREATE PROCEDURE bar(a INTEGER) NOT DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$ let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo -- This is not SQL
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
LANGUAGE SQL DETERMINISTIC LANGUAGE SQL
$$ let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
BEGIN DECLARE b INTEGER DEFAULT a;

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE SQL
BEGIN DECLARE b INTEGER DEFAULT a;
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER DETERMINISTIC LANGUAGE SQL
  BEGIN RETURN a-1;
ALTER FUNCTION foo LANGUAGE JAVASCRIPT //
SHOW CREATE FUNCTION foo//
ALTER FUNCTION foo LANGUAGE SQL NO SQL //
SHOW CREATE FUNCTION foo//
--error ER_PARSE_ERROR
ALTER FUNCTION foo LANGUAGE NO SQL //
DROP FUNCTION foo //

--error ER_SP_NO_ALTER_LANGUAGE
ALTER PROCEDURE bar LANGUAGE JAVASCRIPT //
ALTER PROCEDURE bar LANGUAGE SQL NO SQL //
SHOW CREATE PROCEDURE bar//
--error ER_PARSE_ERROR
ALTER PROCEDURE bar LANGUAGE NO SQL //
DROP PROCEDURE bar //

--echo --
--echo -- Tests for inline code in external language
--echo --
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS 'return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS "return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS '
  return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
"
   return x-1;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo Routine body must come after characteristics
--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
AS $$
  return x-1;
//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
'
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$coDE$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$CODE$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$tag$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$TAG$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$NULL$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$abdc_1234$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$_a$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$_$
  return "$$" + a + "$$";
$_$
//
SHOW CREATE FUNCTION foo//
--replace_column 6 <modified> 7 <created>
SHOW FUNCTION STATUS WHERE Name = 'foo'//
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$0$
  return "$$" + a + "$$";
$0$
//
SHOW CREATE FUNCTION foo//
--replace_column 6 <modified> 7 <created>
SHOW FUNCTION STATUS WHERE Name = 'foo'//
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$100$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$12345678901234$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$1234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$¡$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$1234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM¡™£¢∞§¶•ªº–≠œ∑´®†¥¨ˆøπ“‘«åß∂ƒ©˙∆˚¬…æΩ≈ç√∫µ≤≥÷⁄€‹›ﬁﬂ‡°·‚—±ÅÍÎÏ˝ÓÔÒÚÆ¸˛Ç◊ıÂ¯˘¿$
  return "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS	      $$
  const $x = 3;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  const x$$ = 3;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
$$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE 'return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE return x-1 //

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC AS LANGUAGE JAVASCRIPT
"return x-1;
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
$code$
  return "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $
  return x-1;
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  return "$code$" + a + "$code$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return x-1;
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  return "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$Code$
  return "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$CodE$
  return "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS	      $$
  const $x = 3;
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  const x$$ = 3;
//

-- Tag differs in last char
--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$1234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM™∞•–≠∑†π“‘∂ƒ˙∆˚…Ω≈√∫≤≥⁄€‹›ﬁﬂ‡‚—˝˛◊ı˘$
  return "$$" + a + "$$";
//

--echo Check cases with invalid dollar tags
--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $+a$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a-$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a(b$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a~b$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $ $
  return x-1;
$ $ //

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $ $
  return x-1;
$ $ //

--error ER_PARSE_ERROR
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $I'm$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $'Hi'$
  return x-1;
CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a"b"$
  return x-1;
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return "∂" + a + "$∂$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  return "∂" + a + "$∂$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  return "∂" + a + "$∂$$∂";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$∂
  return "∂" + a + "$∂$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo Test multi-byte characters in quote tags
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $∂$
  return "∂" + a + "∂$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $co∂e$
  return "∂" + a + "$∂$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

-- The 4-byte utf8mb3 characters below may not be correctly displayed in an editor
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀$
  return "😀$😔" + a + "😀$😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀😔$
  return "😀$😔" + a + "😀$😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $x😀$
  return "$x😀😔" + a + "$x😀😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀x$
  return "$😀x😔$" + a + "$😀😔x$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $x😀y$
  return "$x😀😔y$" + a + "$x😀y😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $x😀y😔$
  return "😀😔$" + a + "😀$😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀😔$
  return "😀$😔" + a + "😀$😔$";
//

--echo -- Escape sequences is not supported in dollar quoted strings
--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  return "\$$" + a + "\$code$";
//

--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  return "\$$" + a + "\$code$";
//


--echo -- Check some variants that should give external parse error
--echo -- if the language is supported
CREATE FUNCTION foo(x INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$ rtrn "$$" + x + "$foo$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

CREATE FUNCTION foo(x INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  const $x = x,
  const $y = 1
  return $x + $y;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
SELECT foo(2)//
DROP FUNCTION foo//

--echo -- Multiple occurrences of routine body is not allowed
--error ER_PARSE_ERROR
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS 'return "$$" + a + "$foo$";
CREATE FUNCTION foo(a INTEGER) RETURNS VARCHAR(20)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$ return "$$" + a + "$foo$";
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$ return a-1;
CREATE FUNCTION foo(a INTEGER) RETURNS INTEGER
DETERMINISTIC LANGUAGE SQL
AS $$ return a-1;
CREATE FUNCTION foo() RETURNS INTEGER
DETERMINISTIC LANGUAGE JAVASCRIPT//

--echo -- Repeat test cases for procedures
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS 'let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS "let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS '
  let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
"
   let b = a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo Routine body must come after characteristics
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
AS $$
  let b = a;
//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
'
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$coDE$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$CODE$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$tag$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$TAG$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$NULL$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$abdc_1234$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$_a$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$_$
  let b = "$$" + a + "$$";
$_$
//
SHOW CREATE procedure bar//
--replace_column 6 <modified> 7 <created>
SHOW PROCEDURE STATUS WHERE Name = 'bar'//
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$0$
  let b = "$$" + a + "$$";
$0$
//
SHOW CREATE procedure bar//
--replace_column 6 <modified> 7 <created>
SHOW PROCEDURE STATUS WHERE Name = 'bar'//
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$100$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$12345678901234$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$1234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$¡$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$1234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM¡™£¢∞§¶•ªº–≠œ∑´®†¥¨ˆøπ“‘«åß∂ƒ©˙∆˚¬…æΩ≈ç√∫µ≤≥÷⁄€‹›ﬁﬂ‡°·‚—±ÅÍÎÏ˝ÓÔÒÚÆ¸˛Ç◊ıÂ¯˘¿$
  let b = "$$" + a + "$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS	      $$
  const $x = 3;
  let b = $x + $y$ + a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  const x$$ = 3;
  let b = x$$ + $y$$z + a;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
$$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE 'let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE let b = a //

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC AS LANGUAGE JAVASCRIPT
"let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
$code$
  let b = "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  let b = "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  let b = "$code$" + a + "$code$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  let b = "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$Code$
  let b = "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$CodE$
  let b = "$$" + a + "$$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS	      $$
  const $x = 3;
  let b = $x + $y$ + a;
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$code$
  const x$$ = 3;
  let b = x$$ + $y$$z + a;
//

-- Tag differs in last char
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS
$1234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM™∞•–≠∑†π“‘∂ƒ˙∆˚…Ω≈√∫≤≥⁄€‹›ﬁﬂ‡‚—˝˛◊ı˘$
  let b = "$$" + a + "$$";
//

--echo Check cases with invalid dollar tags
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $+a$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a-$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a(b$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a~b$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $ $
  let b = a;
$ $ //

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $ $
  let b = a;
$ $ //

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $I'm$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $'Hi'$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $a"b"$
  let b = a;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  let b = "∂" + a + "$∂$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  let b = "∂" + a + "$∂$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  let b = "∂" + a + "$∂$$∂";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$∂
  let b = "∂" + a + "$∂$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo Test multi-byte characters in quote tags
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $∂$
  let b = "∂" + a + "∂$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $co∂e$
  let b = "∂" + a + "$∂$$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

-- The 4-byte utf8mb3 characters below may not be correctly displayed in an editor
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀$
  let b = "😀$😔" + a + "😀$😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀😔$
  let b = "😀$😔" + a + "😀$😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $x😀$
  let b = "$x😀😔" + a + "$x😀😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀x$
  let b = "$😀x😔$" + a + "$😀😔x$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $x😀y$
  let b = "$x😀😔y$" + a + "$x😀y😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $x😀y😔$
  let b = "😀😔$" + a + "😀$😔$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $😀😔$
  let b = "😀$😔" + a + "😀$😔$";
//

--echo -- Escape sequences is not supported in dollar quoted strings
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  let b = "\$$" + a + "\$code$";
//

--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$
  let b = "\$$" + a + "\$code$";
//


--echo -- Check some variants that should give external parse error
--echo -- if the language is supported
CREATE PROCEDURE bar(x INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$ let b := "$$" + x + "$foo$";
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

CREATE PROCEDURE bar(x INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$
  const $x = x,
  const $y = 1
  let b = $x + $y;
SELECT routine_name, routine_type, data_type, routine_body,
       external_name, external_language, parameter_style, routine_definition
FROM information_schema.routines
WHERE routine_schema = "test" //
--error ER_LANGUAGE_COMPONENT_NOT_AVAILABLE
CALL bar(2)//
DROP procedure bar//

--echo -- Multiple occurrences of routine body is not allowed
--error ER_PARSE_ERROR
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS 'let b = "$$" + a + "$foo$";
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $code$ let b = "$$" + a + "$foo$";
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE JAVASCRIPT
AS $$ let b = a-1;
CREATE PROCEDURE bar(a INTEGER)
DETERMINISTIC LANGUAGE SQL
AS $$ let b = a-1;
CREATE PROCEDURE bar()
DETERMINISTIC LANGUAGE JAVASCRIPT//

--echo -- Check that dollar quotes can not be used in other context
--error ER_PARSE_ERROR
CREATE FUNCTION $$foo(x INTEGER) INTEGER DETERMINISTIC
LANGUAGE JAVASCRIPT AS $$ let b = x-1;
CREATE PROCEDURE $$bar(a INTEGER) DETERMINISTIC
LANGUAGE JAVASCRIPT AS $$ let b = a;
SELECT $$Hello world!$$;
SELECT $hi$Hello world!$hi$;
SELECT 1 AS $hi;
SELECT 1 AS h$i;
SELECT 1 AS h$$i;
SELECT 1 AS h$i$;
SELECT 1 AS $$;
SELECT 1 AS $hi$;
SELECT 1 AS $h$i;
SELECT 1 AS `$$`;
SELECT 1 AS `$hi$`;
SELECT 1 AS `$h$i`;
