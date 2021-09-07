#This script was used to do data exploration ahead of choosing any statistical test

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory
output.plots <- "~/Documents/test/mitra/plots/" #set output plots directory



alien.data <- read.csv(paste0(input.data.dir, "alien_proportionA.csv"), stringsAsFactors = FALSE, row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)


#plot the histogram and density plots for the data. This will give us an idea of the overall distribution of the data

pdf(paste0(output.plots, "modifications_distribution.pdf"))
  hist(as.matrix(alien.data), main='Histogram', xlab='Modification A proportion') #plot the histogram of the proportion of modificaion A
  plot(density(as.matrix(alien.data)), col='red', main='Density', xlab='Modification A proportion') #plot the density of the proportion of modificaion A
dev.off()
