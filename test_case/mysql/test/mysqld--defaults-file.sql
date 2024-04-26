
-- All these tests refer to configuration files that do not exist

--error 1
exec $MYSQLD --defaults-file=/path/with/no/extension --print-defaults 2>$MDF_LOG;
  use strict;
  my $mysqld_log= $ENV{'MDF_LOG'};
    if (!(/NOTIFY_SOCKET not set in environment/) &&
        !(/Invalid systemd notify socket, cannot send: /)) {
      s/mysqld-debug/mysqld/;
      print;
EOF

--error 1
exec $MYSQLD --defaults-file=/path/with.ext --print-defaults 2>$MDF_LOG;
  use strict;
  my $mysqld_log= $ENV{'MDF_LOG'};
    if (!(/NOTIFY_SOCKET not set in environment/) &&
        !(/Invalid systemd notify socket, cannot send: /)) {
      s/mysqld-debug/mysqld/;
      print;
EOF

-- Using $MYSQL_TEST_DIR_ABS which contains canonical path to the
-- test directory since --print-default prints the absolute path.
--error 1
exec $MYSQLD --defaults-file=relative/path/with.ext --print-defaults 2>$MDF_LOG;
  use strict;
  my $mysqld_log= $ENV{'MDF_LOG'};
  my $test_dir= $ENV{'MYSQL_TEST_DIR_ABS'};
    if (!(/NOTIFY_SOCKET not set in environment/) &&
        !(/Invalid systemd notify socket, cannot send: /)) {
      s/mysqld-debug/mysqld/;
      s/$test_dir/MYSQL_TEST_DIR/;
      print;
EOF

--error 1
exec $MYSQLD --defaults-file=relative/path/without/extension --print-defaults 2>$MDF_LOG;
  use strict;
  my $mysqld_log= $ENV{'MDF_LOG'};
  my $test_dir= $ENV{'MYSQL_TEST_DIR_ABS'};
    if (!(/NOTIFY_SOCKET not set in environment/) &&
        !(/Invalid systemd notify socket, cannot send: /)) {
      s/mysqld-debug/mysqld/;
      s/$test_dir/MYSQL_TEST_DIR/;
      print;
EOF

--error 1
exec $MYSQLD --defaults-file=with.ext --print-defaults 2>$MDF_LOG;
  use strict;
  my $mysqld_log= $ENV{'MDF_LOG'};
  my $test_dir= $ENV{'MYSQL_TEST_DIR_ABS'};
    if (!(/NOTIFY_SOCKET not set in environment/) &&
        !(/Invalid systemd notify socket, cannot send: /)) {
      s/mysqld-debug/mysqld/;
      s/$test_dir/MYSQL_TEST_DIR/;
      print;
EOF

--error 1
exec $MYSQLD --defaults-file=no_extension --print-defaults 2>$MDF_LOG;
  use strict;
  my $mysqld_log= $ENV{'MDF_LOG'};
  my $test_dir= $ENV{'MYSQL_TEST_DIR_ABS'};
    if (!(/NOTIFY_SOCKET not set in environment/) &&
        !(/Invalid systemd notify socket, cannot send: /)) {
      s/mysqld-debug/mysqld/;
      s/$test_dir/MYSQL_TEST_DIR/;
      print;
