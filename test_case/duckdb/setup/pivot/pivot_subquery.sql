PRAGMA enable_verification;
CREATE OR REPLACE TABLE sales(empid INT, amount INT, d DATE);
INSERT INTO sales VALUES
    (1, 10000, DATE '2000-01-01'),
    (1, 400, DATE '2000-01-07'),
    (2, 4500, DATE '2001-01-21'),
    (2, 35000, DATE '2001-01-21'),
    (1, 5000, DATE '2000-02-03'),
    (1, 3000, DATE '2000-02-07'),
    (2, 200, DATE '2001-02-05'),
    (2, 90500, DATE '2001-02-19'),
    (1, 6000, DATE '2000-03-01'),
    (1, 5000, DATE '2000-03-09'),
    (2, 2500, DATE '2001-03-03'),
    (2, 9500, DATE '2001-03-08');
