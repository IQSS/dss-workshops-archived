## retrieve arguments passed from the command line.
process <- as.integer(as.character(commandArgs(trailingOnly = TRUE)))

## map process to sample size parameter.
n <- (process + 100) + (process*10 - process)

## function to simulate data and perform a t.test
  sim.ttest <- function(mu1, mu2, sd, n1, n2) {
      d <- data.frame(x = c(rep("group1", n1), rep("group2", n2)),
                      y = c(rnorm(n1, mean = mu1, sd = sd),
                            rnorm(n2, mean = mu2, sd = sd)))
      return(t.test(y ~ x, data = d)$p.value)
  }

  ##  run the function 10,000 times 
  p <- replicate(10000,
                 sim.ttest(mu1 = 1,
                           mu2 = 1.3,
                           sd = 1,
                           n1 = n,
                           n2 = n))
write.csv(data.frame(n = n, power = length(p[p < .05])/length(p)),
          row.names = FALSE,
          file = paste0("output/out", process, ".csv"))
