drop table if exists t1;
CREATE TABLE t1 (
id INT NOT NULL,
name VARCHAR(255),
department VARCHAR(10),
country VARCHAR(255)
) PARTITION BY LIST COLUMNS (department, country) (
PARTITION first_office VALUES IN (('dep1', 'Russia'), ('dep1', 'Croatia')),
PARTITION second_office VALUES IN (('dep2', 'Russia'))
);
INSERT INTO t1 VALUES(1, 'Ann', 'dep1', 'Russia');
INSERT INTO t1 VALUES(2, 'Bob', 'dep1', 'Croatia');
INSERT INTO t1 VALUES(3, 'Cecil', 'dep2', 'Russia');
