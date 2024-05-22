SELECT
    encodeURLComponent('ÃÂÃÂºÃÂÃÂ»ÃÂÃÂ¸ÃÂÃÂºÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂ') AS encoded,
    decodeURLComponent(encoded) = 'ÃÂÃÂºÃÂÃÂ»ÃÂÃÂ¸ÃÂÃÂºÃÂÃÂÃÂÃÂ°ÃÂÃÂÃÂÃÂ' AS expected_EQ;
SELECT DISTINCT decodeURLComponent(encodeURLComponent(randomString(100) AS x)) = x FROM numbers(100000);
