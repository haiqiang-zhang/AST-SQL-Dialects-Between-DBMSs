PRAGMA enable_verification;
CREATE TABLE tbl1(col VARCHAR);;
INSERT INTO tbl1 (VALUES ('{a:1, b:3}'));;
CREATE TABLE tbl2(col VARCHAR);;
INSERT INTO tbl2 (VALUES ('{a:1, b:"hello, world"}'));;
CREATE TABLE tbl3(col VARCHAR);;
INSERT INTO tbl3 (VALUES ('{a:DUCK, b:9.999, c:12}'), ('{a:"DB", b:1.111, c:21}'));;
CREATE TABLE tbl4(col VARCHAR);;
INSERT INTO tbl4 (VALUES ('{a:{b:1}}'));;
SELECT '{  key_A:     2, key_B: {key_C: hello world    }     X   }'::STRUCT(key_A INT, key_B STRUCT(key_C VARCHAR));;
CREATE TABLE try_cast_tbl(col VARCHAR);;
INSERT INTO try_cast_tbl (VALUES ('{a:{d:1}, b:100, c:"🦆"}'), ('{a:{X:1}, b:100, c:"🦆"}'), ('{a:{d:1}, b:100, X:"🦆"}'), ('{a:"oh oh", b:100, c:"🦆"}'), ('{a:{d:"oops"}, b:100, c:"🦆"}'), ('{a:{d:"oops"}, b:100, Z: "undercover", c:"🦆"}'));;
SELECT CAST('[{a:3}]' AS STRUCT(a INT));;
SELECT CAST('Hello World' AS STRUCT(a VARCHAR));;
SELECT CAST('{a: 3}}' AS STRUCT(a INT));;
SELECT CAST('{a: 3, b:{c: 8}}}' AS STRUCT(a INT, b STRUCT(c INT)));;
SELECT CAST('{{a: 3}' AS STRUCT(a INT));;
SELECT CAST('{a:3}, {b:1}' AS STRUCT(a INT, b INT));;
SELECT CAST('{a:{a:3}, b:{{b:1}}}' AS STRUCT(a STRUCT(a INT), b STRUCT(b INT)));;
SELECT CAST('{a: 3 1}' AS STRUCT(a INT));;
SELECT CAST('{a:3,, b:1}' AS STRUCT(a INT, b INT));;
SELECT CAST('}{a:5}' AS STRUCT(a INT));;
SELECT CAST('{a:{b:{d: 800}, {c: "Duck"}}}' AS STRUCT(a STRUCT(b STRUCT(d INT), c STRUCT(c VARCHAR))));;
SELECT CAST('{[{]}}' AS STRUCT(a VARCHAR[]));;
CREATE TABLE tbl(col VARCHAR);;
INSERT INTO tbl (VALUES ('{a:DUCK, b:12}'), ('{a:"DB", b:21}'), ('{a:"Quack", b:2}'));;
CREATE TABLE assorted_structs(col1 STRUCT(a INT, b VARCHAR));;
COPY (SELECT '{a: 8, b: "hello, DuckDB"}') TO '__TEST_DIR__/assorted_structs.csv';;
COPY assorted_structs FROM '__TEST_DIR__/assorted_structs.csv';;
CREATE TABLE json_tbl(col1 VARCHAR);;
INSERT INTO json_tbl (VALUES ('{
    "id": "0001",
    "type": "donut",
    "name": "Cake",
    "ppu": 0.55,
    "batters":
        {
            "batter":
                [
                    { "id": "1001", "type": "Regular" },
                    { "id": "1002", "type": "Chocolate" },
                    { "id": "1003", "type": "Blueberry" },
                    { "id": "1004", "type": "Devil''s Food" }
                ]
        },
    "topping":
        [
            { "id": "5001", "type": "None" },
            { "id": "5002", "type": "Glazed" },
            { "id": "5005", "type": "Sugar" },
            { "id": "5007", "type": "Powdered Sugar" },
            { "id": "5006", "type": "Chocolate with Sprinkles" },
            { "id": "5003", "type": "Chocolate" },
            { "id": "5004", "type": "Maple" }
        ]
}'));;
CREATE TABLE json_tbl2(col1 JSON);;
INSERT INTO json_tbl2 (VALUES   ('{"A": "Ducky", "B": [3, 50, 8, 43], "C":{"A": "TEST", "B": 0.9, "C": [0.0, 9, 30.2]} }' ), 
                                ('{"A": "TESTY", "B": [4], "C":{"A": "🦆", "B": 6.12, "C": [0.099, 1.6]} }' ),
                                ('{"A": "Hello World", "B": [0, 0, 2, 500, 0, 8], "C":{"A": "DuckieDuck !", "B": 3000, "C": [0]} }' ),
                                ('{"A": "", "B": [], "C":{"A": "", "B": 0, "C": []} }' ));;
SELECT '{key_A:0}'::STRUCT(key_A INT);;
SELECT '{key_A: 2, key_B: 46, key_C: -3000}'::STRUCT(key_A INT, key_B INT, key_C INT);;
SELECT '{key_A: 2, key_B: 3, key_C: 8}'::STRUCT(key_A INT, key_B DOUBLE, key_C FLOAT);;
SELECT '{"key_A": 2, "key_B": hello world}'::STRUCT(key_A INT, key_B VARCHAR);;
select (struct_pack(key_A=>'42'::double, key_B=>'DuckDB'::string)::VARCHAR)::STRUCT(key_A INT, key_B VARCHAR);;
SELECT '{🦆: Quack, 🦤: ....}'::STRUCT(🦆 VARCHAR, 🦤 VARCHAR);;
SELECT '{a:{c:1}, b:900}'::STRUCT(a STRUCT(c INT), b INT);;
SELECT '{a:{b:DuckDB, c:12}, b:900, c:{a:"DuckParty"}}'::STRUCT(a STRUCT(b VARCHAR, c INT), b INT, c STRUCT(a VARCHAR));;
SELECT '{a:{b:DuckDB, c:{a:{a:0.9, b:{a:"DuckieDuck"}, c:{a:9000}, d:{a:5881580-07-10}}, b:"🦆"}}, b:900, c:{a:"DuckParty"}}'::STRUCT(a STRUCT(b VARCHAR, c STRUCT(a STRUCT(a FLOAT, b STRUCT(a VARCHAR), c STRUCT(a INT), d STRUCT(a DATE)), b VARCHAR)), b INT, c STRUCT(a VARCHAR));;
SELECT CAST('{a:{b:{c:{d:{e:{f:"Hello World"}}}}}}' AS STRUCT(a STRUCT(b STRUCT(c STRUCT(d STRUCT(e STRUCT(f VARCHAR)))))));;
SELECT col::STRUCT(a INT, b INT) FROM tbl1;;
SELECT col::STRUCT(a INT, b VARCHAR) FROM tbl2;;
SELECT col::STRUCT(a VARCHAR, b FLOAT, c INT) FROM tbl3;;
SELECT col::STRUCT(a STRUCT(b INT)) FROM tbl4;;
SELECT '{key_A: [2, 3, 4], key_B: [Hello, World]}'::STRUCT(key_A INT[], key_B VARCHAR[]);;
SELECT '{key_A: [[2, 3], [4]], key_B: [Hello, World]}'::STRUCT(key_A INT[][], key_B VARCHAR[]);;
SELECT '{key_A: [[{a: 5, b: 900}, {a:3, b:34}], [{a:2, b: 0}]], key_B: [Hello, World]}'::STRUCT(key_A STRUCT(a INT, b INT)[][], key_B VARCHAR[]);;
SELECT '{key_B: 2, key_A: 46}'::STRUCT(key_A INT, key_B INT);;
SELECT '{c:{a:"DuckParty"}, b:900, a:{b:DuckDB, c:{a:{a:0.9, b:{a:"DuckieDuck"}, c:{a:9000}, d:{a:5881580-07-10}}, b:"🦆"}}}'::STRUCT(a STRUCT(b VARCHAR, c STRUCT(a STRUCT(a FLOAT, b STRUCT(a VARCHAR), c STRUCT(a INT), d STRUCT(a DATE)), b VARCHAR)), b INT, c STRUCT(a VARCHAR));;
SELECT '{key_D: "World Hello", key_B: [Hello, World], key_C : 5000, key_A: [[{a: 5, b: 900}, {a:3, b:34}], [{a:2, b: 0}]]}'::STRUCT(key_A STRUCT(a INT, b INT)[][], key_B VARCHAR[], key_C INT, key_D VARCHAR);;
SELECT ('{a: "can''t", b: "you''re", c: "i''m"}'::STRUCT(a VARCHAR, b VARCHAR, c VARCHAR));;
SELECT ('{a:"}", b: hello universe}'::STRUCT(a VARCHAR, b VARCHAR));;
SELECT ('{a:''}'', b: "hello world"}'::STRUCT(a VARCHAR, b VARCHAR));;
SELECT '{  key_A:     2, key_B: hello world    }'::STRUCT(key_A INT, key_B VARCHAR);;
SELECT '    {a:        {b:         DuckDB,    c:12  }, b:  900, c          :{a
                    :   "DuckParty  "}       }    '::STRUCT(a STRUCT(b VARCHAR, c INT), b INT, c STRUCT(a VARCHAR));;
