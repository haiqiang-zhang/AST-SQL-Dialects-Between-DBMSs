import sqlparse


sqll = """
explain (costs off) select * from pg_proc where proname ~ 'abc';
"""




l = sqlparse.split(sqll)

first = l[-1]

print(first)
parsed = sqlparse.parse(first)[0]

print(parsed.tokens)



