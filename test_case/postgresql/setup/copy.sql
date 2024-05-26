create temp table copytest (
	style	text,
	test 	text,
	filler	int);
insert into copytest values('DOS',E'abc\r\ndef',1);
insert into copytest values('Unix',E'abc\ndef',2);
insert into copytest values('Mac',E'abc\rdef',3);
insert into copytest values(E'esc\\ape',E'a\\r\\\r\\\n\\nb',4);
create temp table copytest2 (like copytest);
