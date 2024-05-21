-- on the right is not in the range of the left type, it should be ignored.
select (toUInt8(1)) in (-1);
select (toUInt8(0)) in (-1);
select (toUInt8(255)) in (-1);
select [toUInt8(1)] in [-1];
select [toUInt8(0)] in [-1];
select [toUInt8(255)] in [-1];
