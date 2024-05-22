SELECT lowerUTF8(arrayJoin(['ÃÂÃÂ©--------------------------------------', 'ÃÂÃÂ©--------------------'])) ORDER BY 1;
SELECT upperUTF8(materialize('aaaaÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂaaaaaaaaaaaaÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂAAAAaaAA')) FROM numbers(2);
