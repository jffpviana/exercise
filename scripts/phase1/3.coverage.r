#This script calculates the coverage (total counts) at each position.


input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory


function.source <- "~/Documents/test/mitra/functions/coverage.r"


alian.data <- read.csv(paste0(input.data.dir, "alian_data_formatted.csv"), row.names = 1)

alian.meta <- read.csv(paste0(input.metadata.dir, "alian_metadata.csv"), row.names = 1)

#load function to calculate the site coverage
source(function.source)

#apply the new function to all rows of the data
t(apply(alian.data, 1, cov_counts, samples=alian.meta))-> total.cov

#total.cov is a dataframe with the total number of counts in each sample, in each position of the alian genome

#save the coverage dataframe
write.csv(total.cov, file=paste0(output.data.dir, "alian_total_coverage.csv"))
