PRAGMA enable_verification;
SELECT host(INET '::ffff:127.0.0.1/17');
SELECT host('::ffff:127.0.0.1/17');
SELECT family('::ffff:127.0.0.1/17');
SELECT INET '::ffff:127.0.0.255' - 32;
SELECT INET '::ffff:127.0.0.31' - 32;
SELECT INET '::ffff:127.0.0.31' - -32;
SELECT INET '::ffff:127.0.0.31' + 32;
