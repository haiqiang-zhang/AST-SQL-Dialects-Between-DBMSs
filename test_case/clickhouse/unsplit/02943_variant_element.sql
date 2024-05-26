set allow_experimental_variant_type=1;
set use_variant_as_common_type=1;
select variantElement(NULL::Variant(String, UInt64), 'UInt64') from numbers(4);
