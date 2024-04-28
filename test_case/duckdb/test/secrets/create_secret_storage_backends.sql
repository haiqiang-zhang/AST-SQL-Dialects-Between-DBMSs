PRAGMA enable_verification;;
set allow_persistent_secrets=false;;
CREATE TEMPORARY SECRET s1 IN LOCAL_FILE ( TYPE S3 );
CREATE PERSISTENT SECRET s1 IN NON_EXISTENT_SECRET_STORAGE ( TYPE S3 );
CREATE PERSISTENT SECRET perm_s1 ( TYPE S3 );
set allow_persistent_secrets=true;;
set secret_directory='__TEST_DIR__/create_secret_storages';
CREATE PERSISTENT SECRET perm_s1 ( TYPE S3 );
CREATE SECRET perm_s2 IN LOCAL_FILE ( TYPE S3 );
CREATE TEMPORARY SECRET temp_s1 ( TYPE s3 );;
CREATE SECRET temp_s2 ( TYPE s3 );;
set default_secret_storage='currently-non-existent';
set secret_directory='__TEST_DIR__/create_secret_storages';
CREATE PERSISTENT SECRET s1 ( TYPE S3 );
CREATE PERSISTENT SECRET s1 IN LOCAL_FILE ( TYPE S3 );
set secret_directory='__TEST_DIR__/create_secret_storages';
reset default_secret_storage;
CREATE PERSISTENT SECRET s2 ( TYPE S3 );
DROP SECRET perm_s1;;
DROP SECRET perm_s2;;
SELECT * EXCLUDE (secret_string) FROM duckdb_secrets() ORDER BY name;
SELECT * EXCLUDE (secret_string) FROM duckdb_secrets() ORDER BY name;
