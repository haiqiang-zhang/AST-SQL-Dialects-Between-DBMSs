SELECT anyIf(toNullable('Hello'), arrayJoin([1, NULL]) = 0);
SELECT number, anyIf(toNullable('Hello'), arrayJoin([1, NULL]) = 0) FROM numbers(2) GROUP BY number ORDER BY number;
