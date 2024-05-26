SELECT
	pg_advisory_xact_lock(1), pg_advisory_xact_lock_shared(2),
	pg_advisory_xact_lock(1, 1), pg_advisory_xact_lock_shared(2, 2);
SELECT pg_advisory_unlock_all();
SELECT
	pg_advisory_unlock(1), pg_advisory_unlock_shared(2),
	pg_advisory_unlock(1, 1), pg_advisory_unlock_shared(2, 2);
COMMIT;
BEGIN;
ROLLBACK;
BEGIN;
SELECT
	pg_advisory_lock(1), pg_advisory_lock_shared(2),
	pg_advisory_lock(1, 1), pg_advisory_lock_shared(2, 2);
ROLLBACK;
BEGIN;
COMMIT;
