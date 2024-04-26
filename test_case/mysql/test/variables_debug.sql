
SET @old_debug = @@GLOBAL.debug;

--
-- Bug#34678 @@debug variables incremental mode
--

set debug= 'T';
select @@debug;
set debug= '+P';
select @@debug;
set debug= '-P';
select @@debug;

--
-- Bug#38054: "SET SESSION debug" modifies @@global.debug variable
--

SELECT @@session.debug, @@global.debug;

SET SESSION debug = '';

SELECT @@session.debug, @@global.debug;

SET GLOBAL debug='d,injecting_fault_writing';
SELECT @@global.debug;
SET GLOBAL debug='';
SELECT @@global.debug;

SET GLOBAL debug=@old_debug;

SET @old_local_debug = @@debug;

SET @@debug='d,foo';
SELECT @@debug;
SET @@debug='';
SELECT @@debug;

SET @@debug = @old_local_debug;

SET @old_globaldebug = @@global.debug;
SET @old_sessiondebug= @@session.debug;
SET GLOBAL  debug= '+O,../../log/bug46165.1.trace';
SET SESSION debug= '-d:-t:-i';

SET GLOBAL  debug= '';
SET SESSION debug= '';
SET GLOBAL  debug= '+O,../../log/bug46165.2.trace';
SET SESSION debug= '-d:-t:-i';
SET GLOBAL  debug= '';
SET SESSION debug= '';
SET GLOBAL  debug= '';
SET GLOBAL  debug= '+O,../../log/bug46165.3.trace';
SET SESSION debug= '-d:-t:-i';
SET GLOBAL  debug= '';
SET GLOBAL  debug= '+O,../../log/bug46165.4.trace';
SET SESSION debug= '-d:-t:-i';
SET SESSION debug= '-d:-t:-i';
SET GLOBAL  debug= '';
SET SESSION debug= '';
SET SESSION debug= '';
SET SESSION debug= '+O,../../log/bug46165.5.trace';
SET SESSION debug= '+O,../../log/bug46165.6.trace';
SET SESSION debug= '-O';

SET GLOBAL  debug= @old_globaldebug;
SET SESSION debug= @old_sessiondebug;
