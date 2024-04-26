
-- 
-- Bug#14757009 : WHEN THE GENERAL_LOG IS A SOCKET AND THE READER GOES AWAY,
--                MYSQL QUITS WORKING.
--
call mtr.add_suppression("Could not use");

-- With fix error should be reported in the error log file if file is not a
-- regular file.
--perl
  my $file= $ENV{'GREP_FILE'};
  my $pattern= "Turning logging off for the server";
  my $count = 0;
    if ($_ =~ m/$pattern/) {
      $count++;
      break;
    }
  }
  if ($count >= 2){
    print "Setting fifo file as general log file and slow query log failed.\n";
  } else {
    print "test failed.\n";
  }
  close(FILE);
