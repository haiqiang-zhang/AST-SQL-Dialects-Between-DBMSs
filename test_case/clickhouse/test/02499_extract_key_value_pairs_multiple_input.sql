-- basic tests

-- expected output: {'age':'31','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:neymar, age:31 team:psg,nationality:brazil') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'$nationality':'@brazil','1name':'neymar','4ge':'31','_team':'_psg'}
WITH
    extractKeyValuePairs('1name:neymar, 4ge:31 _team:_psg,$nationality:@brazil') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'#':'#','$':'$','@':'@','_':'_'}
WITH
    extractKeyValuePairs('_:_, @:@ #:#,$:$') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'3!','name':'ney!mar','nationality':'br4z!l','t&am':'@psg'}
WITH
    extractKeyValuePairs('name:ney!mar, age:3! t&am:@psg,nationality:br4z!l') AS s_map,
        CAST(
            arrayMap(
                (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
            ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'amount\\z':'$5\\h','currency':'\\$USD'}
WITH
    extractKeyValuePairs('currency:\$USD, amount\z:$5\h') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'key':'invalid_escape_sequence','valid_key':'valid_value'}
WITH
    extractKeyValuePairsWithEscaping('valid_key:valid_value key:invalid_escape_sequence\\', ':', ' ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- simple quoting
-- expected output: {'age':'31','name':'neymar','team':'psg'}
WITH
    extractKeyValuePairs('name:"neymar", "age":31 "team":"psg"') AS s_map,
        CAST(
            arrayMap(
                (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
            ),
        'Map(String,String)'
    ) AS x
SELECT
    x;
-- expected output: {'age':'','name':'','nationality':''}
WITH
    extractKeyValuePairs('name:"", age: , nationality:') AS s_map,
    CAST(
        arrayMap(
            (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
        ),
        'Map(String,String)'
    ) AS x
SELECT
    x;
-- empty keys are not allowed, thus empty output is expected
WITH
    extractKeyValuePairs('"":abc, :def') AS s_map,
    CAST(
        arrayMap(
            (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
        ),
        'Map(String,String)'
    ) AS x
SELECT
    x;
-- expected output: {'age':'31','anotherkey':'anothervalue','name':'neymar','random_key':'value_with_comma,still_part_of_value:still_part_of_value','team':'psg'}
WITH
    extractKeyValuePairs('name:neymar;
age:31;
team:psg;
random_key:value_with_comma,still_part_of_value:still_part_of_value;
anotherkey:anothervalue', ':', ';
') AS s_map,
    CAST(
        arrayMap(
            (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
        ),
        'Map(String,String)'
    ) AS x
SELECT
    x;
-- expected output: {'age':'31','last_key':'last_value','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:neymar;
age:31;
team:psg;
nationality:brazil,last_key:last_value', ':', ';
,') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'31','last_key':'last_value','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:\'neymar\';
\'age\':31;
team:psg;
nationality:brazil,last_key:last_value', ':', ';
,', '\'') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'31','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:neymar, age:31 team:psg,nationality:brazil', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'3!','name':'ney!mar','nationality':'br4z!l','t&am':'@psg'}
WITH
    extractKeyValuePairs('name:ney!mar, age:3! t&am:@psg,nationality:br4z!l', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'amount\\z':'$5\\h','currency':'\\$USD'}
WITH
    extractKeyValuePairs('currency:\$USD, amount\z:$5\h', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'key1':'header\nbody','key2':'start_of_text\tend_of_text'}
WITH
    extractKeyValuePairs('key1:header\nbody key2:start_of_text\tend_of_text', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- simple quoting
-- expected output: {'age':'31','name':'neymar','team':'psg'}
WITH
    extractKeyValuePairs('name:"neymar", "age":31 "team":"psg"', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'','name':'','nationality':''}
WITH
    extractKeyValuePairs('name:"", age: , nationality:', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- empty keys are not allowed, thus empty output is expected
WITH
    extractKeyValuePairs('"":abc, :def', ':', ', ', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'31','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:neymar;
age:31;
team:psg;
nationality:brazil', ':', ';
', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'31','last_key':'last_value','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:neymar;
age:31;
team:psg;
nationality:brazil,last_key:last_value', ':', ';
,', '"') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- expected output: {'age':'31','last_key':'last_value','name':'neymar','nationality':'brazil','team':'psg'}
WITH
    extractKeyValuePairs('name:\'neymar\';
\'age\':31;
team:psg;
nationality:brazil,last_key:last_value', ':', ';
,', '\'') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- cross parameter validation tests
-- should fail because key value delimiter conflicts with pair delimiters
WITH
    extractKeyValuePairs('not_important', ':', ',:', '\'') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because key value delimiter conflicts with quoting characters
WITH
    extractKeyValuePairs('not_important', ':', ',', '\':') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because pair delimiters conflicts with quoting characters
WITH
    extractKeyValuePairs('not_important', ':', ',', ',') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because data_column argument must be of type String
WITH
    extractKeyValuePairs([1, 2]) AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because key_value_delimiter argument must be of type String
WITH
    extractKeyValuePairs('', [1, 2]) AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because pair_delimiters argument must be of type String
WITH
    extractKeyValuePairs('', ':', [1, 2]) AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because quoting_character argument must be of type String
WITH
    extractKeyValuePairs('', ':', ' ', [1, 2]) AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because pair delimiters can contain at most 8 characters
WITH
    extractKeyValuePairs('not_important', ':', '123456789', '\'') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because no argument has been provided
WITH
    extractKeyValuePairs() AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- should fail because one extra argument / non existent has been provided
WITH
    extractKeyValuePairs('a', ':', ',', '"', '') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- Should fail allowed because it exceeds the max number of pairs
SET extract_key_value_pairs_max_pairs_per_row = 1;
WITH
    extractKeyValuePairs('key1:value1,key2:value2') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
-- { echoOn }

SET extract_key_value_pairs_max_pairs_per_row = 2;
-- expected output: {'key1':'value1','key2':'value2'}
WITH
    extractKeyValuePairs('key1:value1,key2:value2') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
SET extract_key_value_pairs_max_pairs_per_row = 0;
-- expected output: {'key1':'value1','key2':'value2'}
WITH
    extractKeyValuePairs('key1:value1,key2:value2') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
WITH
    extractKeyValuePairs('not_important', ':', '12345678', '\'') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
WITH
    extractKeyValuePairs('formula=1+2=3 argument1=1 argument2=2 result=3, char="=" char2== string="foo=bar"', '=') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
WITH
    extractKeyValuePairs('{"a":"1", "b":"2"}') as s_map,
    CAST(
        arrayMap(
            (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
        ),
        'Map(String,String)'
    ) AS x
SELECT
    x;
WITH
    sTr_tO_mAp('name:neymar, age:31 team:psg,nationality:brazil') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;
WITH
    mapFromString('name:neymar, age:31 team:psg,nationality:brazil') AS s_map,
    CAST(
            arrayMap(
                    (x) -> (x, s_map[x]), arraySort(mapKeys(s_map))
                ),
            'Map(String,String)'
        ) AS x
SELECT
    x;