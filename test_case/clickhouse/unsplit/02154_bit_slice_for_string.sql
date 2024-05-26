SELECT 'Const Offset';
select 1 as offset, 'Hello' as s,  subString(bin(s), offset), bin(bitSlice(s, offset));
SELECT 'Const Truncate Offset';
SELECT 'Const Nullable Offset';
SELECT 'Const Offset, Const Length';
select 'Const Truncate Offset, Const Truncate Length';
select 'Const Nullable Offset, Const Nullable Length';
select 'Dynamic Offset, Dynamic Length';
select number as offset, number as length, 'Hello' as s,        subString(bin(s), offset , length), bin(bitSlice(s, offset, length)) from numbers(16);
select 'Dynamic Truncate Offset, Dynamic Truncate Length';
select 'Dynamic Nullable Offset, Dynamic Nullable Length';
