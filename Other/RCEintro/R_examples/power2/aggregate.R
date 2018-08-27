## list all output files in the output directory
output_files <- list.files("output",
                           pattern = "^out[0-9]+\\.csv$",
                           full.names=TRUE)

## read each file and append them
results <- do.call(rbind, lapply(output_files, read.csv))

## plot
plot(results)
abline(h = 0.8)
