select bin('');
select unbin('');
select unbin('0') == '\0';
select unbin(bin('')) == '';
select bin(unbin('')) == '';
select bin(unbin('0')) == '00000000';
select hex('') == bin('');
select unhex('') == unbin('');
select unhex('0') == unbin('0');
select hex(sumState(number)) == hex(toString(sumState(number))) from numbers(10);
select hex(avgState(number)) from numbers(10);
select bin(avgState(number)) from numbers(10);
