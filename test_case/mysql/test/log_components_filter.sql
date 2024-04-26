
let GREP_START=`SELECT DATE_FORMAT(CONVERT_TZ(SYSDATE(6),'SYSTEM','UTC'),'%Y%m%d%H%i%s%f');

SET @old_log_error_verbosity = @@global.log_error_verbosity;
SET @@global.log_error_verbosity=3;

let $log_error_= `SELECT @@GLOBAL.log_error`;
{
  let $log_error_ = $MYSQLTEST_VARDIR/log/mysqld.1.err;

-- Send parse-trace to error log;
SET @@session.debug="+d,parser_stmt_to_error_log";
SET @@session.debug="+d,log_error_normalize";

SELECT @@global.log_error_services;
SET @save_filters= @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules= DEFAULT;

SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";

SET @save_filters= @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules="IF EXISTS source_line THEN unset source_line.";

SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS source_line THEN unset source_line.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";


-- reaction we get when we try to multi-open something not supporting instances:
--error ER_WRONG_VALUE_FOR_VAR
SET @@global.log_error_services="log_sink_internal;
SET @@global.log_error_services="log_filter_dragnet;

SET @@global.log_error_services="log_filter_dragnet;
SET @@global.dragnet.log_error_filter_rules='drop.';
SET @@global.dragnet.log_error_filter_rules='ELSE drop.';
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a OR NOT EXISTS b THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a AND NOT EXISTS b THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a AND NOT EXISTS b OR c>=5 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS prio THEN SET a=1. IF NOT EXISTS a THEN SET a='asd'.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS prio THEN SET a='qwerty'. IF EXISTS a THEN SET a='asd'.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS prio THEN SET a='qwerty'. IF NOT EXISTS a THEN SET a='asd'.";
SET @@global.dragnet.log_error_filter_rules='IF a>0 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a<3 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a>=0 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a<=3 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a=>0 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a=<3 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a!=2 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a<>2 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF NOT EXISTS a THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 5.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 5/30.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b:=2.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b=2.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b= 2.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b:="2".';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b:=2.0.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN unset.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a THEN unset.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF NOT EXISTS a THEN unset.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN unset a.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN unset a.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==ER_STARTUP THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF err_code==ER_STARTUP THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";


SET @@global.dragnet.log_error_filter_rules='IF err_symbol=="ER_STARTUP" THEN drop.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF err_symbol=='ER_STARTUP' THEN drop.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF err_code==ER_STARTUP THEN set err_code:=ER_YES.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF err_symbol=="ER_STARTUP" THEN set err_symbol:="ER_YES".';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a=="\\\\a\\\"\\\'" THEN set err_symbol:="ER_YES".';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='DRAUGR.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b==2.';
SET @@global.dragnet.log_error_filter_rules="IF err_symbol=='ER_STARTUP THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF err_symbol==ER_STARTUP' THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF err_symbol=='ER_STARTUP\" THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF err_symbol==\"ER_STARTUP' THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF misc_cstring=='1' THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF a=='1' THEN set misc_cstring:='abc'.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS misc_cstring THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS foo THEN set component:=1.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS foo THEN set component:=1..5.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS foo THEN set prio:=1.5.";
SET @@global.dragnet.log_error_filter_rules="IF err_symbol==ER_STARTUP";
SET @@global.dragnet.log_error_filter_rules="IF NOT field THEN action.";

-- test with tab instead of space
SET @@global.dragnet.log_error_filter_rules="IF\tEXISTS\tfield\tTHEN\tDROP.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";

-- test with multi-line rule-set
SET @@global.dragnet.log_error_filter_rules="IF\t \t\tEXISTS   field\rTHEN\nDROP.\nIF EXISTS field2 THEN DROP.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF err_symbol==ER_STARTUP THEN drop.';
SET @@global.dragnet.log_error_filter_rules='IF err_code=="ER_STARTUP" THEN drop.';

SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN unset.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 AND b==3 THEN unset.';
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a>0 THEN drop.';
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a THEN drop';
SET @@global.dragnet.log_error_filter_rules="IF EXISTS field THEN AND.";
SET @@global.dragnet.log_error_filter_rules="IF EXISTS field DROP.";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b:=.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set b:=.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN set :=2.';

-- . is terminator, not delimiter
--error ER_WRONG_VALUE_FOR_VAR
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop.';
SET @@global.dragnet.log_error_filter_rules=NULL;
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop.';
SET @@global.dragnet.log_error_filter_rules="";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SELECT @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop.';
SET PERSIST dragnet.log_error_filter_rules= '';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SELECT @@global.dragnet.log_error_filter_rules;
SELECT @@session.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules="IF prio>9999 THEN set prio:=WARNING.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=ERROR THEN drop.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=WARNING THEN drop.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=NOTE THEN drop.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=INFORMATION THEN drop.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF thread>=INFORMATION THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF prio>=INFORMATION THEN set thread:=ERROR.";
SET @@global.dragnet.log_error_filter_rules="IF prio>=NOUGAT THEN drop.";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN drop. IF EXISTS source_line THEN unset source_line. IF msg== \'Parser saw: select 1\' THEN set a:=1. ";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN drop. IF EXISTS source_line THEN unset source_line. IF msg==\'Parser saw: select 1\' THEN set a:=1. ";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 1/1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 .";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN drop. IF EXISTS source_line THEN unset source_line. IF err_code == 001045 THEN throttle 1/1.1.";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 111/3600.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 111/604800.";
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 111/604801.";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 111/0.";
SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 111/-1.";

-- --echo # throw error for negative values
-- SET @@global.dragnet.log_error_filter_rules="IF prio>=9999 THEN throttle 1/-1.";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop a.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle a.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1.5.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1/b.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle a/.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle -1/2.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 0/2.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1/2 ELSE throttle 1/30.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='ELSE.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 ELSE.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop ELSE drop ELSE drop.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop ELSE scream.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN drop ELSE.';
SET @@global.dragnet.log_error_filter_rules='IF .';
SET @@global.dragnet.log_error_filter_rules='IF EXISTS a THEN.';
SET @@global.dragnet.log_error_filter_rules='IF a!!b THEN drop.';
SET @@global.dragnet.log_error_filter_rules='IF EXISTS.';
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1/2 ELSEIF a==5 THEN throttle 1/30.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1/2 ELSE IF a==5 THEN throttle 1/30.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1/5 ELSEIF a==5 THEN throttle 2/5 ELSE throttle 3/5.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
SET @@global.dragnet.log_error_filter_rules='IF a==2 THEN throttle 1/5 ELSE IF a==5 THEN throttle 2/5 ELSE throttle 3/5.';
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";
CREATE TABLE my_rules (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, rule VARCHAR(256));
INSERT INTO my_rules VALUES(NULL, 'IF EXISTS source_line THEN unset source_line.');
INSERT INTO my_rules VALUES(NULL, 'IF EXISTS thread THEN set thread:=0.'),
                           (NULL, 'IF EXISTS user THEN unset user.'),
                           (NULL, 'IF EXISTS host THEN unset host.'),
                           (NULL, 'IF EXISTS query_id THEN set query_id:=0.'),
                           (NULL, 'IF EXISTS time THEN set time:="1970-01-01T00:00:00.012345Z".'),
                           (NULL, 'IF EXISTS _pid THEN unset _pid.'),
                           (NULL, 'IF EXISTS _platform THEN unset platform.'),
                           (NULL, 'IF EXISTS _client_version THEN unset _client_version.'),
                           (NULL, 'IF EXISTS _os THEN unset _os.');

-- additional rules that work in tandem with log_sink_test
-- 1 - IF/ELSEIF/ELSEIF/ELSE
INSERT INTO my_rules VALUES(NULL, 'IF wl9651_val1 < 1 THEN set wl9651_result1:="IF" ELSE IF wl9651_val1 == 1 THEN set wl9651_result1:="ELSEIF1" ELSE IF wl9651_val1 == 2 THEN set wl9651_result1:="ELSEIF2" ELSE set wl9651_result1:="ELSE".');

-- 2 - IF/OR/OR
INSERT INTO my_rules VALUES(NULL, 'IF wl9651_val2==1 OR wl9651_val2==2 OR wl9651_val2==3 THEN set wl9651_result2:="SUCCESS" ELSE set wl9651_result2:="FAILURE".');

-- 3 - IF/AND/AND
INSERT INTO my_rules VALUES(NULL, 'IF wl9651_val3a==1 AND wl9651_val3b==2 AND wl9651_val3c==3 THEN set wl9651_result3:="SUCCESS" ELSE set wl9651_result3:="FAILURE".');

-- Add more exceptions here for all messages that are not revelant to test and should be ignored.
INSERT INTO my_rules VALUES(NULL, 'IF err_code==011825 THEN drop.');

SELECT group_concat(rule ORDER BY id SEPARATOR ' ') FROM my_rules INTO @rules;
SET @@global.dragnet.log_error_filter_rules= @rules;

INSERT INTO my_rules VALUES(NULL, 'IF NOT EXISTS does_not_exist THEN set s1:="string". IF s1=="string" THEN set cmp01:="EQ/S works" ELSE set cmp01:="EQ/S is broken".');

INSERT INTO my_rules VALUES(NULL, 'IF s1!="stringx" THEN set cmp02:="NE/S works" ELSE set cmp02:="NE/S is broken".');

INSERT INTO my_rules VALUES(NULL, 'IF s1>="string" THEN set cmp03:="GE/S works" ELSE set cmp03:="GE/S is broken".');
INSERT INTO my_rules VALUES(NULL, 'IF s1>="strin" THEN set cmp04:="GE/S works" ELSE set cmp04:="GE/S is broken".');
INSERT INTO my_rules VALUES(NULL, 'IF s1>="strinx" THEN set cmp04:="GE/S is broken" ELSE set cmp04:="GE/S works".');

INSERT INTO my_rules VALUES(NULL, 'IF s1>"strinx" THEN set cmp05:="GT/S is broken" ELSE set cmp05:="GT/S works".');
INSERT INTO my_rules VALUES(NULL, 'IF s1>"string" THEN set cmp06:="GT/S is broken" ELSE set cmp06:="GT/S works".');
INSERT INTO my_rules VALUES(NULL, 'IF s1>"strin" THEN set cmp07:="GT/S works" ELSE set cmp07:="GT/S is broken".');

INSERT INTO my_rules VALUES(NULL, 'IF s1<="string" THEN set cmp08:="LE/S works" ELSE set cmp08:="LE/S is broken".');
INSERT INTO my_rules VALUES(NULL, 'IF s1<="strin" THEN set cmp09:="LE/S is broken" ELSE set cmp09:="LE/S works".');
INSERT INTO my_rules VALUES(NULL, 'IF s1<="strinx" THEN set cmp10:="LE/S works" ELSE set cmp10:="LE/S is broken".');

INSERT INTO my_rules VALUES(NULL, 'IF s1<"string" THEN set cmp11:="LT/S is broken" ELSE set cmp11:="LT/S works".');
INSERT INTO my_rules VALUES(NULL, 'IF s1<"strin" THEN set cmp12:="LT/S is broken" ELSE set cmp12:="LT/S works".');
INSERT INTO my_rules VALUES(NULL, 'IF s1<"strinx" THEN set cmp1:="LT/S works" ELSE set cmp13:="LT/S is broken".');

INSERT INTO my_rules VALUES(NULL, 'IF NOT EXISTS does_not_exist THEN set f1:=1.4. IF f1>=1.4 THEN set cmp14:="GE/-- works" ELSE set cmp14:="GE/# is broken".');
INSERT INTO my_rules VALUES(NULL, 'IF f1>=1 THEN set cmp15:="GE/-- works" ELSE set cmp15:="GE/# is broken".');
INSERT INTO my_rules VALUES(NULL, 'IF f1>=1.5 THEN set cmp16:="GE/-- is broken" ELSE set cmp16:="GE/# works".');


SET SESSION group_concat_max_len=65535;
SELECT group_concat(rule ORDER BY id SEPARATOR ' ') FROM my_rules INTO @rules;

DROP TABLE my_rules;
SET @@global.log_error_services="log_filter_dragnet;
SET @@global.dragnet.log_error_filter_rules= @rules;
SET @@global.log_error_services="log_filter_dragnet;

-- rule-set with too many rules -- this will fail with an explanatory message
--error ER_WRONG_VALUE_FOR_VAR
SET @@global.dragnet.log_error_filter_rules= REPEAT("IF prio>9 THEN drop. ", 1025);
SET @rules= CONCAT("IF ", REPEAT("x", 20000), ">9 THEN drop.");
SET @@global.dragnet.log_error_filter_rules= @rules;
SELECT variable_value AS decompiled_filter_rules FROM performance_schema.global_status WHERE variable_name="dragnet.Status";

SET @@global.log_error_services="log_filter_dragnet;

--
-- WL#11150: Add <component> to error log messages by default
--

-- Filter log messages using their subsystem
SET @@global.dragnet.log_error_filter_rules="IF subsystem=='Server' THEN SET msg := 'This is a message from the Server subsystem'.";

-- Test dropping, comparing and overriding the subsystem field
SET @@global.dragnet.log_error_filter_rules="IF subsystem == 'Server' THEN SET msg := 'Dropping subsystem if it is \"Server\" and setting it to Repl'. IF subsystem == 'Server' THEN UNSET subsystem. IF NOT EXISTS subsystem THEN SET subsystem := 'Repl'.";

SET @@global.dragnet.log_error_filter_rules="IF subsystem == 'Server' THEN SET subsystem := 'InnoDB'. IF subsystem == 'InnoDB' THEN SET msg := 'The subsystem for this message has been overriden to InnoDB'.";

SET @@global.dragnet.log_error_filter_rules="IF subsystem != 'SERVER' THEN SET msg := 'This message is seen as the the subsystem is specified in upper case'.";

SET @@global.dragnet.log_error_filter_rules=@save_filters;

--
-- WL#11393: Implement an interface to suppress error logs of type warning or note
--
call mtr.add_suppression("\\[ERROR\\] \\[MY\\-010000\\] \\[Server\\] Errors should not be suppressed");

-- Log error messages with varying severities having the same error code and
-- check if they are printed when the error code is present in the suppression
-- list.

SET @save_suppression_list=@@global.log_error_suppression_list;
SET @@global.log_error_services='log_filter_dragnet;
SET @@global.log_error_suppression_list='10000';
SET @@global.dragnet.log_error_filter_rules='IF err_code==ER_PARSER_TRACE THEN SET prio=0. IF err_code==ER_PARSER_TRACE THEN SET msg="System messages should not be suppressed".';
SET @@global.dragnet.log_error_filter_rules='IF err_code==ER_PARSER_TRACE THEN SET prio=1. IF err_code==ER_PARSER_TRACE THEN SET msg="Errors should not be suppressed".';
SET @@global.dragnet.log_error_filter_rules='IF err_code==ER_PARSER_TRACE THEN SET prio=2. IF err_code==ER_PARSER_TRACE THEN SET msg="Warnings should be suppressed".';
SET @@global.dragnet.log_error_filter_rules='IF err_code==ER_PARSER_TRACE THEN SET prio=3. IF err_code==ER_PARSER_TRACE THEN SET msg="Notes should be suppressed".';

SET @@global.log_error_services=DEFAULT;

SET @@global.dragnet.log_error_filter_rules=@save_filters;

SET @@global.log_error_suppression_list=@save_suppression_list;
SET @@global.dragnet.log_error_filter_rules=@save_filters;
SET @@session.debug="-d,parser_stmt_to_error_log";
SET @@session.debug="-d,log_error_normalize";

SET @@global.log_error_verbosity=DEFAULT;

let GREP_FILE=$log_error_;
   use strict;
   use File::stat;
   my $file= $ENV{'GREP_FILE'} or die("grep file not set");
   my $pattern="^20";
   my $stime= $ENV{'GREP_START'};

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;
     my $ts = 0;

     if ($stime == 0) {
       print "$line";
     }
     elsif (($line =~ /$pattern/) and not ($line =~ /redo log/)) {
       $line =~ /([0-9][0-9][0-9][0-9])-([0-9][0-9])-([0-9][0-9])T([0-9][0-9]):([0-9][0-9]):([0-9][0-9])\.([0-9][0-9][0-9][0-9][0-9][0-9])[-+Z][0-9:]* *[0-9]* *?(\[.*)/;
       $ts=$1.$2.$3.$4.$5.$6.$7;
       if ($ts >= $stime) {
         $stime= 0;
       }
     }
   }
   close(FILE);
EOF

SET @@global.log_error_verbosity=@old_log_error_verbosity;
