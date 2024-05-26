SET allow_simdjson=1;
SELECT JSONLength('"HX-=');
SELECT isValidJSON('{"success"test:"123"}');
SET allow_simdjson=0;
