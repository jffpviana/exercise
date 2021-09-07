input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.data.dir <- "~/Documents/test/mitra/data/" #set output data directory


propA<- read.csv(paste0(input.data.dir, "alien_proportionA.csv"), row.names = 1)

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)


linreg.results <- matrix(NA, nrow=nrow(propA), ncol=4)
colnames(linreg.results) <- c("Estimate", "SE", "tvalue", "pvalue")
rownames(linreg.results) <- rownames(propA)


for(i in 1:nrow(propA)){
	model<-lm(unlist(propA[i, ]) ~ as.factor(alien.meta$region))

  linreg.results[i, "Estimate"] <- summary(model)$coefficients[2,"Estimate"]
  linreg.results[i, "SE"] <- summary(model)$coefficients[2,"Std. Error"]
  linreg.results[i, "tvalue"] <- summary(model)$coefficients[2,"t value"]
  linreg.results[i, "pvalue"] <- summary(model)$coefficients[2,"Pr(>|t|)"]

}
