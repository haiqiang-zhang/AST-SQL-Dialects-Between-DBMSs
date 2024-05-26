SELECT count() FROM constCondOptimization WHERE if(0, 1, n = 1000);
DROP TABLE constCondOptimization;
