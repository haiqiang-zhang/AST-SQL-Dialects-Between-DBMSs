DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1() SELECT 1;

DROP PROCEDURE p1;
DROP DATABASE bug58090;

CREATE USER 'user_with_length_32_abcdefghijkl'@'localhost';

DROP USER 'user_with_length_32_abcdefghijkl'@'localhost';
