SELECT singleValueOrNull(toNullable(''));
SELECT '' = ALL (SELECT toNullable(''));
