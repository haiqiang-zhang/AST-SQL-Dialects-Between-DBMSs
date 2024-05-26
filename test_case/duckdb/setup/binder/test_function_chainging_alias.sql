PRAGMA enable_verification;
CREATE TABLE varchars(v VARCHAR);
INSERT INTO varchars VALUES ('>>%Test<<'), ('%FUNCTION%'), ('Chaining');
DELETE FROM varchars;
INSERT INTO varchars VALUES ('Test Function Chainging Alias');
