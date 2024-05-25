WITH c(x) AS (VALUES('{a:5,b:6}'))
  SELECT x->>'a', json(x), json_valid(x), NOT json_error_position(x) FROM c;
SELECT '[7,null,{a:5,b:6},[8,9]]'->>'$[2].b';
SELECT '{ $123 : 789 }'->>'$."$123"';
SELECT '{ _123$xyz : 789 }'->>'$."_123$xyz"';
SELECT '{ MNO_123$xyz : 789 }'->>'$."MNO_123$xyz"';
SELECT json('{ MNO_123$xyz : 789 }');
SELECT '{ MNO_123ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¦xyz : 789 }'->>'MNO_123ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¦xyz';
WITH c(x) AS (VALUES('{"a":5, "b":6, }'))
  SELECT x->>'b', json(x), json_valid(x), NOT json_error_position(x) FROM c;
SELECT '{a:5, b:6 , }'->>'b';
WITH c(x) AS (VALUES('[5, 6,]'))
  SELECT x->>1, json(x), json_valid(x), NOT json_error_position(x) FROM c;
SELECT '[5, 6 , ]'->>1;
WITH c(x) AS (VALUES('{"a": ''abcd''}'))
  SELECT x->>'a', json(x), json_valid(x), NOT json_error_position(x) FROM c;
SELECT '{b: 123, ''a'': ''ab\''cd''}'->>'a';
WITH c(x) AS (VALUES('{a: "abc'||char(0x5c,0x0a)||'xyz"}'))
  SELECT x->>'a', json(x), json_valid(x), NOT json_error_position(x) FROM c;
SELECT ('{a: "abc'||char(0x5c,0x0d)||'xyz"}')->>'a';
SELECT ('{a: "abc'||char(0x5c,0x0d,0x0a)||'xyz"}')->>'a';
SELECT ('{a: "abc'||char(0x5c,0x2028)||'xyz"}')->>'a';
SELECT ('{a: "abc'||char(0x5c,0x2029)||'xyz"}')->>'a';
SELECT ('{a: "abc'||char(0x5c,0x27)||'xyz"}')->>'a';
SELECT ('{a: "abc'||char(0x5c,0x22)||'xyz"}')->>'a';
SELECT ('{a: "abc'||char(0x5c,0x5c)||'xyz"}')->>'a';
SELECT hex(('{a: "abc\bxyz"}')->>'a');
SELECT hex(('{a: "abc\f\n\r\t\vxyz"}')->>'a');
SELECT hex(('{a: "abc\0xyz"}')->>'a');
SELECT '{a: "abc\x35\x4f\x6Exyz"}'->>'a';
SELECT '{a: "\x6a\x6A\x6b\x6B\x6c\x6C\x6d\x6D\x6e\x6E\x6f\x6F"}'->>'a';
SELECT '{a: 0x0}'->>'a';
SELECT '{a: -0x0}'->>'a';
SELECT '{a: +0x0}'->>'a';
SELECT '{a: 0xabcdef}'->>'a';
SELECT '{a: -0xaBcDeF}'->>'a';
SELECT '{a: +0xABCDEF}'->>'a';
WITH c(x) AS (VALUES('{x: 4.}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: +4.}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: -4.}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: .5}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: -.5}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: +.5}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: 4.e0}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: +4.e1}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: -4.e2}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: .5e3}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: -.5e-1}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: +.5e-2}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: +Infinity}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: -Infinity}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: Infinity}')) SELECT x->>'x', json(x) FROM c;
WITH c(x) AS (VALUES('{x: NaN}')) SELECT x->>'x', json(x) FROM c;
SELECT '{a: +123}'->'a';
SELECT ' /* abc */ { /*def*/ aaa /* xyz */ : // to the end of line
          123 /* xyz */ , /* 123 */ }'->>'aaa';
SELECT (char(0x09,0x0a,0x0b,0x0c,0x0d,0x20,0xa0,0x2028,0x2029)
          || '{a: "xyz"}')->>'a';
SELECT ('{a:' || char(0x09,0x0a,0x0b,0x0c,0x0d,0x20,0xa0,0x2028,0x2029)
          || '"xyz"}')->>'a';
SELECT (char(0x1680,0x2000,0x2001,0x2002,0x2003,0x2004,0x2005,
               0x2006,0x2007,0x2008,0x2009,0x200a,0x3000,0xfeff)
          || '{a: "xyz"}')->>'a';
SELECT ('{a: ' ||char(0x1680,0x2000,0x2001,0x2002,0x2003,0x2004,0x2005,
                        0x2006,0x2007,0x2008,0x2009,0x200a,0x3000,0xfeff)
          || ' "xyz"}')->>'a';
SELECT json('{x:''a "b" c''}');
