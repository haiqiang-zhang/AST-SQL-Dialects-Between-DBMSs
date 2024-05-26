select toYYYYMMDD(toDate(recordTimestamp, 'Europe/Amsterdam')), toDate(recordTimestamp, 'Europe/Amsterdam'), toInt64(1665519765) as recordTimestamp, toTypeName(recordTimestamp);
select toYYYYMMDD(toDate32(recordTimestamp, 'Europe/Amsterdam')), toDate32(recordTimestamp, 'Europe/Amsterdam'), toInt64(1665519765) as recordTimestamp, toTypeName(recordTimestamp);
select toYYYYMMDD(toDateTime(recordTimestamp, 'Europe/Amsterdam')), toDateTime(recordTimestamp, 'Europe/Amsterdam'), toInt64(1665519765) as recordTimestamp, toTypeName(recordTimestamp);
select toYYYYMMDD(toDateTime64(recordTimestamp, 3, 'Europe/Amsterdam')), toDateTime64(recordTimestamp, 3, 'Europe/Amsterdam'), toInt64(1665519765) as recordTimestamp, toTypeName(recordTimestamp);
