--     of C in S and return the resulting string.
-- R2. escape(C,S) shall preserve leading and trailing whitespace in S.
-- R3. escape(C,S) shall work if S is empty.
-- R4. escape(C,S) shall work when C or S contains parentheses or commas, and
--     when S contains newlines.
-- R5. escape(C,S) shall work when C is multi-character.
-- R6. escape(C,S) shall fail when C is newline.
-- R7. escape shall fail when the parentheses or comma are wrong.

--echo ==== R1: escape inserts backslash before character ====

--let $x = foo bar baz
--let $y = escape(a,$x)
--assert($x == foo bar baz)
--assert($y == foo b\ar b\az)
--let $x = '"\f\o\o"'
--let $y = escape(\,$x)
--let $z = escape(",$y)
--let $w = escape(',$z)
--echo <$y>
--echo <$z>
--echo <$w>

--echo ==== R2: escape preserves leading and trailing whitespace ====

--let $x = escape(a, haha )
--echo <$x>

--let $s = `SELECT ' '`
--let $x = escape( , $s )
--echo <$x>

--echo ==== R3: escape(C,S) shall work if S is empty  ====

--let $x = escape(a,)
--echo <$x>

--echo ==== R4.1: escape(C,S) shall work when C or S contains parentheses ====

--let $x = escape(h, hihi (haha))
--echo <$x>
--let $x = escape(), hihi (haha))
--echo <$x>
--let $x = escape((, hihi (haha))
--echo <$x>

--echo ==== R4.2: escape(C,S) shall work when C or S contains comma ====

--let $x = escape(u,,x,)
--echo <$x>
--let $x = escape(,,,x,)
--echo <$x>

--echo ==== R4.3: escape(C,S) shall work when S contains newline ====

--let $nl = `SELECT '\n'`
let $x = escape(h,$nl$nl$sa
hoho
huhu$nl$nl);
let $x = escape(
,
foo
);
