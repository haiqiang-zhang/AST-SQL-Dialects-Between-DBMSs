
let $crllen=`select length(trim(coalesce(@@ssl_crl, ''))) + length(trim(coalesce(@@ssl_crlpath, '')))`;
{
  skip Needs OpenSSL;

let $ssl_base = --ssl-ca=$MYSQL_TEST_DIR/std_data/crl-ca-cert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/crl-server-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/crl-server-cert.pem;
let $ssl_crl = $ssl_base --ssl-crl=$MYSQL_TEST_DIR/std_data/crl-client-revoked.crl;
let $ssl_crlpath = $ssl_base --ssl-crlpath=$MYSQL_TEST_DIR/std_data/crldir;
let $admin_prefix = --no-defaults;
let $admin_suffix = --default-character-set=latin1 -S $MASTER_MYSOCK -P $MASTER_MYPORT -u root --password= ping;
