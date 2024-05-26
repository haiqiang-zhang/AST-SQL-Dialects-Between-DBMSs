select count() from b where x = 1 and y = 'b';
detach table b;
attach table b;
DROP TABLE b;
