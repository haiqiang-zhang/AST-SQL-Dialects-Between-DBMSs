SELECT '\x01\x00'::AggregateFunction(groupBitmap, UInt32);
SELECT '\x01\x01\x01'::AggregateFunction(groupBitmap, UInt64);
SELECT '\x02\x00\x0d'::AggregateFunction(topK, UInt256);
SELECT unhex('bebebebebebebebebebebebebebebebebebebebebebebebebebebebebebebe0c0c3131313131313131313131313173290aee00b300')::AggregateFunction(minDistinct, Int8);
SELECT unhex('01000b0b0b0d0d0d0d7175616e74696c6554696d696e672c20496e743332000300')::AggregateFunction(quantileTiming, Int32);
SELECT unhex('010001')::AggregateFunction(quantileTiming, Int32);
SELECT unhex('0a00797979797979797979790a0a6e')::AggregateFunction(minForEach, Ring);