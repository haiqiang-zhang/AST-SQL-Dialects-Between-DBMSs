
let MYSQLD_PIDFILE= `SELECT @@pid_file;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
  my $wait_cnt=60;
        $pid = $_;
  }
  close(FILE);
        if($wait_cnt==0) { die "timedout waiting for general_log to be flushed";
        sleep 1;
        $wait_cnt--;
  }
EOF

--echo -- Check that both files still exists
--file_exists $MYSQLD_LOG
--file_exists $MYSQLD_LOG.1

--echo -- CLEAN UP
--remove_file $MYSQLD_LOG.1

--echo --################################################################
--echo --##############     SLOW LOG     ################################
SET @@global.slow_query_log=1;
let MYSQLD_PIDFILE= `SELECT @@pid_file;

SELECT 1;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
  my $wait_cnt=60;
        $pid = $_;
  }
  close(FILE);
        if($wait_cnt==0) { die "timedout waiting for general_log to be flushed";
        sleep 1;
        $wait_cnt--;
  }
EOF

--echo -- Check that both files still exists
--file_exists $MYSQLD_LOG_SLOW
--file_exists $MYSQLD_LOG_SLOW.1

--echo --
--echo -- Set the log output to a table.
--echo -- The server must not fail when SIGUSR1 is sent, even though slow log output
--echo -- is set to a table (log_output).
--echo --
let MYSQLD_PIDFILE= `SELECT @@pid_file;
SET @@global.log_output='TABLE';

SELECT 1;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
        $pid = $_;
  }
  close(FILE);
EOF

--echo --
--echo -- SET LOG OUTPUT TO 'NONE'
--echo --
let MYSQLD_PIDFILE= `SELECT @@pid_file;
SET @@global.log_output='NONE';

SELECT 1;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
        $pid = $_;
  }
  close(FILE);
EOF


--echo -- CLEAN UP
SET @@global.slow_query_log=0;
SET @@global.general_log=1;
SET @@global.log_output='FILE';
let MYSQLD_PIDFILE= `SELECT @@pid_file;

SELECT 1;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
  my $wait_cnt=60;
        $pid = $_;
  }
  close(FILE);
        if($wait_cnt==0) { die "timedout waiting for general_log to be flushed";
        sleep 1;
        $wait_cnt--;
  }
EOF

--echo -- Check that both files still exists
--file_exists $MYSQLD_LOG_GENERAL
--file_exists $MYSQLD_LOG_GENERAL.1

--echo --
--echo -- Set the log output to a table.
--echo -- The server must not fail when SIGUSR1 is sent, even though slow log output 
--echo -- is set to a table (log_output).
--echo -- let MYSQLD_PIDFILE= `SELECT @@pid_file;
SET @@global.log_output='TABLE';

SELECT 1;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
        $pid = $_;
  }
  close(FILE);
EOF

--echo --
--echo -- SET LOG OUTPUT TO 'NONE'
--echo --
let MYSQLD_PIDFILE= `SELECT @@pid_file;
SET @@global.log_output='NONE';

SELECT 1;
  use strict;
  use warnings;
  my $filename = $ENV{"MYSQLD_PIDFILE"} or die("pidfile not set");
  my $pid;
        $pid = $_;
  }
  close(FILE);
EOF

--echo -- CLEAN UP
SET @@global.general_log=0;
