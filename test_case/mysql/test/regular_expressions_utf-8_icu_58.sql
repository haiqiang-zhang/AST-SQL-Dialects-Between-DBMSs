SELECT regexp_like( 'abc\n123\n456\nxyz\n', '(?m)^\\d+\\R\\d+$' );
SELECT regexp_like( 'a\nb', 'a\\vb' );
