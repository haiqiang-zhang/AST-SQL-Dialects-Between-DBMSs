SELECT transform((number, toString(number)), [(3, '3'), (5, '5'), (7, '7')], ['hello', 'world', 'abc!'], 'def') FROM system.numbers LIMIT 10;
select case 1::Nullable(Int32) when 1 then 123 else 0 end;
SELECT transform(1, [1], [toDecimal32(1, 2)]), toDecimal32(1, 2);
