PRAGMA disable_checkpoint_on_shutdown;
PRAGMA wal_autocheckpoint='1TB';
CREATE TABLE vals(i INTEGER);
INSERT INTO vals SELECT CASE WHEN i % 2 = 0 THEN NULL ELSE i END FROM range(200000) tbl(i);
