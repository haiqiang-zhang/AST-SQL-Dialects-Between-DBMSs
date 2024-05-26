SELECT variantType(v) as type FROM test;
SELECT toTypeName(variantType(v)) from test limit 1;
