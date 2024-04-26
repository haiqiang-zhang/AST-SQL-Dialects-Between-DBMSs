--                                                                      #
-- Test for bug #32020 "loading udfs while --skip-grant-tables is       #
--                     enabled causes out of memory errors"             #
--                                                                      #
-- Creation:                                                            #
-- 2007-12-24 akopytov Moved the test case for bug #32020 from          #
--                     skip_grants.test to a separate test to ensure    #
--                     that it is only run when the server is built     #
--                     with support for dynamically loaded libraries    #
--                     (see bug #33305).                                #
--                                                                      #
--#######################################################################

-- source include/have_udf.inc

--
-- Bug #32020: loading udfs while --skip-grant-tables is enabled causes out of 
--             memory errors
--

--error ER_CANT_INITIALIZE_UDF
CREATE FUNCTION a RETURNS STRING SONAME '';
DROP FUNCTION a;
