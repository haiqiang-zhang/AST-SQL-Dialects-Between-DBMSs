SELECT range(null);
SELECT range(10, null);
SELECT range(10, 2, null);
select range('string', Null);
SELECT range(toNullable(1));
SELECT range(0::Nullable(UInt64), 10::Nullable(UInt64), 2::Nullable(UInt64));
SELECT range(0::Nullable(Int64), 10::Nullable(Int64), 2::Nullable(Int64));
SELECT range(materialize(0), 10::Nullable(UInt64), 2::Nullable(UInt64));
