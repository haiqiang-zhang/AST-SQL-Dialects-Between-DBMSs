
CREATE PROCEDURE p_flush_status()
BEGIN
  DECLARE x INT DEFAULT 3000;
    SET x = x-1;
    FLUSH STATUS;
  END WHILE;
END |

CREATE PROCEDURE p_processlist()
BEGIN
  DECLARE x INT DEFAULT 3000;
    SET x = x-1;
    SELECT COUNT(*) INTO @a FROM information_schema.processlist;
  END WHILE;
END |

--delimiter ;
let $i = 3000;
{
  dec $i;
DROP PROCEDURE p_flush_status;
DROP PROCEDURE p_processlist;
