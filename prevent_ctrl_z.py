
def unicode_string_to_binary(input_string):
    return ' '.join(f"{byte:08b}" for byte in input_string.encode('utf-8'))

s = "ÅUB 2010', 'DD TMMON YYYY');"
binary_s = unicode_string_to_binary(s)
print(binary_s)

print(s)