CREATE TABLE p1(a PRIMARY KEY, b);
CREATE TABLE c1(x, y REFERENCES p1);
CREATE INDEX 'c1_y' ON 'c1'('y');
--> p1(a);
CREATE TABLE c2(x REFERENCES p1, y REFERENCES p1);
CREATE INDEX 'c2_y' ON 'c2'('y');
--> p1(a)
CREATE INDEX 'c2_x' ON 'c2'('x');
--> p1(a);
CREATE TABLE 'p 1'(a, b, c, PRIMARY KEY(c, b));
CREATE TABLE 'c 1'(x, y, z, FOREIGN KEY (z, y) REFERENCES 'p 1');
CREATE INDEX 'c 1_z_y' ON 'c 1'('z', 'y');
--> p 1(c,b);
--> p1(b b b);
CREATE TABLE x1(a, b, c, UNIQUE(a, b));
CREATE TABLE y1(a, b, c, FOREIGN KEY(b, a) REFERENCES x1(a, b));
CREATE INDEX y1i ON y1(a, c, b);
CREATE INDEX 'y1_b_a' ON 'y1'('b', 'a');
--> x1(a,b);
CREATE INDEX 'y1_a' ON 'y1'('a' COLLATE nocase);
--> x1(a);
--> x1(c,b,a);
CREATE TABLE parent (id INTEGER PRIMARY KEY);
CREATE TABLE child2 (id INT PRIMARY KEY, parentID INT REFERENCES parent) 
      WITHOUT ROWID;
CREATE INDEX 'child2_parentID' ON 'child2'('parentID');
--> parent(id);
