SELECT CAST(materialize(CAST(NULL, 'Nullable(Enum(\'A\' = 1, \'B\' = 2))')), 'Nullable(String)');
