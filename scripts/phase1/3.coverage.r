#This script calculates the coverage (total counts) at each position.


input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory


function.source <- "~/Documents/test/mitra/functions/coverage.r"


alien.data <- read.csv(paste0(input.data.dir, "alien_data_formatted.csv"), row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)

#load function to calculate the site coverage
source(function.source)

#apply the new function to all rows of the data
t(apply(alien.data, 1, cov_counts, samples=alien.meta))-> total.cov

#total.cov is a dataframe with the total number of counts in each sample, in each position of the alien genome

#save the coverage dataframe
write.csv(total.cov, file=paste0(output.data.dir, "alien_total_coverage.csv"))
