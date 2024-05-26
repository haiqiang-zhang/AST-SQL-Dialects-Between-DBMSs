ATTACH '__TEST_DIR__/persistent_attach.db';
INSERT INTO persistent_attach.integers VALUES (42);
DETACH persistent_attach;
ATTACH '__TEST_DIR__/persistent_attach.db';
