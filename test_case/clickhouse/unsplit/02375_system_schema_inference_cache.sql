insert into function file('02374_data1.jsonl') select number as x, 'str' as s from numbers(10);
insert into function file('02374_data2.jsonl') select number as x, 'str' as s from numbers(10);
system drop schema cache for file;
desc file('02374_data1.jsonl');
system drop schema cache for file;
