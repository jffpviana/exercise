setwd("~/Documents/test/mitra/") # change working directory

alian.data <- read.csv("exercise_data.csv", stringsAsFactors=F) # read in experimenta data. Make sure the columns are not read as factors

#make dataframe with metadata
alian.meta <- data.frame(sample.id = paste0("Sample", seq(1:6)), region = as.factor(c(rep("north", 3), rep("south", 3)))) #the region column is stored as a factor, where 'north' is the first level (baseline)


#inspect the data
head(alian.data)
dim(alian.data)

#create new dataframe where the positions are row names and the onl contents of the dataframe is the data themselves
alian.data



#since at each position we know there can only be modification A, B or a mixture of the two, we can calculate the proportion of A at each position. The proportion of B will be 1-proportion of A.


perc_mod <- function(datat, samplet){
  #function to calculate an return the proportion of modification A in a vector (to be apply to each position)
  #create empty vector for the proportions
  percA <- rep(NA, length(samplet$sample.id))
  names(percA) <- samplet$sample.id
  #loop through all samples and calculate the percentage
  for(i in samplet$sample.id){
    percA[i] <- datat[,paste0(i, ".A")]/(datat[,paste0(i, ".A")]+datat[,paste0(i, ".B")])
  }
  #return the percentage of A, the percentage of B will be 1-proportion of A
  return(percA)
}


#apply the new function to all rows of the data
