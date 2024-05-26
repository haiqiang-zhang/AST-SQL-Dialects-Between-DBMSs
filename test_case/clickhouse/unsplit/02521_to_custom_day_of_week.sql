with toDate('2023-01-09') as date_mon, date_mon - 1 as date_sun select toDayOfWeek(date_mon), toDayOfWeek(date_sun);
