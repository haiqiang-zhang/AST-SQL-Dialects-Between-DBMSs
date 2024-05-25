set receive_timeout=1;
select * from url('http://127.0.0.1:8123/?query=select+1&user=default', LineAsString, 's String');
system flush logs;
