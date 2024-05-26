select toString(x)::Decimal(6, 3) from generateRandom('x Decimal(6, 3)', 42) limit 5;
select reinterpret(x, 'UInt8') from generateRandom('x Bool', 42) limit 5;
