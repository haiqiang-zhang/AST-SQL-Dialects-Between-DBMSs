select 'const args';
select 'concat';
select arrayConcat(emptyArrayUInt8());
select 'slice';
select arraySlice(Null, 1, 2);
select arraySlice([], materialize(NULL), NULL), 1 from numbers(2);
select 'push back';
select arrayPushBack(Null, 1);
select 'push front';
select arrayPushFront(Null, 1);
select 'pop back';
select arrayPopBack(Null);
select 'pop front';
select arrayPopFront(Null);
DROP TABLE if exists array_functions;
select '';
select 'table';
create table array_functions (arr1 Array(Int8), arr2 Array(Int8), o Int8, no Nullable(Int8), l Int8, nl Nullable(Int8)) engine = TinyLog;
insert into array_functions values ([], [], 1, Null, 1, Null), ([], [1], 1, Null, 1, Null), ([1, 2, 3, 4, 5], [6, 7], 2, Null, 1, Null), ([1, 2, 3, 4, 5, 6, 7], [8], 2, 2, 3, 3), ([1, 2, 3, 4, 5, 6, 7], [], 2, Null, -3, -3), ([1, 2, 3, 4, 5, 6, 7], [], 2, Null, -3, Null), ([1, 2, 3, 4, 5, 6, 7], [], -5, -5, 4, 4), ([1, 2, 3, 4, 5, 6, 7], [], -5, -5, -3, -3);
select * from array_functions;
select 'concat arr1, arr2';
select 'concat arr1, arr2, arr1';
select 'arraySlice(arr1, o, l)';
select 'arraySlice(arr1, no, nl)';
select 'arraySlice(arr1, 2, l)';
select 'arraySlice(arr1, o, 2)';
select 'arraySlice(arr1, 2, nl)';
select 'arraySlice(arr1, no, 2)';
select 'arraySlice(arr1, -4, l)';
select 'arraySlice(arr1, o, -2)';
select 'arraySlice(arr1, -4, nl)';
select 'arraySlice(arr1, no, -2)';
select 'arraySlice(arr1, 2, 4)';
select 'arraySlice(arr1, 2, -4)';
select 'arraySlice(arr1, -4, 2)';
select 'arraySlice(arr1, -4, -1)';
select 'arrayPushFront(arr1, 1)';
select 'arrayPushFront(arr1, 0.1)';
select 'arrayPushFront(arr1, l)';
select 'arrayPushFront(arr1, nl)';
select 'arrayPushFront([1, 2, 3], l)';
select 'arrayPushFront([1, 2, 3], nl)' from array_functions;
select 'arrayPushBack(arr1, 1)';
select 'arrayPushBack(arr1, 0.1)';
select 'arrayPushBack(arr1, l)';
select 'arrayPushBack(arr1, nl)';
select 'arrayPushBack([1, 2, 3], l)';
select 'arrayPushBack([1, 2, 3], nl)';
select 'arrayPopFront(arr1)';
select 'arrayPopBack(arr1)';
DROP TABLE if exists array_functions;
select '';
select 'table';
create table array_functions (arr1 Array(Nullable(Int8)), arr2 Array(Nullable(Float32)), o Int8, no Nullable(Int8), l Int8, nl Nullable(Int8)) engine = TinyLog;
insert into array_functions values ([], [], 1, Null, 1, Null), ([], [1, Null], 1, Null, 1, Null), ([1, 2, 3, 4, 5], [6, Null], 2, Null, 1, Null), ([1, Null, 3, 4, Null, 6, 7], [8], 2, 2, 3, 3),([1, 2, 3, Null, 5, 6, 7], [Null, 1], 2, Null, -3, -3),([1, 2, 3, 4, 5, Null, 7], [1, Null], 2, Null, -3, Null), ([1, 2, 3, 4, 5, 6, 7], [1, 2], -5, -5, 4, 4),([1, Null, 3, Null, 5, 6, 7], [], -5, -5, -3, -3);
select * from array_functions;
select 'concat arr1, arr2';
select 'concat arr1, arr2, arr1';
select 'arraySlice(arr1, o, l)';
select 'arraySlice(arr1, no, nl)';
select 'arraySlice(arr1, 2, l)';
select 'arraySlice(arr1, o, 2)';
select 'arraySlice(arr1, 2, nl)';
select 'arraySlice(arr1, no, 2)';
select 'arraySlice(arr1, -4, l)';
select 'arraySlice(arr1, o, -2)';
select 'arraySlice(arr1, -4, nl)';
select 'arraySlice(arr1, no, -2)';
select 'arraySlice(arr1, 2, 4)';
select 'arraySlice(arr1, 2, -4)';
select 'arraySlice(arr1, -4, 2)';
select 'arraySlice(arr1, -4, -1)';
select 'arrayPushFront(arr1, 1)';
select 'arrayPushFront(arr1, 0.1)';
select 'arrayPushFront(arr1, l)';
select 'arrayPushFront(arr1, nl)';
select 'arrayPushFront([1, 2, 3], l)';
select 'arrayPushFront([1, 2, 3], nl)' from array_functions;
select 'arrayPushBack(arr1, 1)';
select 'arrayPushBack(arr1, 0.1)';
select 'arrayPushBack(arr1, l)';
select 'arrayPushBack(arr1, nl)';
select 'arrayPushBack([1, 2, 3], l)';
select 'arrayPushBack([1, 2, 3], nl)';
select 'arrayPopFront(arr1)';
select 'arrayPopBack(arr1)';
DROP TABLE if exists array_functions;
select '';
select 'table';
create table array_functions (arr1 Array(Nullable(Int8)), arr2 Array(UInt8), o Int8, no Nullable(Int8), l Int8, nl Nullable(Int8)) engine = TinyLog;
insert into array_functions values ([], [], 1, Null, 1, Null), ([], [1, 2], 1, Null, 1, Null), ([1, 2, 3, 4, 5], [6, 7], 2, Null, 1, Null), ([1, Null,3,4, Null, 6, 7], [8], 2, 2, 3, 3),([1, 2, 3, Null, 5, 6, 7], [0, 1], 2, Null, -3, -3),([1, 2, 3, 4, 5, Null, 7], [1, 2], 2, Null, -3, Null),([1, 2, 3,4, 5, 6, 7], [1, 2], -5, -5, 4, 4),([1, Null, 3, Null, 5, 6, 7], [], -5, -5, -3, -3);
select * from array_functions;
select 'concat arr1, arr2';
select 'concat arr1, arr2, arr1';
select * from array_functions;
select 'concat arr1, arr2';
select 'concat arr1, arr2, arr1';
select 'arraySlice(arr1, o, l)';
select 'arraySlice(arr1, no, nl)';
select 'arraySlice(arr1, 2, l)';
select 'arraySlice(arr1, o, 2)';
select 'arraySlice(arr1, 2, nl)';
select 'arraySlice(arr1, no, 2)';
select 'arraySlice(arr1, -4, l)';
select 'arraySlice(arr1, o, -2)';
select 'arraySlice(arr1, -4, nl)';
select 'arraySlice(arr1, no, -2)';
select 'arraySlice(arr1, 2, 4)';
select 'arraySlice(arr1, 2, -4)';
select 'arraySlice(arr1, -4, 2)';
select 'arraySlice(arr1, -4, -1)';
select 'arrayPushFront(arr1, 1)';
select 'arrayPushFront(arr1, 0.1)';
select 'arrayPushFront(arr1, l)';
select 'arrayPushFront(arr1, nl)';
select 'arrayPushFront([1, 2, 3], l)';
select 'arrayPushFront([1, 2, 3], nl)' from array_functions;
select 'arrayPushBack(arr1, 1)';
select 'arrayPushBack(arr1, 0.1)';
select 'arrayPushBack(arr1, l)';
select 'arrayPushBack(arr1, nl)';
select 'arrayPushBack([1, 2, 3], l)';
select 'arrayPushBack([1, 2, 3], nl)';
select 'arrayPopFront(arr1)';
select 'arrayPopBack(arr1)';
DROP TABLE if exists array_functions;
select '';
select 'table';
create table array_functions (arr1 Array(Nullable(String)), arr2 Array(String), val String, val2 Nullable(String), o Int8, no Nullable(Int8), l Int8, nl Nullable(Int8)) engine = TinyLog;
insert into array_functions values ([], [], '', Null, 1, Null, 1, Null), ([], ['1', '2'], 'a', 'b', 1, Null, 1, Null), (['1', '2', '3', '4', '5'], ['6','7'], 'a', Null, 2, Null, 1, Null), (['1', Null, '3', '4', Null, '6', '7'], ['8'], 'a', 'b', 2, 2, 3, 3),(['1', '2', '3', Null, '5', '6', '7'], ['0','1'], 'a', Null, 2, Null, -3, -3),(['1', '2', '3', '4', '5', Null, '7'], ['1', '2'], 'a', 'b', 2, Null, -3, Null),(['1', '2', '3', '4', '5', '6', '7'],['1', '2'], 'a', Null, -5, -5, 4, 4),(['1', Null, '3', Null, '5', '6', '7'], [], 'a', 'b', -5, -5, -3, -3);
select * from array_functions;
select 'concat arr1, arr2';
select 'concat arr1, arr2, arr1';
select 'arraySlice(arr1, o, l)';
select 'arraySlice(arr1, no, nl)';
select 'arraySlice(arr1, 2, l)';
select 'arraySlice(arr1, o, 2)';
select 'arraySlice(arr1, 2, nl)';
select 'arraySlice(arr1, no, 2)';
select 'arraySlice(arr1, -4, l)';
select 'arraySlice(arr1, o, -2)';
select 'arraySlice(arr1, -4, nl)';
select 'arraySlice(arr1, no, -2)';
select 'arraySlice(arr1, 2, 4)';
select 'arraySlice(arr1, 2, -4)';
select 'arraySlice(arr1, -4, 2)';
select 'arraySlice(arr1, -4, -1)';
select 'arrayPushFront(arr1, 1)';
select 'arrayPushFront(arr1, val)';
select 'arrayPushFront(arr1, val2)';
select 'arrayPushFront([a, b, c], val)';
select 'arrayPushFront([a, b, c], val2)';
select 'arrayPushBack(arr1, 1)';
select 'arrayPushBack(arr1, val)';
select 'arrayPushBack(arr1, val2)';
select 'arrayPushBack([a, b, c], val)';
select 'arrayPushBack([a, b, c], val2)';
select 'arrayPopFront(arr1)';
select 'arrayPopBack(arr1)';
DROP TABLE if exists array_functions;
