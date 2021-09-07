#This script performs a linear regression using the region (north and south) as a varible.

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory


alien.data.filtered<- read.csv(paste0(input.data.dir, "alien_proportionA_filter10cov.csv"), row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)

#create an empty matrix for the linear regression results
linreg.results <- as.data.frame(matrix(NA, nrow=nrow(alien.data.filtered), ncol=4))
colnames(linreg.results) <- c("Estimate", "SE", "tvalue", "pvalue")
rownames(linreg.results) <- rownames(alien.data.filtered)


#loop through all rows of the proportion data and perform the linear regression for each site and extract the summary statistics
for(i in 1:nrow(alien.data.filtered)){
	model<-lm(unlist(alien.data.filtered[i, ]) ~ as.factor(alien.meta$region))

  linreg.results[i, "Estimate"] <- summary(model)$coefficients[2,"Estimate"]
  linreg.results[i, "SE"] <- summary(model)$coefficients[2,"Std. Error"]
  linreg.results[i, "tvalue"] <- summary(model)$coefficients[2,"t value"]
  linreg.results[i, "pvalue"] <- summary(model)$coefficients[2,"Pr(>|t|)"]

}

#adjust the p-values for multiple testing using FDR
linreg.results$FDR_adjusted <- p.adjust(linreg.results[, "pvalue"], method = 'fdr')

#order dataframe from smallest pvalue to largest
linreg.results <- linreg.results[order(linreg.results$pvalue),]

#save the linear regression results
write.csv(linreg.results, file=paste0(output.data.dir, "alien_linear_regression_filtered10cov.csv"))
