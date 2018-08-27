import numpy as np
from scipy import stats

## function to simulate data and perform a t.test
def sim_ttest(mu1, mu2, sd, n1, n2):
    x = stats.norm.rvs(loc = mu1, scale = sd, size = n1)
    y = stats.norm.rvs(loc = mu2, scale = sd, size = n2)
    return(stats.ttest_ind(x, y)[1])

##  run the function 10,000 times
nsims = 10000
p = [sim_ttest(1, 1.3, 1, 50, 150)  for x in range(nsims)]
## calculate proportion of significant tests
print(len([x for x in p if x < .05])/nsims)
