-- Tag no-fasttest: depends on libstemmer_c

SET allow_experimental_nlp_functions = 1;
SELECT stem('en', 'given');
SELECT stem('en', 'combinatorial');
SELECT stem('en', 'collection');
SELECT stem('en', 'possibility');
SELECT stem('en', 'studied');
SELECT stem('en', 'commonplace');
SELECT stem('en', 'packing');
SELECT stem('ru', 'ÃÂºÃÂ¾ÃÂ¼ÃÂ±ÃÂ¸ÃÂ½ÃÂ°ÃÂÃÂ¾ÃÂÃÂ½ÃÂ¾ÃÂ¹');
SELECT stem('ru', 'ÃÂ¿ÃÂ¾ÃÂ»ÃÂÃÂÃÂ¸ÃÂ»ÃÂ°');
SELECT stem('ru', 'ÃÂ¾ÃÂ³ÃÂÃÂ°ÃÂ½ÃÂ¸ÃÂÃÂµÃÂ½ÃÂ°');
SELECT stem('ru', 'ÃÂºÃÂ¾ÃÂ½ÃÂµÃÂÃÂ½ÃÂ¾ÃÂ¹');
SELECT stem('ru', 'ÃÂ¼ÃÂ°ÃÂºÃÂÃÂ¸ÃÂ¼ÃÂ°ÃÂ»ÃÂÃÂ½ÃÂ¾ÃÂ¹');
SELECT stem('ru', 'ÃÂÃÂÃÂ¼ÃÂ¼ÃÂ°ÃÂÃÂ½ÃÂÃÂ¹');
SELECT stem('ru', 'ÃÂÃÂÃÂ¾ÃÂ¸ÃÂ¼ÃÂ¾ÃÂÃÂÃÂÃÂ');
SELECT stem('fr', 'remplissage');
SELECT stem('fr', 'valeur');
SELECT stem('fr', 'maximiser');
SELECT stem('fr', 'dÃÂ©passer');
SELECT stem('fr', 'intensivement');
SELECT stem('fr', 'ÃÂ©tudiÃÂ©');
SELECT stem('fr', 'peuvent');
