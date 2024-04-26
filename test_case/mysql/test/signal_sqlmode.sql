
-- Tests for SIGNAL, RESIGNAL and GET DIAGNOSTICS

SET @save_sql_mode=@@sql_mode;

SET sql_mode='';
drop procedure if exists p;
drop procedure if exists p2;
drop procedure if exists p3;

create procedure p()
begin
  declare utf8_var VARCHAR(128) CHARACTER SET utf8mb3;
  set utf8_var = concat(repeat('A', 128), 'X');
  select length(utf8_var), utf8_var;
end
$$

create procedure p2()
begin
  declare msg VARCHAR(129) CHARACTER SET utf8mb3;
  set msg = concat(repeat('A', 128), 'X');
  select length(msg), msg;
end
$$

create procedure p3()
begin
  declare name VARCHAR(65) CHARACTER SET utf8mb3;
  set name = concat(repeat('A', 64), 'X');
  select length(name), name;
    message_text = 'Message',
    table_name = name;
end
$$
delimiter ;

drop procedure p;
drop procedure p2;
drop procedure p3;

SET sql_mode=default;

create procedure p()
begin
  declare utf8_var VARCHAR(128) CHARACTER SET utf8mb3;
  set utf8_var = concat(repeat('A', 128), 'X');
  select length(utf8_var), utf8_var;
end
$$

create procedure p2()
begin
  declare msg VARCHAR(129) CHARACTER SET utf8mb3;
  set msg = concat(repeat('A', 128), 'X');
  select length(msg), msg;
end
$$

create procedure p3()
begin
  declare name VARCHAR(65) CHARACTER SET utf8mb3;
  set name = concat(repeat('A', 64), 'X');
  select length(name), name;
    message_text = 'Message',
    table_name = name;
end
$$

delimiter ;

drop procedure p;
drop procedure p2;
drop procedure p3;

SET @@sql_mode=@save_sql_mode;
