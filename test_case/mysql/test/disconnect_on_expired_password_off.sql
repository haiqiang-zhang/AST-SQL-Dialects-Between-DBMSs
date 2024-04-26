
--# WL6587 Test --disconnect-on-expired-password=off

SHOW VARIABLES LIKE 'disconnect_on_expired_password';

CREATE USER 'bernt';
ALTER USER 'bernt' IDENTIFIED BY 'secret';

ALTER USER 'bernt' PASSWORD EXPIRE;

DROP USER 'bernt';

CREATE USER 'bernt';
ALTER USER 'bernt' IDENTIFIED BY 'secret';
ALTER USER 'bernt' PASSWORD EXPIRE;
SELECT 1;
DROP USER 'bernt';

CREATE USER 'bernt';
ALTER USER 'bernt' IDENTIFIED BY 'secret';
ALTER USER 'bernt' PASSWORD EXPIRE;

DROP USER 'bernt';
