SELECT sqrt(-1) as x, not(x), not(not(x)), (not(x)) IS NULL SETTINGS allow_experimental_analyzer=1;
