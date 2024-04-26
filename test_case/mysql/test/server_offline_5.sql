
-- source include/not_threadpool.inc

-- Save the global value to be used to restore the original value.
SET @global_saved_tmp =  @@global.offline_mode;

-- This count may not be 1, because of the probably existing connections
-- from the previous/parallel test runs
let $user_count= `SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE USER != 'event_scheduler'`;

-- test case 2.1.14 1)
-- Create high nb of non-super users

let $nbconn_max= 100;
let $nbconn= $nbconn_max;
{
  eval CREATE USER 'user$nbconn'@'localhost';
  dec $nbconn;

-- Super user sessions
let $nbsu_max= 3;
let $nbsu= $nbsu_max;
{
  --connect(su$nbsu,localhost,root)
  dec $nbsu;

let $nbconn= $nbconn_max;
{
  --connect(conu$nbconn,localhost,user$nbconn)
  dec $nbconn;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = ON;

-- Wait until all non super user have been disconnected (for slow machines)
let $count_sessions= $nbsu_max + $user_count;

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = OFF;

-- Disconnect cleanup session infos on client side to be able to reconnect.
let $nbconn= $nbconn_max;
{
  --disconnect conu$nbconn
  --connect(conu$nbconn,localhost,user$nbconn)
  dec $nbconn;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = ON;

-- Wait until all non super user have been disconnected (for slow machines)
let $count_sessions= $nbsu_max + $user_count;

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Clean up
let $nbconn= $nbconn_max;
{
  --disconnect conu$nbconn
  dec $nbconn;

let $nbsu= $nbsu_max;
{
  --disconnect su$nbsu
  dec $nbsu;

-- Wait until all users have been disconnected (for slow machines)
let $count_sessions= $user_count;

let $nbconn= $nbconn_max;
{
  eval DROP USER 'user$nbconn'@'localhost';
  dec $nbconn;
SET @@global.offline_mode = @global_saved_tmp;
