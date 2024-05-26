CREATE TABLE td(d INT);
INSERT INTO td(d) VALUES (10),(1),(2),(3),(4),(5),(6),(7),(8),(9);
INSERT INTO td(d) SELECT d+10 FROM td UNION
               SELECT d+20 FROM td UNION
               SELECT d+30 FROM td UNION
               SELECT d+40 FROM td UNION
               SELECT d+50 FROM td UNION
               SELECT d+60 FROM td UNION
               SELECT d+70 FROM td UNION
               SELECT d+80 FROM td UNION
               SELECT d+90 FROM td;
INSERT INTO td(d) SELECT d+100 FROM td UNION
               SELECT d+200 FROM td UNION
               SELECT d+300 FROM td UNION
               SELECT d+400 FROM td UNION
               SELECT d+500 FROM td UNION
               SELECT d+600 FROM td UNION
               SELECT d+700 FROM td UNION
               SELECT d+800 FROM td UNION
               SELECT d+900 FROM td;
INSERT INTO td(d) SELECT d+1000 FROM td UNION
               SELECT d+2000 FROM td UNION
               SELECT d+3000 FROM td UNION
               SELECT d+4000 FROM td UNION
               SELECT d+5000 FROM td UNION
               SELECT d+6000 FROM td UNION
               SELECT d+7000 FROM td UNION
               SELECT d+8000 FROM td UNION
               SELECT d+9000 FROM td;
INSERT INTO td(d) SELECT d+10000 FROM td UNION
               SELECT d+20000 FROM td UNION
               SELECT d+30000 FROM td UNION
               SELECT d+40000 FROM td UNION
               SELECT d+50000 FROM td UNION
               SELECT d+60000 FROM td UNION
               SELECT d+70000 FROM td UNION
               SELECT d+80000 FROM td UNION
               SELECT d+90000 FROM td;
INSERT INTO td(d) SELECT d+100000 FROM td UNION
               SELECT d+200000 FROM td UNION
               SELECT d+300000 FROM td UNION
               SELECT d+400000 FROM td UNION
               SELECT d+500000 FROM td UNION
               SELECT d+600000 FROM td UNION
               SELECT d+700000 FROM td UNION
               SELECT d+800000 FROM td UNION
               SELECT d+900000 FROM td;
CREATE TABLE cpy(d INT, summ INT, nth INT, lagg INT);
