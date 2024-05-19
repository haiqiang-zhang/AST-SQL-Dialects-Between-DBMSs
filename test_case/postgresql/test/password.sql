
SET password_encryption = 'novalue'; 
SET password_encryption = true; 
SET password_encryption = 'md5'; 
SET password_encryption = 'scram-sha-256'; 

SET password_encryption = 'md5';
CREATE ROLE regress_passwd1;
ALTER ROLE regress_passwd1 PASSWORD 'role_pwd1';
CREATE ROLE regress_passwd2;
ALTER ROLE regress_passwd2 PASSWORD 'role_pwd2';
SET password_encryption = 'scram-sha-256';
CREATE ROLE regress_passwd3 PASSWORD 'role_pwd3';
CREATE ROLE regress_passwd4 PASSWORD NULL;

SELECT rolname, regexp_replace(rolpassword, '(SCRAM-SHA-256)\$(\d+):([a-zA-Z0-9+/=]+)\$([a-zA-Z0-9+=/]+):([a-zA-Z0-9+/=]+)', '\1$\2:<salt>$<storedkey>:<serverkey>') as rolpassword_masked
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd%'
    ORDER BY rolname, rolpassword;

ALTER ROLE regress_passwd2 RENAME TO regress_passwd2_new;
SELECT rolname, rolpassword
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd2_new'
    ORDER BY rolname, rolpassword;
ALTER ROLE regress_passwd2_new RENAME TO regress_passwd2;

SET password_encryption = 'md5';

ALTER ROLE regress_passwd2 PASSWORD 'foo';
ALTER ROLE regress_passwd1 PASSWORD 'md5cd3578025fe2c3d7ed1b9a9b26238b70';
ALTER ROLE regress_passwd3 PASSWORD 'SCRAM-SHA-256$4096:VLK4RMaQLCvNtQ==$6YtlR4t69SguDiwFvbVgVZtuz6gpJQQqUMZ7IQJK5yI=:ps75jrHeYU4lXCcXI4O8oIdJ3eO8o2jirjruw9phBTo=';

SET password_encryption = 'scram-sha-256';
ALTER ROLE  regress_passwd4 PASSWORD 'foo';
CREATE ROLE regress_passwd5 PASSWORD 'md5e73a4b11df52a6068f8b39f90be36023';

CREATE ROLE regress_passwd6 PASSWORD 'SCRAM-SHA-256$1234';
CREATE ROLE regress_passwd7 PASSWORD 'md5012345678901234567890123456789zz';
CREATE ROLE regress_passwd8 PASSWORD 'md501234567890123456789012345678901zz';

SET scram_iterations = 1024;
CREATE ROLE regress_passwd9 PASSWORD 'alterediterationcount';

SELECT rolname, regexp_replace(rolpassword, '(SCRAM-SHA-256)\$(\d+):([a-zA-Z0-9+/=]+)\$([a-zA-Z0-9+=/]+):([a-zA-Z0-9+/=]+)', '\1$\2:<salt>$<storedkey>:<serverkey>') as rolpassword_masked
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd%'
    ORDER BY rolname, rolpassword;

CREATE ROLE regress_passwd_empty PASSWORD '';
ALTER ROLE regress_passwd_empty PASSWORD 'md585939a5ce845f1a1b620742e3c659e0a';
ALTER ROLE regress_passwd_empty PASSWORD 'SCRAM-SHA-256$4096:hpFyHTUsSWcR7O9P$LgZFIt6Oqdo27ZFKbZ2nV+vtnYM995pDh9ca6WSi120=:qVV5NeluNfUPkwm7Vqat25RjSPLkGeoZBQs6wVv+um4=';
SELECT rolpassword FROM pg_authid WHERE rolname='regress_passwd_empty';

CREATE ROLE regress_passwd_sha_len0 PASSWORD 'SCRAM-SHA-256$4096:A6xHKoH/494E941doaPOYg==$Ky+A30sewHIH3VHQLRN9vYsuzlgNyGNKCh37dy96Rqw=:COPdlNiIkrsacU5QoxydEuOH6e/KfiipeETb/bPw8ZI=';
CREATE ROLE regress_passwd_sha_len1 PASSWORD 'SCRAM-SHA-256$4096:A6xHKoH/494E941doaPOYg==$Ky+A30sewHIH3VHQLRN9vYsuzlgNyGNKCh37dy96RqwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=:COPdlNiIkrsacU5QoxydEuOH6e/KfiipeETb/bPw8ZI=';
CREATE ROLE regress_passwd_sha_len2 PASSWORD 'SCRAM-SHA-256$4096:A6xHKoH/494E941doaPOYg==$Ky+A30sewHIH3VHQLRN9vYsuzlgNyGNKCh37dy96Rqw=:COPdlNiIkrsacU5QoxydEuOH6e/KfiipeETb/bPw8ZIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=';

SELECT rolname, rolpassword not like '%A6xHKoH/494E941doaPOYg==%' as is_rolpassword_rehashed
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd_sha_len%'
    ORDER BY rolname;

DROP ROLE regress_passwd1;
DROP ROLE regress_passwd2;
DROP ROLE regress_passwd3;
DROP ROLE regress_passwd4;
DROP ROLE regress_passwd5;
DROP ROLE regress_passwd6;
DROP ROLE regress_passwd7;
DROP ROLE regress_passwd8;
DROP ROLE regress_passwd9;
DROP ROLE regress_passwd_empty;
DROP ROLE regress_passwd_sha_len0;
DROP ROLE regress_passwd_sha_len1;
DROP ROLE regress_passwd_sha_len2;

SELECT rolname, rolpassword
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd%'
    ORDER BY rolname, rolpassword;
