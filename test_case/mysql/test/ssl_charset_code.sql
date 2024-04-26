--                                                                              #
-- Bug #29916390: FR: REMOVE ASSERTION FAILED: CHARSET_CODE == SSL_CHARSET_CODE #
--###############################################################################

-- the below is used to skip the test if the CLIENT is debug build
--source include/mysql_have_debug.inc


-- prepare -create user to connect
CREATE USER 'ssl_charset_code_user'@'%' REQUIRE SSL;

-- step 1
echo "Step 1 connect correctly.";

-- step 2
echo "Step 2 connect with mismatched character set code.";

-- Cleanup
DROP USER 'ssl_charset_code_user'@'%';
