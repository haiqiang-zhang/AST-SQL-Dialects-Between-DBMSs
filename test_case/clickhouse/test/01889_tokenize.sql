SET allow_experimental_nlp_functions = 1;
SELECT splitByNonAlpha('It is quite a wonderful day, isn\'t it?');
SELECT splitByNonAlpha('There is.... so much to learn!');
SELECT splitByNonAlpha('22:00 email@tut.by');
SELECT splitByNonAlpha('ÃÂ¢ÃÂ¾ÃÂºÃÂµÃÂ½ÃÂ¸ÃÂ·ÃÂ°ÃÂÃÂ¸ÃÂ ÃÂºÃÂ°ÃÂºÃÂ¸ÃÂ-ÃÂ»ÃÂ¸ÃÂ±ÃÂ¾ ÃÂ´ÃÂÃÂÃÂ³ÃÂ¸ÃÂ ÃÂÃÂ·ÃÂÃÂºÃÂ¾ÃÂ²?');
SELECT splitByWhitespace('It is quite a wonderful day, isn\'t it?');
SELECT splitByWhitespace('There is.... so much to learn!');
SELECT splitByWhitespace('22:00 email@tut.by');
SELECT splitByWhitespace('ÃÂ¢ÃÂ¾ÃÂºÃÂµÃÂ½ÃÂ¸ÃÂ·ÃÂ°ÃÂÃÂ¸ÃÂ ÃÂºÃÂ°ÃÂºÃÂ¸ÃÂ-ÃÂ»ÃÂ¸ÃÂ±ÃÂ¾ ÃÂ´ÃÂÃÂÃÂ³ÃÂ¸ÃÂ ÃÂÃÂ·ÃÂÃÂºÃÂ¾ÃÂ²?');
