${statement_type} ${null_order_type}='nulls_last';
${statement_type} ${null_order_type}='nulls_first';
${statement_type} ${null_order_type}='unknown_null_order';
SELECT * FROM range(3) UNION ALL SELECT NULL ORDER BY 1;
SELECT * FROM range(3) UNION ALL SELECT NULL ORDER BY 1;
