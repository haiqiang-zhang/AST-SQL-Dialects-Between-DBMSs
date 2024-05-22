SELECT dateDiff('minute', ULIDStringToDateTime(generateULID()), now()) <= 1;
SELECT toTimezone(ULIDStringToDateTime('01GWJWKW30MFPQJRYEAF4XFZ9E'), 'America/Costa_Rica');
SELECT ULIDStringToDateTime('01GWJWKW30MFPQJRYEAF4XFZ9E', 'America/Costa_Rica');
