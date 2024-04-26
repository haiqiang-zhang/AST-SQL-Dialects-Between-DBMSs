
let HELP_VERBOSE_OUTPUT= $MYSQL_TMP_DIR/server.out;
let HVARGS= --no-defaults --secure-file-priv="" --help --verbose >$HELP_VERBOSE_OUTPUT 2>&1;
  use strict;
  use File::Basename;
  use Config;
  use File::Spec;

  my $binary= $ENV{'MYSQLD'};
  my $bindir= dirname($binary);
  my $binary= basename($binary);

  my $relbindir= basename($bindir);
  my $exe= File::Spec->catfile($relbindir, $binary);
  my $syscmd= "$exe $ENV{'HVARGS'}";
EOF
--source include/check_dir_settings.inc
--remove_file $HELP_VERBOSE_OUTPUT


--echo --
--echo -- Deduce --basedir when using bare executable name (PATH lookup)
--echo --
--perl
  use strict;
  use File::Basename;
  use Config;
  my $binary= $ENV{'MYSQLD'};
  my $bindir= dirname($binary);
  my $syscmd= "$binary $ENV{'HVARGS'}";
