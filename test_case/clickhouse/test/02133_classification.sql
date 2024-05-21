-- Tag no-fasttest: depends on cld2 and nlp-data

SET allow_experimental_nlp_functions = 1;
SELECT detectLanguage('ÐÐ½Ð¸ ÑÐ¾ÑÐ»Ð¸ÑÑ. ÐÐ¾Ð»Ð½Ð° Ð¸ ÐºÐ°Ð¼ÐµÐ½Ñ, Ð¡ÑÐ¸ÑÐ¸ Ð¸ Ð¿ÑÐ¾Ð·Ð°, Ð»ÐµÐ´ Ð¸ Ð¿Ð»Ð°Ð¼ÐµÐ½Ñ, ÐÐµ ÑÑÐ¾Ð»Ñ ÑÐ°Ð·Ð»Ð¸ÑÐ½Ñ Ð¼ÐµÐ¶ ÑÐ¾Ð±Ð¾Ð¹.');
SELECT detectLanguage('Sweet are the uses of adversity which, like the toad, ugly and venomous, wears yet a precious jewel in his head.');
SELECT detectLanguage('A vaincre sans peril, on triomphe sans gloire.');
SELECT detectLanguage('äºåãè¿½ãèã¯ä¸åããå¾ã');
SELECT detectLanguage('ææé¥®æ°´é¥±ï¼æ æé£é¥­é¥¥ã');
SELECT detectLanguage('*****///// _____ ,,,,,,,, .....');
SELECT detectLanguageMixed('äºåãè¿½ãèã¯ä¸åããå¾ãäºåãè¿½ãèã¯ä¸åããå¾ã A vaincre sans peril, on triomphe sans gloire.');
SELECT detectLanguageMixed('ì´ëë  ê°ì¹ê° ìë ê³³ì¼ë¡ ê°ë ¤ë©´ ì§ë¦ê¸¸ì ìë¤');
SELECT detectLanguageMixed('*****///// _____ ,,,,,,,, .....');
SELECT detectCharset('Plain English');
SELECT detectLanguageUnknown('Plain English');
SELECT detectTonality('Ð¼Ð¸Ð»Ð°Ñ ÐºÐ¾ÑÐºÐ°');
SELECT detectTonality('Ð½ÐµÐ½Ð°Ð²Ð¸ÑÑÑ Ðº Ð»ÑÐ´ÑÐ¼');
SELECT detectTonality('Ð¾Ð±ÑÑÐ½Ð°Ñ Ð¿ÑÐ¾Ð³ÑÐ»ÐºÐ° Ð¿Ð¾ Ð±Ð»Ð¸Ð¶Ð°Ð¹ÑÐµÐ¼Ñ Ð¿Ð°ÑÐºÑ');
SELECT detectProgrammingLanguage('#include <iostream>');