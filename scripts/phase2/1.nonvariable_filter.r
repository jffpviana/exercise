#This script identifies and removes non-variable sites

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory



alien.data <- read.csv(paste0(input.data.dir, "alien_proportionA.csv"), stringsAsFactors = FALSE, row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)


#I defined a non-variable site as one that has 5% or less (modification A proportion of 0.05) between the e 10th and 90th percentiles.

keep.vector <- rep(NA, nrow(alien.data))

#outputs a vector of TRUE and FALSE. TRUE = sites we want to keep and FALSE = non-variable sites
for(i in 1:nrow(alien.data)){
  q10 <- quantile(unlist(alien.data[i,]), c(0.1, 0.9))[1]

  q90 <- quantile(unlist(alien.data[i,]), c(0.1, 0.9))[2]


  if(q90-q10 > 0.05){
    keep.vector[i] <- TRUE
  }else{
    keep.vector[i] <- FALSE
  }
}


#check if there are any non-variable sites
which(keep.vector==FALSE)

#There were no nonvariable sites to remove
