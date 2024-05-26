CREATE TABLE t1 (id int(11) NOT NULL PRIMARY KEY, name varchar(20),
                 INDEX (name)) charset utf8mb4 ENGINE=InnoDB;
CREATE TABLE t2 (id int(11) NOT NULL PRIMARY KEY, fkey int(11),
                 FOREIGN KEY (fkey) REFERENCES t2(id)) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1,'A1'),(2,'A2'),(3,'B');
INSERT INTO t2 VALUES (1,1),(2,2),(3,2),(4,3),(5,3);
