select d from values('d Decimal(27, 8)', 0, 9) where d not in (-9223372036854775808, 0);
select d from values('d Decimal(28, 8)', 0, 10) where d not in (18446744073709551615, 0);
