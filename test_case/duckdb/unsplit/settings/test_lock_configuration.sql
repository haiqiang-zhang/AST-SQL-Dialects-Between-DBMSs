PRAGMA enable_verification;
SET memory_limit='8GB';
RESET lock_configuration;
SET lock_configuration=false;
SET memory_limit='8GB';
SET lock_configuration=true;
SELECT current_setting('lock_configuration');
SELECT current_setting('lock_configuration');
