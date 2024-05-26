CREATE TABLE link(aa INT, bb INT);
CREATE INDEX link_f ON link(aa,bb);
CREATE INDEX link_t ON link(bb,aa);
INSERT INTO link(aa,bb) VALUES
    (1,3),
    (5,3),
    (7,1),
    (7,9),
    (9,9),
    (5,11),
    (11,7),
    (2,4),
    (4,6),
    (8,6);
