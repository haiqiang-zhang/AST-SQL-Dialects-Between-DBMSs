CREATE TABLE Item(
       a integer PRIMARY KEY NOT NULL ,
       b double NULL ,
       c int NOT NULL DEFAULT 0
    );
CREATE TABLE Undo(UndoAction TEXT);
INSERT INTO Item VALUES (1,38205.60865,340);
DELETE FROM Item WHERE a = 1;
SELECT * FROM Undo;
PRAGMA integrity_check;
