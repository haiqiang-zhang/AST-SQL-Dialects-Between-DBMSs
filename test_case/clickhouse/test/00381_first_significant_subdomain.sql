SELECT
    firstSignificantSubdomain('http://hello.canada.ca') AS canada,
    firstSignificantSubdomain('http://hello.congo.com') AS congo,
    firstSignificantSubdomain('http://pochemu.net-domena.ru') AS why;
SELECT
    firstSignificantSubdomain('ftp://www.meta.com.ua/news.html'),
    firstSignificantSubdomain('https://www.bigmir.net/news.html'),
    firstSignificantSubdomain('magnet:ukr.abc'),
    firstSignificantSubdomain('ftp://www.yahoo.co.jp/news.html'),
    firstSignificantSubdomain('https://api.www3.static.dev.ÃÂÃÂÃÂÃÂ²ÃÂÃÂÃÂÃÂ²ÃÂÃÂÃÂÃÂ².ÃÂÃÂÃÂÃÂ³ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ³ÃÂÃÂÃÂÃÂ».ÃÂÃÂÃÂÃÂºÃÂÃÂÃÂÃÂ¾ÃÂÃÂÃÂÃÂ¼'),
    firstSignificantSubdomain('//www.meta.com.ua/news.html');
SELECT
    firstSignificantSubdomain('http://hello.canada.c'),
    firstSignificantSubdomain('http://hello.canada.'),
    firstSignificantSubdomain('http://hello.canada'),
    firstSignificantSubdomain('http://hello.c'),
    firstSignificantSubdomain('http://hello.'),
    firstSignificantSubdomain('http://hello'),
    firstSignificantSubdomain('http://'),
    firstSignificantSubdomain('http:/'),
    firstSignificantSubdomain('http:'),
    firstSignificantSubdomain('http'),
    firstSignificantSubdomain('h'),
    firstSignificantSubdomain('.'),
    firstSignificantSubdomain(''),
    firstSignificantSubdomain('http://hello.canada..com'),
    firstSignificantSubdomain('http://hello..canada.com'),
    firstSignificantSubdomain('http://hello.canada.com.');
