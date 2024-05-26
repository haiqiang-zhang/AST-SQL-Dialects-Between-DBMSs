PRAGMA enable_verification;
CREATE TABLE Product(DaysToManufacture int, StandardCost int GENERATED ALWAYS AS (DaysToManufacture * 5));
INSERT INTO Product VALUES (0), (1), (2), (4);
