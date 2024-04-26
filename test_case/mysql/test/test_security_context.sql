
-- Has to be loaded here since it needs to be loaded post-flush-privleges
--replace_regex /\.dll/.so/
eval INSTALL PLUGIN test_security_context SONAME '$TEST_SECURITY_CONTEXT';

SELECT PLUGIN_STATUS FROM INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME='test_security_context';

SET @@test_security_context_get_field = "user", @@test_security_context_get_value = "root";
SELECT "OK";

SET @@test_security_context_get_field = "user", @@test_security_context_get_value = "root-err";
SELECT "FAIL";

SET @@test_security_context_get_field = "host", @@test_security_context_get_value = "localhost";
SELECT "OK";

SET @@test_security_context_get_field = "ip";
SELECT "OK";

SET @@test_security_context_get_field = "priv_user", @@test_security_context_get_value = "root";
SELECT "OK";

SET @@test_security_context_get_field = "priv_host", @@test_security_context_get_value = "localhost";
SELECT "OK";

SET @@test_security_context_get_field = "sec_ctx_test";
SELECT "OK";
