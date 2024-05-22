SELECT parseTimeDelta('1 min 35 sec');
SELECT parseTimeDelta('11hr 25min 3.1s');
SELECT parseTimeDelta('0.00123 seconds');
SELECT parseTimeDelta('1yr2mo');
SELECT parseTimeDelta('11s+22min');
SELECT parseTimeDelta('1s1ms1us1ns');
SELECT parseTimeDelta('1.11s1.11ms1.11us1.11ns');
