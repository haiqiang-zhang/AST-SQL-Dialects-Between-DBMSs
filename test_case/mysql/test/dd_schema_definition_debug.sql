SELECT IFNULL(CONCAT('The schema checksum corresponds to DD version ',
                     version, '.'),
              CONCAT('No DD version found with schema checksum ',
                     whole_schema.checksum, '.')) AS CHECK_STATUS
  FROM dd_published_schema
    RIGHT OUTER JOIN whole_schema
    ON dd_published_schema.checksum= whole_schema.checksum;
