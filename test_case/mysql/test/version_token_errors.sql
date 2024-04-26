
if ( !$VERSION_TOKEN ) {
  skip Locking service plugin requires the environment variable \$VERSION_TOKEN to be set (normally done by mtr);

SELECT version_tokens_set(' * = a ;
SELECT version_tokens_show();
SELECT version_tokens_delete(' * ');
SELECT version_tokens_show();
SELECT version_tokens_delete(' ;
SELECT version_tokens_show();
SELECT version_tokens_edit('=');
SELECT version_tokens_lock_shared('a',''>''%'0');
SELECT version_tokens_delete(null);
DROP FUNCTION version_tokens_set;
DROP FUNCTION version_tokens_show;
DROP FUNCTION version_tokens_edit;
DROP FUNCTION version_tokens_delete;
DROP FUNCTION version_tokens_lock_shared;
DROP FUNCTION version_tokens_lock_exclusive;
DROP FUNCTION version_tokens_unlock;
