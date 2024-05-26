SELECT maxMap([number % 3, number % 4 - 1], [number, NULL]) FROM numbers(3) GROUP BY number WITH TOTALS ORDER BY number;
SELECT minMap([number % 3, number % 4 - 1], [number, NULL]) FROM numbers(3) GROUP BY number WITH TOTALS ORDER BY number;
SELECT sumMap([number % 3, number % 4 - 1], [number, NULL]) FROM numbers(3) GROUP BY number WITH TOTALS ORDER BY number;
SELECT '-';
SELECT '-';
