
if ( !$VERSION_TOKEN ) {
  skip Locking service plugin requires the environment variable \$VERSION_TOKEN to be set (normally done by mtr);
SELECT version_tokens_show();
drop function version_tokens_show;


-- echo
-- echo -- Error checks for UDFs
--error ER_CANT_INITIALIZE_UDF
select version_tokens_set("token1    =     abc;
select version_tokens_edit("token1= 123;
select version_tokens_delete("token1;
select version_tokens_show("123");
select version_tokens_set(123);
select version_tokens_edit(123);
select version_tokens_delete(123);
select version_tokens_lock_shared("Less arguments");
select version_tokens_lock_shared(1,"Wrong argument type");
select version_tokens_lock_exclusive("Less arguments");
select version_tokens_lock_exclusive(1,"Wrong argument type");
select version_tokens_unlock("Takes no arguments");
select version_tokens_lock_shared("gizmo", -1);
select version_tokens_lock_exclusive("gizmo", -1);

-- echo
CREATE USER vbhagi@localhost;

-- echo
select version_tokens_set("token1    =     abc;
select version_tokens_show();

-- echo
select version_tokens_set("");
select version_tokens_show();

-- echo
select version_tokens_set("token1    =     abc;
select version_tokens_show();

-- echo
select version_tokens_edit("token1= 123;
select version_tokens_show();

-- echo
do version_tokens_set("token1    =     def;
select version_tokens_show();

-- echo
do version_tokens_set("token1    =     def;
select version_tokens_show();

-- echo
do version_tokens_set("token1    =     none;
select version_tokens_show();

-- echo
do version_tokens_set("token1=def;
select version_tokens_show();

-- echo
select version_tokens_delete("invalid=token");
select version_tokens_show();

-- echo
select version_tokens_delete("token1;
select version_tokens_show();

-- echo
select version_tokens_delete("*");
select version_tokens_show();

-- echo
do version_tokens_set("token1=def;
select version_tokens_show();

-- echo
connect (con1,localhost,vbhagi,,test);
select version_tokens_set("token1    =     abc;
select version_tokens_edit("token1= 123;
select version_tokens_delete("token1;
select version_tokens_show();
set @@version_tokens_session= "token1=def";

-- echo
select 1;
select 1;

-- echo
set @@version_tokens_session= "token3=abc";

-- echo
--error ER_VTOKEN_PLUGIN_TOKEN_MISMATCH
select 1;

-- echo
disconnect con1;
select @@version_tokens_session;
set @@version_tokens_session= "token111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111=abc;
select @@version_tokens_session;

-- echo
set @@version_tokens_session= ";
set @@version_tokens_session= NULL;
set @@version_tokens_session= "token1=def;
set @@version_tokens_session= "token1=def;
set @@version_tokens_session= "token1=def;
set @@version_tokens_session= "token1=def;
use test;
create table t1 (c1 int);
drop table t1;
set @@version_tokens_session= "token1=def;
create table t1 (c1 int);
set @@version_tokens_session= "token100=def;
create table t1 (c1 int);

-- echo
-- echo -- Connection: default
connection default;
select 1;
CREATE USER u1@localhost IDENTIFIED BY 'foo';

-- echo -- Connection: vtcon1 
CONNECTION vtcon1;
SELECT version_tokens_set("a=aa;
set @@version_tokens_session= "a=aa";

-- echo -- Connection: vtcon2
CONNECTION vtcon2;
SELECT version_tokens_lock_exclusive("b",20);

-- echo -- Connection: vtcon3
CONNECTION vtcon3;
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info like '%select sleep%' AND state='User sleep';
SELECT version_tokens_lock_exclusive("a",20);
SELECT version_tokens_unlock();


-- echo
UNINSTALL PLUGIN version_tokens;
let $mysql_errno = 0;
{
  --error 0,1123
  SELECT version_tokens_set("token1=abc;

-- echo
-- echo -- The UDFs fail as the plugin is uninstalled.
--error ER_CANT_INITIALIZE_UDF
select version_tokens_set("token1    =     abc;
select version_tokens_edit("token1= 123;
select version_tokens_delete("token1;
select version_tokens_show();
drop function version_tokens_set;
drop function version_tokens_show;
drop function version_tokens_edit;
drop function version_tokens_delete;
drop function version_tokens_lock_shared;
drop function version_tokens_lock_exclusive;
drop function version_tokens_unlock;
drop user vbhagi@localhost;
drop user u1@localhost;
