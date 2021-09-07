#This script plots the qq-plot for the linear regression results .

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
output.plots <- "~/Documents/test/mitra/plots/" #set output data directory


linreg<- read.csv(paste0(input.data.dir, "alien_linear_regression_filtered10cov.csv"), row.names = 1)


#we -log10 transform the pvalues and theoretical quantiles se we can visualise the most significant pvalues well.
logp <- -log10(linreg$pvalue)
logt <- -log10(1:nrow(linreg)/nrow(linreg)) # calculate theoretical quantiles for qq plot


#plot qqplot
pdf(paste0(output.plots, "qq_linear_regression_filtered10cov.pdf"))
	plot(logt, logp, xlab="Theoretical quantiles", ylab="Experimental quantiles", main="QQ-plot linear regresion")
	abline(a=0, b=1, col='red')
dev.off()
