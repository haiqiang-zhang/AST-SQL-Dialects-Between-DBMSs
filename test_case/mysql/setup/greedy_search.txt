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
