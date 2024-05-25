PRAGMA enable_verification;
COPY (SELECT 1 as a) to '__TEST_DIR__/file_to_prevent_the_secret_dir_from_being_created.csv';
set secret_directory='__TEST_DIR__/file_to_prevent_the_secret_dir_from_being_created.csv';
CREATE SECRET my_tmp_secret (
	TYPE S3,
    SCOPE 's3://bucket1'
);
