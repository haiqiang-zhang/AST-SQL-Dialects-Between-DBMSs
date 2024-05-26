select toTypeName(x), x FROM m_table SETTINGS additional_table_filters = {'m_table':'x != 4'}, optimize_move_to_prewhere=1, allow_experimental_analyzer=1;
drop table test;
