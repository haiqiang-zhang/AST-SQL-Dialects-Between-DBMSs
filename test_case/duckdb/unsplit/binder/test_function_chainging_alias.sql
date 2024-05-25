PRAGMA enable_verification;
CREATE TABLE varchars(v VARCHAR);;
INSERT INTO varchars VALUES ('>>%Test<<'), ('%FUNCTION%'), ('Chaining');
SELECT  v.trim('><') as trim_inequality,
        only_alphabet.lower() as lower
        trim_inequality.replace('%', '') as only_alphabet,
FROM varchars;
DELETE FROM varchars;
INSERT INTO varchars VALUES ('Test Function Chainging Alias');;
PREPARE v1 AS 
SELECT (?.split(' ')::VARCHAR).lower() lstrings,
       (?.split(' ')::VARCHAR).upper() ustrings,
       list_concat(lstrings::VARCHAR[], ustrings::VARCHAR[]) as mix_case_srings;
SELECT 'test' || ' more testing' as added,
        added.substr(5) as my_substr;
SELECT v.lower() FROM varchars;
SELECT  v.trim('><') as trim_inequality,
        trim_inequality.replace('%', '') as only_alphabet,
        only_alphabet.lower() as lower
FROM varchars;
SELECT  varchars.v.trim('><') as trim_inequality,
        trim_inequality.replace('%', '') as only_alphabet,
        only_alphabet.lower() as lower
FROM varchars;
SELECT  v.split(' ')::VARCHAR strings,
        strings.lower() lower,
        lower.upper() upper
FROM varchars;
SELECT  v.split(' ') strings,
        strings.apply(x -> x.lower()).filter(x -> x[1] == 't') lower,
        strings.apply(x -> x.upper()).filter(x -> x[1] == 'T') upper,
        lower + upper  as mix_case_srings
FROM varchars;
EXECUTE v1('Hello World', 'test function chainging');
