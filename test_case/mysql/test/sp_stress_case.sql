--   usage, limitation)
--

--disable_warnings
DROP PROCEDURE IF EXISTS proc_19194_codegen;
DROP PROCEDURE IF EXISTS bug_19194_simple;
DROP PROCEDURE IF EXISTS bug_19194_searched;

CREATE PROCEDURE proc_19194_codegen(
  IN proc_name VARCHAR(50),
  IN count INTEGER,
  IN simple INTEGER,
  OUT body MEDIUMTEXT)
BEGIN
  DECLARE code MEDIUMTEXT;

  SET code = concat("CREATE PROCEDURE ", proc_name, "(i INT)\n");
  SET code = concat(code, "BEGIN\n");
  SET code = concat(code, "  DECLARE str CHAR(10);

  IF (simple)
  THEN
    SET code = concat(code, "  CASE i\n");
    SET code = concat(code, "  CASE\n");
  END IF;
  DO
    IF (simple)
    THEN
      SET code = concat(code, "    WHEN ", i, " THEN SET str=\"", i, "\";
    ELSE
      SET code = concat(code, "    WHEN i=", i, " THEN SET str=\"", i, "\";
    END IF;

    SET i = i + 1;
  END WHILE;

  SET code = concat(code, "    ELSE SET str=\"unknown\";
  SET code = concat(code, "  END CASE;
  SET code = concat(code, "  SELECT str;

  SET code = concat(code, "END\n");

  SET body = code;

set @body="";
select @body;
select @body;
let $proc_body = `select @body`;
let $proc_body = `select @body`;

DROP PROCEDURE proc_19194_codegen;
DROP PROCEDURE bug_19194_simple;
DROP PROCEDURE bug_19194_searched;
