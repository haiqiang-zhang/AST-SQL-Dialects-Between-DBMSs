CREATE TABLE people(
    name TEXT PRIMARY KEY,
    role TEXT NOT NULL,
    height INT NOT NULL, -- in cm
    CHECK( role IN ('student','teacher') )
  );
