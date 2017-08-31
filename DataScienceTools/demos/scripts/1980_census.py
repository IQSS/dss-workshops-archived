with open('data/1980_census.txt', 'r') as f:
    data = f.readlines()

with open('output/1980_census_sum2.tex', 'w') as f:
    f.write('{:,}'.format(sum(map(int, data))))
