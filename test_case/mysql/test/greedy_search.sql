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
