select 1+1;
select 1+2;

--
-- Bug #30651	Problems with thread_handling system variable
--

--error ER_INCORRECT_GLOBAL_LOCAL_VAR
select @@session.thread_handling;
set GLOBAL thread_handling='one-thread';
