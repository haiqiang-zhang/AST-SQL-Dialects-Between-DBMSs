SELECT toUInt128(toUUID('00000000-0000-0000-0000-000000000000'));
SELECT toUInt128(toUUID('f82aef31-279e-431f-8b00-2899ad387aea'));
SELECT toUInt128(toUUID('ffffffff-ffff-ffff-ffff-ffffffffffff'));
SELECT cast(toUUID('f82aef31-279e-431f-8b00-2899ad387aea'), 'UInt128');
select accurateCast(toUUID('f82aef31-279e-431f-8b00-2899ad387aea'), 'UInt128');
select toUUID('f82aef31-279e-431f-8b00-2899ad387aea')::UInt128;