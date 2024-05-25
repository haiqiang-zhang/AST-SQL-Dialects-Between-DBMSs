SELECT
    `ÃÂÃÂ¦ÃÂÃÂÃÂÃÂ¥ÃÂÃÂ¦ÃÂÃÂÃÂÃÂ`,
    location.name,
    store.`ÃÂÃÂ§ÃÂÃÂÃÂÃÂ¶ÃÂÃÂ¦ÃÂÃÂÃÂÃÂ`
FROM sales
LEFT JOIN store ON store.id = `ÃÂÃÂ¥ÃÂÃÂºÃÂÃÂÃÂÃÂ©ÃÂÃÂÃÂÃÂº`
LEFT JOIN location ON location.id = `ÃÂÃÂ¥ÃÂÃÂÃÂÃÂ°ÃÂÃÂ¥ÃÂÃÂÃÂÃÂ`
ORDER BY 1, 2, 3;
DROP TABLE store;
DROP TABLE location;
DROP TABLE sales;
