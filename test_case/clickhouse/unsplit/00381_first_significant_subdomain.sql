SELECT
    firstSignificantSubdomain('http://hello.canada.ca') AS canada,
    firstSignificantSubdomain('http://hello.congo.com') AS congo,
    firstSignificantSubdomain('http://pochemu.net-domena.ru') AS why;
