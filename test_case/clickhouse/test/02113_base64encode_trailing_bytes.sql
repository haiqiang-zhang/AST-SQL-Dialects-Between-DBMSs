SELECT * FROM tabl_1 SETTINGS log_comment = 'ad15a651';
SELECT * FROM tabl_2 SETTINGS log_comment = 'ad15a651';
SYSTEM FLUSH LOGS;
DROP TABLE tabl_1;
DROP TABLE tabl_2;
