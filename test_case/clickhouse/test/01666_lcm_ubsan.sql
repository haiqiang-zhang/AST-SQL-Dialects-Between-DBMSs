SELECT lcm(9223372036854775807, -9223372036854775808);
SELECT lcm(9223372036854775808, -9223372036854775807);
SELECT lcm(-9223372036854775808, 9223372036854775807);
SELECT lcm(-9223372036854775807, 9223372036854775808);
SELECT lcm(9223372036854775808, -1);
SELECT lcm(-170141183460469231731687303715884105728, -170141183460469231731687303715884105728);
SELECT lcm(toInt128(-170141183460469231731687303715884105728), toInt128(-170141183460469231731687303715884105728));
SELECT lcm(toInt128(-170141183460469231731687303715884105720), toInt128(-170141183460469231731687303715884105720));
SELECT lcm(toInt128('-170141183460469231731687303715884105720'), toInt128('-170141183460469231731687303715884105720'));
SELECT lcm(-9223372036854775806, -9223372036854775806);