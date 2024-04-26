
-- Unfortunately while the order of the requirements was sensible for
-- human consumption, it's relatively impractical to test in that order. :(

CALL mtr.add_suppression("option 'log_error_verbosity'");

SET @old_log_error_verbosity= @@global.log_error_verbosity;
SET @old_log_timestamps     = @@global.log_timestamps;
SELECT @@global.log_error_verbosity;
SET GLOBAL log_error_verbosity=DEFAULT;
SELECT @@global.log_error_verbosity;
SET GLOBAL log_error_verbosity=0;
SELECT @@global.log_error_verbosity;
SET GLOBAL log_error_verbosity=4;
SELECT @@global.log_error_verbosity;
SET SESSION log_error_verbosity=DEFAULT;

CREATE USER mysqltest_1;
SET GLOBAL log_error_verbosity=1;
SET GLOBAL log_timestamps=SYSTEM;
DROP USER mysqltest_1;

SET GLOBAL  init_connect='wombat;

CREATE USER mysqltest_yeslog;
CREATE USER mysqltest_nolog;

SET GLOBAL  log_error_verbosity=2;
SET GLOBAL  log_error_verbosity=1;
DROP USER mysqltest_yeslog;
DROP USER mysqltest_nolog;

SET GLOBAL  init_connect='';
SET GLOBAL  log_error_verbosity=2;

SET GLOBAL  log_error_verbosity=3;

SET GLOBAL  log_error_verbosity=DEFAULT;
SELECT      @@global.log_timestamps;
SET GLOBAL  log_timestamps=UTC;
SELECT      @@global.log_timestamps;
SET GLOBAL  log_timestamps=SYSTEM;
SELECT      @@global.log_timestamps;
SET GLOBAL  log_timestamps=DEFAULT;
SELECT      @@global.log_timestamps;

let GREP_FILE=$MYSQLTEST_VARDIR/tmp/wl6661_log.err;
let GREP_PATTERN=Access denied;

-- be very specific with the regex, we've got a format to prove:
--replace_regex /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9][-+Z][0-9:]* *[0-9]* *\[/DATE_TIME [/
--perl
  use strict;
  my $file= $ENV{'GREP_FILE'} or die("grep file not set");
  my $pattern= $ENV{'GREP_PATTERN'} or die("pattern is not set");
    my $line = $_;
    if ($line =~ /$pattern/) {
      print "$line\n";
    }
  }
  close(FILE);
EOF

--echo
--echo -- cleanup
SET GLOBAL log_error_verbosity = @old_log_error_verbosity;
SET GLOBAL log_timestamps      = @old_log_timestamps;
