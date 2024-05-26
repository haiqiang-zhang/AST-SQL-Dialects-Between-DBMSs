SELECT LENGTH(VARIABLE_VALUE) > 0 FROM performance_schema.session_status
  WHERE VARIABLE_NAME='Ssl_cipher';
SELECT LENGTH(VARIABLE_VALUE) > 0 FROM performance_schema.session_status
  WHERE VARIABLE_NAME='Ssl_cipher';
SELECT @must_be_present;
SELECT COUNT(*) FROM performance_schema.session_status
WHERE VARIABLE_NAME = 'Current_tls_ca' AND VARIABLE_VALUE = @orig_ssl_ca;
SELECT @@global.ssl_ca;
SELECT VARIABLE_NAME FROM performance_schema.session_status WHERE
  VARIABLE_NAME IN
  ('Current_tls_ca', 'Current_tls_capath', 'Current_tls_cert',
   'Current_tls_key', 'Current_tls_version', 'Current_tls_cipher',
   'Current_tls_ciphersuites', 'Current_tls_crl', 'Current_tls_crlpath') AND
  VARIABLE_VALUE != 'gizmo'
  ORDER BY VARIABLE_NAME;
SELECT @@global.mysqlx_ssl_ca = @orig_mysqlx_ssl_ca,
       @@global.mysqlx_ssl_cert = @orig_mysqlx_ssl_cert,
       @@global.mysqlx_ssl_key = @orig_mysqlx_ssl_key;
