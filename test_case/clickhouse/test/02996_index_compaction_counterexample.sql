select count() from b where x = 1 and y = 'b';
detach table b;
attach table b;
select count() from b where x = 1 and y = 'b';
DROP TABLE b;
