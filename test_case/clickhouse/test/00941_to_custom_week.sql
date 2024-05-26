SELECT toWeek(toDate('1998-01-01')), toWeek(toDate('1997-01-01')), toWeek(toDate('1998-01-01'), 1),  toWeek(toDate('1997-01-01'), 1);
SELECT toYearWeek(toDate('1981-12-31'), 1), toYearWeek(toDate('1982-01-01'), 1), toYearWeek(toDate('1982-12-31'), 1), toYearWeek(toDate('1983-01-01'), 1);
SELECT toWeek(toDate('2000-01-01'),0) AS w2000, toWeek(toDate('2001-01-01'),0) AS w2001, toWeek(toDate('2002-01-01'),0) AS w2002,toWeek(toDate('2003-01-01'),0) AS w2003, toWeek(toDate('2004-01-01'),0) AS w2004, toWeek(toDate('2005-01-01'),0) AS w2005, toWeek(toDate('2006-01-01'),0) AS w2006;
SELECT toWeek(toDate('2000-01-06'),0) AS w2000, toWeek(toDate('2001-01-06'),0) AS w2001, toWeek(toDate('2002-01-06'),0) AS w2002,toWeek(toDate('2003-01-06'),0) AS w2003, toWeek(toDate('2004-01-06'),0) AS w2004, toWeek(toDate('2005-01-06'),0) AS w2005, toWeek(toDate('2006-01-06'),0) AS w2006;
SELECT toWeek(toDate('2000-01-01'),1) AS w2000, toWeek(toDate('2001-01-01'),1) AS w2001, toWeek(toDate('2002-01-01'),1) AS w2002,toWeek(toDate('2003-01-01'),1) AS w2003, toWeek(toDate('2004-01-01'),1) AS w2004, toWeek(toDate('2005-01-01'),1) AS w2005, toWeek(toDate('2006-01-01'),1) AS w2006;
SELECT toWeek(toDate('2000-01-06'),1) AS w2000, toWeek(toDate('2001-01-06'),1) AS w2001, toWeek(toDate('2002-01-06'),1) AS w2002,toWeek(toDate('2003-01-06'),1) AS w2003, toWeek(toDate('2004-01-06'),1) AS w2004, toWeek(toDate('2005-01-06'),1) AS w2005, toWeek(toDate('2006-01-06'),1) AS w2006;
SELECT toYearWeek(toDate('2000-01-01'),0) AS w2000, toYearWeek(toDate('2001-01-01'),0) AS w2001, toYearWeek(toDate('2002-01-01'),0) AS w2002,toYearWeek(toDate('2003-01-01'),0) AS w2003, toYearWeek(toDate('2004-01-01'),0) AS w2004, toYearWeek(toDate('2005-01-01'),0) AS w2005, toYearWeek(toDate('2006-01-01'),0) AS w2006;
SELECT toYearWeek(toDate('2000-01-06'),0) AS w2000, toYearWeek(toDate('2001-01-06'),0) AS w2001, toYearWeek(toDate('2002-01-06'),0) AS w2002,toYearWeek(toDate('2003-01-06'),0) AS w2003, toYearWeek(toDate('2004-01-06'),0) AS w2004, toYearWeek(toDate('2005-01-06'),0) AS w2005, toYearWeek(toDate('2006-01-06'),0) AS w2006;
SELECT toYearWeek(toDate('2000-01-01'),1) AS w2000, toYearWeek(toDate('2001-01-01'),1) AS w2001, toYearWeek(toDate('2002-01-01'),1) AS w2002,toYearWeek(toDate('2003-01-01'),1) AS w2003, toYearWeek(toDate('2004-01-01'),1) AS w2004, toYearWeek(toDate('2005-01-01'),1) AS w2005, toYearWeek(toDate('2006-01-01'),1) AS w2006;
SELECT toYearWeek(toDate('2000-01-06'),1) AS w2000, toYearWeek(toDate('2001-01-06'),1) AS w2001, toYearWeek(toDate('2002-01-06'),1) AS w2002,toYearWeek(toDate('2003-01-06'),1) AS w2003, toYearWeek(toDate('2004-01-06'),1) AS w2004, toYearWeek(toDate('2005-01-06'),1) AS w2005, toYearWeek(toDate('2006-01-06'),1) AS w2006;
SELECT toWeek(toDate('1998-12-31'),0) AS w0, toWeek(toDate('1998-12-31'),1) AS w1, toWeek(toDate('1998-12-31'),2) AS w2, toWeek(toDate('1998-12-31'),3) AS w3, toWeek(toDate('1998-12-31'),4) AS w4, toWeek(toDate('1998-12-31'),5) AS w5, toWeek(toDate('1998-12-31'),6) AS w6, toWeek(toDate('1998-12-31'),7) AS w7;
SELECT toWeek(toDate('2000-01-01'),0) AS w0, toWeek(toDate('2000-01-01'),1) AS w1, toWeek(toDate('2000-01-01'),2) AS w2, toWeek(toDate('2000-01-01'),3) AS w3, toWeek(toDate('2000-01-01'),4) AS w4, toWeek(toDate('2000-01-01'),5) AS w5, toWeek(toDate('2000-01-01'),6) AS w6, toWeek(toDate('2000-01-01'),7) AS w7;
SELECT toWeek(toDate('2000-01-06'),0) AS w0, toWeek(toDate('2000-01-06'),1) AS w1, toWeek(toDate('2000-01-06'),2) AS w2, toWeek(toDate('2000-01-06'),3) AS w3, toWeek(toDate('2000-01-06'),4) AS w4, toWeek(toDate('2000-01-06'),5) AS w5, toWeek(toDate('2000-01-06'),6) AS w6, toWeek(toDate('2000-01-06'),7) AS w7;
SELECT toWeek(toDate('2000-12-31'),0) AS w0, toWeek(toDate('2000-12-31'),1) AS w1, toWeek(toDate('2000-12-31'),2) AS w2, toWeek(toDate('2000-12-31'),3) AS w3, toWeek(toDate('2000-12-31'),4) AS w4, toWeek(toDate('2000-12-31'),5) AS w5, toWeek(toDate('2000-12-31'),6) AS w6, toWeek(toDate('2000-12-31'),7) AS w7;
SELECT toWeek(toDate('2001-01-01'),0) AS w0, toWeek(toDate('2001-01-01'),1) AS w1, toWeek(toDate('2001-01-01'),2) AS w2, toWeek(toDate('2001-01-01'),3) AS w3, toWeek(toDate('2001-01-01'),4) AS w4, toWeek(toDate('2001-01-01'),5) AS w5, toWeek(toDate('2001-01-01'),6) AS w6, toWeek(toDate('2001-01-01'),7) AS w7;
SELECT
    toDate('2016-12-21') + number AS d, 
	  toWeek(d, 8) AS week8,
    toWeek(d, 9) AS week9, 
    toYearWeek(d, 8) AS yearWeek8,
    toYearWeek(d, 9) AS yearWeek9
FROM numbers(21);
SELECT toDateTime(toDate('2016-12-22') + number, 'Asia/Istanbul' ) AS d, 
    toWeek(d, 8, 'Asia/Istanbul') AS week8, 
    toWeek(d, 9, 'Asia/Istanbul') AS week9, 
    toYearWeek(d, 8, 'Asia/Istanbul') AS yearWeek8,
    toYearWeek(d, 9, 'Asia/Istanbul') AS yearWeek9
FROM numbers(21);
WITH
    toDate('2018-12-25') + number AS d,
    toDate32(d) AS d32,
    toDateTime(d) AS dt,
    toDateTime64(d, 0) AS dt64
SELECT
    dt64,
    toStartOfWeek(d) AS wd_sun,
    toStartOfWeek(d32) AS wd32_sun,
    toStartOfWeek(dt) AS wdt_sun,
    toStartOfWeek(dt64) AS wdt64_sun,
    toStartOfWeek(d, 1) AS wd_mon,
    toStartOfWeek(d32, 1) AS wd32_mon,
    toStartOfWeek(dt, 1) AS wdt_mon,
    toStartOfWeek(dt64, 1) AS wdt64_mon
FROM numbers(10);
