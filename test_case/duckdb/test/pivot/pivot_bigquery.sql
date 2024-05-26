SELECT * FROM Produce
UNPIVOT(sales FOR quarter IN (Q1, Q2, Q3, Q4))
ORDER BY ALL;
SELECT product, first_half_sales, second_half_sales, semesters FROM Produce
UNPIVOT(
  (first_half_sales, second_half_sales)
  FOR semesters
  IN ((Q1, Q2) AS 'semester_1', (Q3, Q4) AS 'semester_2'));
