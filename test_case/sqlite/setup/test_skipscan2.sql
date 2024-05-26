CREATE TABLE people(
    name TEXT PRIMARY KEY,
    role TEXT NOT NULL,
    height INT NOT NULL, -- in cm
    CHECK( role IN ('student','teacher') )
  );
CREATE INDEX people_idx1 ON people(role, height);
INSERT INTO people VALUES('Alice','student',156);
INSERT INTO people VALUES('Bob','student',161);
INSERT INTO people VALUES('Cindy','student',155);
INSERT INTO people VALUES('David','student',181);
INSERT INTO people VALUES('Emily','teacher',158);
INSERT INTO people VALUES('Fred','student',163);
INSERT INTO people VALUES('Ginny','student',169);
INSERT INTO people VALUES('Harold','student',172);
INSERT INTO people VALUES('Imma','student',179);
INSERT INTO people VALUES('Jack','student',181);
INSERT INTO people VALUES('Karen','student',163);
INSERT INTO people VALUES('Logan','student',177);
INSERT INTO people VALUES('Megan','teacher',159);
INSERT INTO people VALUES('Nathan','student',163);
INSERT INTO people VALUES('Olivia','student',161);
INSERT INTO people VALUES('Patrick','teacher',180);
INSERT INTO people VALUES('Quiana','student',182);
INSERT INTO people VALUES('Robert','student',159);
INSERT INTO people VALUES('Sally','student',166);
INSERT INTO people VALUES('Tom','student',171);
INSERT INTO people VALUES('Ursula','student',170);
INSERT INTO people VALUES('Vance','student',179);
INSERT INTO people VALUES('Willma','student',175);
INSERT INTO people VALUES('Xavier','teacher',185);
INSERT INTO people VALUES('Yvonne','student',149);
INSERT INTO people VALUES('Zach','student',170);
