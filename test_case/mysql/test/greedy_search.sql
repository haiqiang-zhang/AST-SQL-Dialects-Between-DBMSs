
-- To make sure we have stable costs, set memory io cost equal to disk io cost
UPDATE mysql.engine_cost
SET cost_value = 1.0
WHERE cost_name = 'memory_block_read_cost';

-- Only new connections see the new cost constants
connect (con1, localhost, root,,);

let $brands=7;
let $models_pr_brand=5;
let $misc_properties_big=20;
let $misc_properties_small=10;
let $vehicles=100;
CREATE TABLE brands (
  id_pk int PRIMARY KEY, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE models (
  id_pk int PRIMARY KEY, 
  id_nokey int, 
  brand_id int, 
  name varchar(100), 
  INDEX(`brand_id`)
);

let $i=0;
let $cnt=0;
{
  inc $i;
  let $j=0;
  { 
    inc $cnt;
    inc $j;
    eval INSERT INTO models VALUES ($cnt, $cnt, $i, concat('brandmodel',$cnt));
  }
}

eval 
CREATE TABLE subtypes (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE colors (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE heating (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE windows (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE fuels (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE transmissions (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE steerings (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE interiors (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);

let $i=0;
{
  inc $i;
CREATE TABLE drives (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
let $i=0;
{
  inc $i;
CREATE TABLE wheels (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
let $i=0;
{
  inc $i;
CREATE TABLE engine (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
let $i=0;
{
  inc $i;
CREATE TABLE price_ranges (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
let $i=0;
{
  inc $i;
CREATE TABLE countries (
  id_pk int primary key, 
  id_nokey int, 
  name varchar(100)
);
let $i=0;
{
  inc $i;
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


let $brands=7;
let $models_pr_brand=3;
let $misc_properties_big=20;
let $misc_properties_small=$misc_properties_big/2;
{
  inc $i;
                                    $i, $i%2, $i%3, $i%4, $i%5, $i%6, $i%7, 
                                    $i );

SET SESSION optimizer_search_depth = 25;

let $query=
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

let $query=
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

-- Explanation to the test
--
-- A chain of tables is joined like this:
--    t1 JOIN t2 ON t1.<some_col>=t2.<some_col> JOIN t3 ON ...
--
-- Different variants of table sizes and columns in the join conditions
-- are tested. 
--
-- The column names mean:
--   'pk'     - The column is primary key
--   'colidx' - The column is indexed
--   'col'    - The column is not indexed
--
-- The table names mean:
--   tx_y     - table with x rows, y is simply used to get unique table names
--
-- A comment explains each test. The notation used is
--    (...,tx_col_next):(ty_col_prev,...)
-- which means that table x is joined with table y with join condition
-- "ON tx.col_next = ty.col_prev" like this:
--    t1 JOIN t2 ON t1.col_next=t2.col_prev ...

--echo --
--echo -- Chain test a:      colidx):(pk,colidx):(pk,colidx)
--echo --

let $query= SELECT * FROM t10_1;
let $i= 1;
{
  let $query= $query JOIN t100_$i ON t10_$i.colidx = t100_$i.pk;
  let $j=$i;
  inc $j;
  let $query= $query JOIN t10_$j ON t100_$i.colidx = t10_$j.pk;
  inc $i;
let $query= SELECT * FROM t10_1;
let $i= 1;
{
  let $query= $query JOIN t100_$i ON t10_$i.col = t100_$i.colidx;
  let $j=$i;
  inc $j;
  let $query= $query JOIN t10_$j ON t100_$i.col = t10_$j.pk;
  inc $i;
let $query= SELECT * FROM t10_1;
let $i= 1;
{
  let $query= $query JOIN t100_$i ON t10_$i.colidx = t100_$i.col;
  let $j=$i;
  inc $j;
  let $query= $query JOIN t10_$j ON t100_$i.pk = t10_$j.col;
  inc $i;
let $query= SELECT * FROM t10_1;
let $i= 1;
{
  let $query= $query JOIN t100_$i ON t10_$i.colidx = t100_$i.pk;
  let $j=$i;
  inc $j;
  let $query= $query JOIN t10_$j ON t100_$i.col = t10_$j.pk;
  inc $i;

-- Reset cost value to make sure it does not effect other tests
UPDATE mysql.engine_cost
SET cost_value = DEFAULT
WHERE cost_name = 'memory_block_read_cost';
