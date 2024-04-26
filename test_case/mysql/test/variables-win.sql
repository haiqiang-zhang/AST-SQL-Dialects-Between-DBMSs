SELECT
  LOCATE('/', @@basedir) <> 0 AS have_slashes,
  LOCATE('\\', @@basedir) <> 0 AS have_backslashes;
