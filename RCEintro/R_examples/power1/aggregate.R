## list all output files in the output directory
output_files <- list.files("output",
                           pattern = "^out\\.[0-9]+$",
                           full.names=TRUE)

## read each file, convert it to a number, and take the average
mean(as.double(sapply(
                      output_files,
                      readLines,
                      warn = FALSE)))
