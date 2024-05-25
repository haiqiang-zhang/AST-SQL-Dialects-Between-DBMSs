SELECT serialization_kind FROM system.parts_columns
WHERE table = 't_sparse_s3' AND active AND column = 's'
AND database = currentDatabase();
SET max_threads = 1;
