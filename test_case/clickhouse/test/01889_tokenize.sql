SET allow_experimental_nlp_functions = 1;
SELECT splitByNonAlpha('It is quite a wonderful day, isn\'t it?');
SELECT splitByNonAlpha('There is.... so much to learn!');
SELECT splitByNonAlpha('22:00 email@tut.by');
SELECT splitByNonAlpha('Ð¢Ð¾ÐºÐµÐ½Ð¸Ð·Ð°ÑÐ¸Ñ ÐºÐ°ÐºÐ¸Ñ-Ð»Ð¸Ð±Ð¾ Ð´ÑÑÐ³Ð¸Ñ ÑÐ·ÑÐºÐ¾Ð²?');
SELECT splitByWhitespace('It is quite a wonderful day, isn\'t it?');
SELECT splitByWhitespace('There is.... so much to learn!');
SELECT splitByWhitespace('22:00 email@tut.by');
SELECT splitByWhitespace('Ð¢Ð¾ÐºÐµÐ½Ð¸Ð·Ð°ÑÐ¸Ñ ÐºÐ°ÐºÐ¸Ñ-Ð»Ð¸Ð±Ð¾ Ð´ÑÑÐ³Ð¸Ñ ÑÐ·ÑÐºÐ¾Ð²?');