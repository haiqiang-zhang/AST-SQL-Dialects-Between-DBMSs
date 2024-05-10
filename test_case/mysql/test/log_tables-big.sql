select get_lock('bug27638', 1);
select get_lock('bug27638', 2);
select get_lock('bug27638', 60);
select get_lock('bug27638', 101);
select release_lock('bug27638');
