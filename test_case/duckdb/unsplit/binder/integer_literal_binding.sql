PRAGMA enable_verification;
SELECT typeof(100::${type} + 1) == '${type}';;
SELECT typeof(100 + 1::${type}) == '${type}';;
SELECT typeof(1::TINYINT + 100);;
SELECT typeof(1::TINYINT + 10000);;
SELECT typeof(1.05 + 1);
SELECT typeof(1 + 1);;
