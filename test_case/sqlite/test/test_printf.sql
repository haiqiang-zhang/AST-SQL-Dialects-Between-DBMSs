SELECT printf('%.*g',2147483647,0.01);
SELECT format('%!.20g', 13.0);
SELECT length( format('%,.249f', -5.0e-300) );
