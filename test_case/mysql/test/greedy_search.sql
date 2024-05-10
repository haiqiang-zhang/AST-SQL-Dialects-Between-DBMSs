CREATE TABLE brands (
  id_pk int PRIMARY KEY, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE models (
  id_pk int PRIMARY KEY, 
  id_nokey int, 
  brand_id int, 
  name varchar(100), 
  INDEX(`brand_id`)
);
CREATE TABLE subtypes (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE colors (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE heating (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE windows (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE fuels (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE transmissions (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE steerings (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE interiors (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE drives (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE wheels (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE engine (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE price_ranges (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE countries (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
CREATE TABLE vehicles (
  id int primary key, 
  model_id int, 
  subtype_id int, 
  color_id int, 
  heating_id int, 
  window_id int, 
  fuel_id int, 
  transmission_id int, 
  steering_id int, 
  interior_id int, 
  drive_id int, 
  price_range_id int, 
  assembled_in int, 
  engine_id int, 
  wheels_id int
);
SELECT *
FROM vehicles
  JOIN models        ON vehicles.model_id        = models.id_pk
  JOIN subtypes      ON vehicles.subtype_id      = subtypes.id_pk
  JOIN colors        ON vehicles.color_id        = colors.id_pk
  JOIN heating       ON vehicles.heating_id      = heating.id_pk
  JOIN windows       ON vehicles.window_id       = windows.id_pk
  JOIN fuels         ON vehicles.fuel_id         = fuels.id_pk
  JOIN transmissions ON vehicles.transmission_id = transmissions.id_pk
  JOIN steerings     ON vehicles.steering_id     = steerings.id_pk
  JOIN interiors     ON vehicles.interior_id     = interiors.id_pk
  JOIN drives        ON vehicles.drive_id        = drives.id_pk
  JOIN wheels        ON vehicles.wheels_id       = wheels.id_pk
  JOIN engine        ON vehicles.engine_id       = engine.id_pk
  JOIN price_ranges  ON vehicles.price_range_id  = price_ranges.id_pk
  JOIN countries     ON vehicles.assembled_in    = countries.id_pk
  JOIN brands        ON models.brand_id          = brands.id_pk;
SELECT *
FROM vehicles
  JOIN models        ON vehicles.model_id        = models.id_nokey
  JOIN subtypes      ON vehicles.subtype_id      = subtypes.id_pk
  JOIN colors        ON vehicles.color_id        = colors.id_pk
  JOIN heating       ON vehicles.heating_id      = heating.id_nokey
  JOIN windows       ON vehicles.window_id       = windows.id_pk
  JOIN fuels         ON vehicles.fuel_id         = fuels.id_pk
  JOIN transmissions ON vehicles.transmission_id = transmissions.id_nokey
  JOIN steerings     ON vehicles.steering_id     = steerings.id_pk
  JOIN interiors     ON vehicles.interior_id     = interiors.id_pk
  JOIN drives        ON vehicles.drive_id        = drives.id_pk
  JOIN wheels        ON vehicles.wheels_id       = wheels.id_nokey
  JOIN engine        ON vehicles.engine_id       = engine.id_pk
  JOIN price_ranges  ON vehicles.price_range_id  = price_ranges.id_pk
  JOIN countries     ON vehicles.assembled_in    = countries.id_pk
  JOIN brands        ON models.brand_id          = brands.id_nokey;
select @@optimizer_search_depth;
select @@optimizer_prune_level;
DROP TABLE vehicles, models, subtypes, colors, heating, windows, 
           fuels, transmissions, steerings, interiors, drives, 
           price_ranges, countries, brands, wheels, engine;
