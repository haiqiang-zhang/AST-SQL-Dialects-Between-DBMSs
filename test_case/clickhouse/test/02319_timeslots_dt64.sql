SELECT timeSlots(toDateTime64('2000-01-02 03:04:05.12', 2, 'UTC'), toDecimal64(10000, 0));
SELECT timeSlots(toDateTime64('2000-01-02 03:04:05.233', 3, 'UTC'), toDecimal64(10000.12, 2), toDecimal64(634.1, 1));
SELECT timeSlots(toDateTime64('2000-01-02 03:04:05.3456', 4, 'UTC'), toDecimal64(600, 0), toDecimal64(30, 0));
