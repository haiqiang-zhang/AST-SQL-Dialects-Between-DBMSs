SELECT SUM(dt::int) FROM small WHERE user_email IS NULL;
DROP TABLE small;
