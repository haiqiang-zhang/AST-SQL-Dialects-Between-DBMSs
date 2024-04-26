
CREATE USER 'kristofer' IDENTIFIED BY 'secret';
SELECT user FROM mysql.user ORDER BY user;
DROP USER 'kristofer';

CREATE USER 'kristofer'@'localhost' IDENTIFIED BY 'secret2';
DROP USER 'kristofer'@'localhost';

CREATE USER 'kristofer'@'localhost' IDENTIFIED BY '123';
DROP USER 'kristofer'@'localhost';

CREATE USER 'kristofer'@'33.33.33.33' IDENTIFIED BY '123';
DROP USER 'kristofer'@'33.33.33.33';
