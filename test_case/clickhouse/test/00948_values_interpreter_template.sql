SELECT * FROM type_names ORDER BY n;
SELECT * FROM values_template ORDER BY d;
SELECT * FROM values_template_nullable ORDER BY d;
SELECT * FROM values_template_fallback ORDER BY n;
DROP TABLE type_names;
DROP TABLE values_template;
DROP TABLE values_template_nullable;
DROP TABLE values_template_fallback;
