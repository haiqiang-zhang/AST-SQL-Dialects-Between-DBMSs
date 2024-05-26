create table insertconflicttest(key int4, fruit text);
create unique index op_index_key on insertconflicttest(key, fruit text_pattern_ops);
create unique index collation_index_key on insertconflicttest(key, fruit collate "C");
create unique index both_index_key on insertconflicttest(key, fruit collate "C" text_pattern_ops);
create unique index both_index_expr_key on insertconflicttest(key, lower(fruit) collate "C" text_pattern_ops);
