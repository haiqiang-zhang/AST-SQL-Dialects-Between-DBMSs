DROP TABLE IF EXISTS A;
DROP TABLE IF EXISTS B;
CREATE TABLE A(k UInt32, t DateTime, a Float64) ENGINE = MergeTree() ORDER BY (k, t);
INSERT INTO A(k,t,a) VALUES (1,1,1),(1,2,2),(1,3,3),(1,4,4),(1,5,5);
INSERT INTO A(k,t,a) VALUES (2,1,1),(2,2,2),(2,3,3),(2,4,4),(2,5,5);
INSERT INTO A(k,t,a) VALUES (3,1,1),(3,2,2),(3,3,3),(3,4,4),(3,5,5);
CREATE TABLE B(k UInt32, t DateTime, b Float64) ENGINE = MergeTree() ORDER BY (k, t);
INSERT INTO B(k,t,b) VALUES (1,2,2),(1,4,4);
INSERT INTO B(k,t,b) VALUES (2,3,3);