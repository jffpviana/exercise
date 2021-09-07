#This script was used to do data exploration ahead of choosing any statistical test

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory


alian.data <- read.csv(paste0(input.data.dir, "alian_proportionA.csv"), row.names = 1)

alian.meta <- read.csv(paste0(input.metadata.dir, "alian_metadata.csv"), row.names = 1)


#plot the histogram and density plot for the data. This will give us an idea of the overall distribution of the data




#plot the histogram and density plot for a few random sites in the alien genome to look at the distribution of those sites
