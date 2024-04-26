
let $crllen=`select length(trim(coalesce(@@ssl_crl, ''))) + length(trim(coalesce(@@ssl_crlpath, '')))`;
{
  skip Needs OpenSSL;
