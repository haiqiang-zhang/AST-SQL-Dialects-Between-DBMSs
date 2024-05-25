SELECT toUInt64(value),f FROM bool_test;
SELECT value,f FROM bool_test where value > 0;
set bool_true_representation='True';
set bool_false_representation='False';
set bool_true_representation='Yes';
set bool_false_representation='No';
set bool_true_representation='On';
set bool_false_representation='Off';
DROP TABLE IF EXISTS bool_test;