SELECT '{key_A     : [      [{      a: 5    , b  : 900          }, { a: 3, b:    34}],      [   {a:
                2, b: 0    }    ] ],     key_B: [Hello       , World]   }'::STRUCT(key_A STRUCT(a INT, b INT)[][], key_B VARCHAR[]);;
SELECT '{a  :  {c   : 9000}, b    : NULL
                                            , c:{ d: "Ducky", e:        NULL     }       }     '::STRUCT(a STRUCT(c INT), b VARCHAR, c STRUCT(d VARCHAR, e DOUBLE));;
SELECT ' {      }   '::STRUCT(a INT, b DATE);;
SELECT CAST(NULL AS STRUCT(a INT));;
SELECT '{a: NULL}'::STRUCT(a VARCHAR);;
SELECT '{a:12, b:NULL}'::STRUCT(a INT, b INT);;
SELECT '{a:{c: NULL}, b: NULL, c:{d: "Ducky", e: NULL}}'::STRUCT(a STRUCT(c INT), b VARCHAR, c STRUCT(d VARCHAR, e DOUBLE));;
SELECT '{key_A: 2, key_C: 8}'::STRUCT(key_A INT, key_B INT, key_C FLOAT);;
SELECT '{key_C: 8, key_A: 2}'::STRUCT(key_A INT, key_B DOUBLE, key_C FLOAT);;
SELECT '{key_C: Quack}'::STRUCT(key_A INT, key_B VARCHAR, key_C VARCHAR);;
SELECT {'key_C': 2, 'key_A': 4}::VARCHAR::STRUCT(key_A INT, key_B VARCHAR, key_C VARCHAR);;
SELECT '{key_A:0}'::STRUCT(key_A INT, key_B VARCHAR);;
SELECT '{key_C: {key_B: 3, key_E: 🦆}, key_A: 2}'::STRUCT(key_A INT, key_C STRUCT(key_B INT, key_D INT, key_E VARCHAR));;
SELECT '{a:{b:{b:300}, c:12}, c:{a:"DuckParty"}}'::STRUCT(a STRUCT(b STRUCT(a INT, b VARCHAR), c INT), b INT, c STRUCT(a VARCHAR, b STRUCT(a INT)));;
SELECT '{}'::STRUCT(a INT, b VARCHAR);;
SELECT TRY_CAST('{key_B: "hello", key_Z: 2, key_A: 46}' AS STRUCT(key_A INT, key_B VARCHAR));;
SELECT TRY_CAST('{key_B: "hello", key_Z: 2, key_A: 46}' AS STRUCT(key_A INT, key_B VARCHAR, key_C INT));;
SELECT TRY_CAST('{key_B: "hello", key_A: 46}' AS STRUCT(key_A INT, key_B INT));;
SELECT TRY_CAST('{a:4, b:''Ducky'', c:''🦆''}' AS STRUCT(a INT, b DOUBLE, c VARCHAR));;
SELECT TRY_CAST(col AS STRUCT(a STRUCT(d INT), b DOUBLE, c VARCHAR)) FROM try_cast_tbl;;
SELECT cast(col as STRUCT(a VARCHAR, b INT)).a FROM tbl WHERE cast(col as STRUCT(a VARCHAR, b INT)).b=12;;
SELECT * FROM assorted_structs;;
SELECT col1::STRUCT(id VARCHAR, type VARCHAR, name VARCHAR, ppu FLOAT, 
    batters STRUCT(batter STRUCT(id VARCHAR, type VARCHAR)[]), topping STRUCT(id VARCHAR, type VARCHAR)[]) FROM json_tbl;;
SELECT col1::VARCHAR::STRUCT(A VARCHAR, B INT[], C STRUCT(A VARCHAR, B FLOAT, C DOUBLE[])) FROM json_tbl2;;
