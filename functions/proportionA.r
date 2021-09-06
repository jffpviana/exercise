#Function to calculate the proportion of modification A

#since at each position we know there can only be modification A, B or a mixture of the two, we can calculate the proportion of A at each position. The proportion of B will be 1-proportion of A.


prop_mod <- function(data, samples){
  #function to calculate an return the proportion of modification A in a vector (to be apply to each position)
  #create empty vector for the proportions
  propA <- rep(NA, length(samples$sample.id))
  names(propA) <- samples$sample.id
  #loop through all samples and calculate the proportion
  for(i in samples$sample.id){
    propA[i] <- data[paste0(i, ".A")]/(data[paste0(i, ".A")]+data[paste0(i, ".B")])
  }
  #return the proportion of A, the proportion of B will be 1-proportion of A
  return(propA)
}
