select * from bx, ax where ax.A = bx.A and ax.B in (1,2);
drop table ax;
drop table bx;
