
-- thread pool causes different results
-- source include/not_threadpool.inc

-- Connect using named pipe for testing
connect(pipe_con,localhost,root,,,,,PIPE);

-- Source select test case
-- source include/common-tests.inc

connection default;
