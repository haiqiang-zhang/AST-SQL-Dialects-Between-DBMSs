
CREATE USER 'kristofer' IDENTIFIED WITH 'sha256_password';
ALTER USER 'kristofer' IDENTIFIED BY 'secret';
DROP USER 'kristofer';
CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY 'secret2';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer'@'localhost';
CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY '';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer'@'localhost';

CREATE USER 'kristofer'@'33.33.33.33' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'33.33.33.33' IDENTIFIED BY '';
DROP USER 'kristofer'@'33.33.33.33';
CREATE USER 'u1'@'localhost' IDENTIFIED WITH 'sha256_password';
ALTER USER 'u1'@'localhost' IDENTIFIED BY 'pass';
ALTER USER 'u1'@'localhost' PASSWORD EXPIRE;
SELECT USER();
ALTER USER 'u1'@'localhost' IDENTIFIED BY 'pass2';
SELECT USER();
DROP USER 'u1'@'localhost';
