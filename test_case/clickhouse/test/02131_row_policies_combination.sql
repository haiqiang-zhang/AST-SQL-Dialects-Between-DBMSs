SELECT 'None';
SELECT * FROM 02131_rptable;
SELECT 'R1: x == 1';
SELECT * FROM 02131_rptable;
SELECT 'R1, R2: (x == 1) OR (x == 2)';
SELECT * FROM 02131_rptable;
SELECT 'R1, R2, R3: (x == 1) OR (x == 2) OR (x == 3)';
SELECT * FROM 02131_rptable;
SELECT 'R1, R2, R3 + additional_table_filters and PREWHERE: (x == 1) OR (x == 2) OR (x == 3) AND (x < 3) AND (x > 1)';
SELECT * FROM 02131_rptable
PREWHERE x >= 2
SETTINGS additional_table_filters = {'02131_rptable': 'x > 1'};
SELECT 'R1, R2, R3 + additional_result_filter and PREWHERE: (x == 1) OR (x == 2) OR (x == 3) AND (x < 3) AND (x > 1)';
SELECT * FROM 02131_rptable
PREWHERE x >= 2
SETTINGS additional_result_filter = 'x > 1';
SELECT 'R1, R2, R3 + additional_table_filters and WHERE: (x == 1) OR (x == 2) OR (x == 3) AND (x < 3) AND (x > 1)';
SELECT * FROM 02131_rptable
WHERE x >= 2
SETTINGS additional_table_filters = {'02131_rptable': 'x > 1'};
SELECT 'R1, R2, R3, R4: ((x == 1) OR (x == 2) OR (x == 3)) AND (x <= 2)';
SELECT * FROM 02131_rptable;
SELECT 'R1, R2, R3, R4, R5: ((x == 1) OR (x == 2) OR (x == 3)) AND (x <= 2) AND (x >= 2)';
SELECT * FROM 02131_rptable;
SELECT 'R2, R3, R4, R5: ((x == 2) OR (x == 3)) AND (x <= 2) AND (x >= 2)';
SELECT * FROM 02131_rptable;
SELECT 'R3, R4, R5: (x == 3) AND (x <= 2) AND (x >= 2)';
SELECT * FROM 02131_rptable;
SELECT 'R4, R5: (x <= 2) AND (x >= 2)';
SELECT * FROM 02131_rptable;
SELECT 'R5: (x >= 2)';
SELECT * FROM 02131_rptable;
SELECT 'None';
SELECT * FROM 02131_rptable;
DROP TABLE 02131_rptable;
