PRAGMA enable_verification;
CREATE TEMP VIEW sales(year, quarter, region, sales) AS
   VALUES (2018, 1, 'east', 100),
          (2018, 2, 'east',  20),
          (2018, 3, 'east',  40),
          (2018, 4, 'east',  40),
          (2019, 1, 'east', 120),
          (2019, 2, 'east', 110),
          (2019, 3, 'east',  80),
          (2019, 4, 'east',  60),
          (2018, 1, 'west', 105),
          (2018, 2, 'west',  25),
          (2018, 3, 'west',  45),
          (2018, 4, 'west',  45),
          (2019, 1, 'west', 125),
          (2019, 2, 'west', 115),
          (2019, 3, 'west',  85),
          (2019, 4, 'west',  65);;
SELECT year, q1_east, q1_west, q2_east, q2_west, q3_east, q3_west, q4_east, q4_west
    FROM sales
    PIVOT (sum(sales)
      FOR (quarter, region, too_many_names)
      IN ((1, 'east') AS q1_east, (1, 'west') AS q1_west, (2, 'east') AS q2_east, (2, 'west') AS q2_west,
          (3, 'east') AS q3_east, (3, 'west') AS q3_west, (4, 'east') AS q4_east, (4, 'west') AS q4_west));;
SELECT year, q1_east, q1_west, q2_east, q2_west, q3_east, q3_west, q4_east, q4_west
    FROM sales
    PIVOT (sum(sales)
      FOR (quarter, region)
      IN ((1, 'east', 'west') AS q1_east, (1, 'west') AS q1_west, (2, 'east') AS q2_east, (2, 'west') AS q2_west,
          (3, 'east') AS q3_east, (3, 'west') AS q3_west, (4, 'east') AS q4_east, (4, 'west') AS q4_west));;
SELECT *
    FROM sales
    PIVOT (sum(sales)
      FOR (quarter, region)
      IN ((1, 'east') AS q1_east, (1, 'east') AS q1_east_2));;
CREATE OR REPLACE TEMPORARY VIEW sales(location, year, q1, q2, q3, q4) AS
  VALUES ('Toronto'      , 2020, 100 , 80 , 70, 150),
         ('San Francisco', 2020, NULL, 20 , 50,  60),
         ('Toronto'      , 2021, 110 , 90 , 80, 170),
         ('San Francisco', 2021, 70  , 120, 85, 105);;
CREATE OR REPLACE TEMPORARY VIEW oncall
         (year, week, area      , name1   , email1              , phone1     , name2   , email2              , phone2) AS
  VALUES (2022, 1   , 'frontend', 'Freddy', 'fred@alwaysup.org' , 15551234567, 'Fanny' , 'fanny@lwaysup.org' , 15552345678),
         (2022, 1   , 'backend' , 'Boris' , 'boris@alwaysup.org', 15553456789, 'Boomer', 'boomer@lwaysup.org', 15554567890),
         (2022, 2   , 'frontend', 'Franky', 'frank@lwaysup.org' , 15555678901, 'Fin'   , 'fin@alwaysup.org'  , 15556789012),
         (2022, 2   , 'backend' , 'Bonny' , 'bonny@alwaysup.org', 15557890123, 'Bea'   , 'bea@alwaysup.org'  , 15558901234);;
SELECT year, region, q1, q2, q3, q4
  FROM sales
  PIVOT (sum(sales)
    FOR quarter
    IN (1 AS q1, 2 AS q2, 3 AS q3, 4 AS q4));;
SELECT year, q1_east, q1_west, q2_east, q2_west, q3_east, q3_west, q4_east, q4_west
    FROM sales
    PIVOT (sum(sales)
      FOR (quarter, region)
      IN ((1, 'east') AS q1_east, (1, 'west') AS q1_west, (2, 'east') AS q2_east, (2, 'west') AS q2_west,
          (3, 'east') AS q3_east, (3, 'west') AS q3_west, (4, 'east') AS q4_east, (4, 'west') AS q4_west));;
SELECT year, q1, q2, q3, q4
  FROM (SELECT year, quarter, sales FROM sales) AS s
  PIVOT (sum(sales)
    FOR quarter
    IN (1 AS q1, 2 AS q2, 3 AS q3, 4 AS q4));;
SELECT year, q1_total, q1_avg, q2_total, q2_avg, q3_total, q3_avg, q4_total, q4_avg
    FROM (SELECT year, quarter, sales FROM sales) AS s
    PIVOT (sum(sales) AS total, avg(sales) AS avg
      FOR quarter
      IN (1 AS q1, 2 AS q2, 3 AS q3, 4 AS q4));;
SELECT *
    FROM (SELECT year, quarter, sales FROM sales) AS s
    PIVOT (sum(sales), avg(sales)
      FOR quarter
      IN (1 AS q1, 2 AS q2, 3 AS q3, 4 AS q4));;
SELECT *
    FROM sales UNPIVOT INCLUDE NULLS
    (sales FOR quarter IN (q1       AS "Jan-Mar",
                           q2       AS "Apr-Jun",
                           q3       AS "Jul-Sep",
                           q4 AS "Oct-Dec"));;
SELECT *
    FROM oncall UNPIVOT ((name, email, phone) FOR precedence IN ((name1, email1, phone1) AS primary,
                                                                 (name2, email2, phone2) AS secondary));;