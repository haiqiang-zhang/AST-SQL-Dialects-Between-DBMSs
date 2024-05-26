PRAGMA enable_verification;
CREATE TABLE tenk1d (
        unique1	        int4,
		four		int4,
        col             int4
);
INSERT INTO tenk1d (unique1, four, col) VALUES 
  (0, 0, NULL),
  (1, 1, 1),
  (2, 2, NULL),
  (3, 3, 3),
  (4, 0, NULL),
  (5, 1, 1),
  (6, 2, NULL),
  (7, 3, 3),
  (8, 0, NULL),
  (9, 1, 1);
CREATE TABLE empsalary (
depname varchar,
empno bigint,
salary int,
enroll_date date
);
INSERT INTO empsalary VALUES
('develop', 10, 5200, '2007-08-01'),
('sales', 1, 5000, '2006-10-01'),
('personnel', 5, 3500, '2007-12-10'),
('sales', 4, 4800, '2007-08-08'),
('personnel', 2, 3900, '2006-12-23'),
('develop', 7, 4200, '2008-01-01'),
('develop', 9, 4500, '2008-01-01'),
('sales', 3, 4800, '2007-08-01'),
('develop', 8, 6000, '2006-10-01'),
('develop', 11, 5200, '2007-08-15');
