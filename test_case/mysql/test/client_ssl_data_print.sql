
-- print SSL session .pem contents to file
let SESSION_FILE=$MYSQLTEST_VARDIR/tmp/ssldata.pem;

-- assert the file has correct access permissions (0600)
--perl
use strict;
die "Invalid permission $perm for $ENV{SESSION_FILE}" unless $perm == '0600';
