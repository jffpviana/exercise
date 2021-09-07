#This script calculates the proportion of modification A.
#Since at each position we know there can only be modification A, B or a mixture of the two, we can calculate the proportion of A at each position. The proportion of B will be 1-proportion of A.


input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory

function.source <- "~/Documents/test/mitra/functions/proportionA.r"


alien.data <- read.csv(paste0(input.data.dir, "alien_data_formatted.csv"), row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)

#load function to calculate the percentage of A for a single positions
source(function.source)

#apply the new function to all rows of the data
t(apply(alien.data, 1, prop_mod, samples=alien.meta))-> propA

#propA is a dataframe with the proportions of modification A in each sample, in each position of the alien genome

#save the proportions dataframe
write.csv(propA, file=paste0(output.data.dir, "alien_proportionA.csv"))
