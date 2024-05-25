PRAGMA enable_verification;
CREATE TABLE tag(id int, name string, subclassof int);
INSERT INTO tag VALUES
  (7, 'Music',  9),
  (8, 'Movies', 9),
  (9, 'Art',    NULL);
