CREATE TABLE "x.1" (x, y);
INSERT INTO "x.1" VALUES(1, 1), (2, 2), (3, 3);
CREATE INDEX "i.1" ON "x.1"(y, x);
