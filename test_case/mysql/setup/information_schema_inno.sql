DROP TABLE IF EXISTS t1,t2,t3;
CREATE TABLE t1 (id INT NOT NULL, PRIMARY KEY (id)) ENGINE=INNODB;
CREATE TABLE t2 (id INT PRIMARY KEY, t1_id INT, INDEX par_ind (t1_id, id),
FOREIGN KEY (t1_id) REFERENCES t1(id)  ON DELETE CASCADE,
FOREIGN KEY (t1_id) REFERENCES t1(id)  ON UPDATE CASCADE) ENGINE=INNODB;
CREATE TABLE t3 (id INT PRIMARY KEY, t2_id INT, INDEX par_ind (t2_id),
FOREIGN KEY (id, t2_id) REFERENCES t2(t1_id, id)  ON DELETE CASCADE) ENGINE=INNODB;