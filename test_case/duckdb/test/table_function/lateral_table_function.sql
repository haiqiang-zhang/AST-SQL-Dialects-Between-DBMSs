pragma enable_verification;
SELECT * FROM read_csv(thisishopefullyanonexistentfile);
SELECT * FROM (SELECT 'myfile.csv' AS thisishopefullyanonexistentfile), read_csv(thisishopefullyanonexistentfile);
