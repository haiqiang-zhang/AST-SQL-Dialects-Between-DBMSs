SELECT radians(t1.c0) FROM 03015_aggregator_empty_data_multiple_blocks AS t1 RIGHT ANTI JOIN 03015_aggregator_empty_data_multiple_blocks AS right_0 ON t1.c0=right_0.c0 GROUP BY t1.c0;
