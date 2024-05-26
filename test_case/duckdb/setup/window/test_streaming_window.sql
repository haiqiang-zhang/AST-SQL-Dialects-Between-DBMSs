PRAGMA enable_verification;
PRAGMA explain_output = PHYSICAL_ONLY;
create table integers (i int, j int);
insert into integers values (2, 2), (2, 1), (1, 2), (1, NULL);
CREATE TABLE v1(id bigint);
CREATE TABLE v2(id bigint);
INSERT INTO v1 VALUES (11),  (12),  (13);
INSERT INTO v2 VALUES (21),  (22);
CREATE VIEW vertices_view AS
  SELECT * FROM v1
  UNION ALL
  SELECT * FROM v2;
