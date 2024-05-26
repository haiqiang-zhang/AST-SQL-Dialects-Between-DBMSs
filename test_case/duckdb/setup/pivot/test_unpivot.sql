PRAGMA enable_verification;
CREATE OR REPLACE TABLE monthly_sales(empid INT, dept TEXT, Jan INT, Feb INT, Mar INT, April INT);
INSERT INTO monthly_sales VALUES
    (1, 'electronics', 100, 200, 300, 100),
    (2, 'clothes', 100, 300, 150, 200),
    (3, 'cars', 200, 400, 100, 50);
