SELECT randomStringUTF8('string');
SELECT lengthUTF8(randomStringUTF8(100));
SELECT toTypeName(randomStringUTF8(10));
SELECT isValidUTF8(randomStringUTF8(100000));
SELECT randomStringUTF8(0);
SELECT lengthUTF8(lowerUTF8(randomStringUTF8(99)));