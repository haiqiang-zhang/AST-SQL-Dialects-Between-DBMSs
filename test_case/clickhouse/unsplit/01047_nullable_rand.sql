select toTypeName(rand(cast(4 as Nullable(UInt8))));
select rand(cast(4 as Nullable(UInt8))) * 0;
select randCanonical(cast(4 as Nullable(UInt8))) * 0;
select randConstant(CAST(4 as Nullable(UInt8))) * 0;
select rand(Null) * 0;
select randCanonical(Null) * 0;
select randConstant(Null) * 0;
