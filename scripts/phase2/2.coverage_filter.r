#This script was used to do data exploration ahead of choosing any statistical test

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory

alien.data <- read.csv(paste0(input.data.dir, "alien_proportionA.csv"), stringsAsFactors = FALSE, row.names = 1)

alien.cov <- read.csv(paste0(input.data.dir, "alien_total_coverage.csv"), stringsAsFactors = FALSE, row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)

#get north and south sample names
s.north <- alien.meta$sample.id[which(alien.meta$region=='north')]
s.south <- alien.meta$sample.id[which(alien.meta$region=='south')]

#keep only sites that have at least 10 counts in a minimum of 2 samples per group (south/north)

keep.vector <- rep(NA, nrow(alien.cov))

#outputs a vector of TRUE and FALSE. TRUE = sites we want to keep and FALSE = non-variable sites

for(i in 1:nrow(alien.cov)){

  cov.north <- sum((alien.cov[i, s.north] >= 10))
  cov.south <- sum((alien.cov[i, s.south] >= 10))

  if(cov.north >= 2 && cov.south >= 2){
    keep.vector[i] <- TRUE
  }else{
    keep.vector[i] <- FALSE
  }
}

#save this vector for future use

write.csv(keep.vector, file=paste0(output.data.dir, "coverage10_filter_vector.csv"))

#filter the modification A proportion data
alien.data[keep.vector, ]-> alien.data.filtered
#154 sites removed

#save filtered data
write.csv(alien.data.filtered, file=paste0(output.data.dir, "alien_proportionA_filter10cov.csv"))
