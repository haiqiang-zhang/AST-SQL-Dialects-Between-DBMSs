
-- Check if the variable MY_PERROR is set
--source include/have_perror.inc

--#######################################################
--############ Skip if Non-English Windows

perl;
EOF

source $MYSQL_TMP_DIR/perror_syslocale.inc;

if ($non_eng_sys)
{
  skip Need an English Windows Installation;
