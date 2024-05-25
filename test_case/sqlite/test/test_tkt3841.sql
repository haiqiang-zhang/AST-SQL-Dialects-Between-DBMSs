SELECT
      table2.x,
      (SELECT group_concat(list.value)
        FROM list
        WHERE list.key = table2.key)
    FROM table2;
