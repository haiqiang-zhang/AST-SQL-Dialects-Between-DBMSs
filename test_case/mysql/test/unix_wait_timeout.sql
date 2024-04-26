SET @is_old_connection = 1;
SELECT @is_old_connection;

LET $ID= `SELECT connection_id()`;
SET @@SESSION.wait_timeout = 2;
let $wait_condition=
  SELECT COUNT(*) = 0 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE ID = $ID;
SELECT "Unix domain socket will hit wait_timeout with reconnect, still succeed as reconnect is enabled.";
SELECT @is_old_connection;
