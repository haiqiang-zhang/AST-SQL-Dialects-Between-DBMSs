CREATE TABLE slow_emp4000 (
	home_base	 box
);
CREATE TABLE fast_emp4000 (
	home_base	 box
);
INSERT INTO fast_emp4000 SELECT * FROM slow_emp4000;
