#Function to calculate the total coverage of counts at each site of the alien genome


cov_counts <- function(data, samples){
  #function to calculate and return the total number of counts in each position

  #create empty vector for the total coverage
  total.cov <- rep(NA, length(samples$sample.id))
  names(total.cov) <- samples$sample.id
  #loop through all samples and calculate the total counts

  for(i in samples$sample.id){
    total.cov[i] <- (data[paste0(i, ".A")]+data[paste0(i, ".B")])
  }
  #return the total number of counts for each sample and each position
  return(total.cov)
}
