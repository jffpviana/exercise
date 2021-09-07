#This script plots boxplots for the linear regression results comparing the proportion of modification A between the south and north samples. Change the argument p.threshold to decide what threshold to use for the plotting.
#The plots will be writen to a single pdf, a plot per page.

p.threshold <- 0.01

library(tidyverse)

input.data.dir <- "~/Documents/test/mitra/data/" #set input data directory
input.metadata.dir <- "~/Documents/test/mitra/metadata/" #set input metadata directory
output.dir <- "~/Documents/test/mitra/results/" #set output data directory

alien.meta <- read.csv(paste0(input.metadata.dir, "alien_metadata.csv"), row.names = 1)

alien.data.filtered<- read.csv(paste0(input.data.dir, "alien_proportionA_filter10cov.csv"), row.names = 1)

linreg<- read.csv(paste0(input.data.dir, "alien_linear_regression_filtered10cov.csv"), row.names = 1)

#extract data to plot and the correspondent p-values (in scientific notation)
sites.plot <- rownames(linreg)[which(linreg$pvalue < p.threshold)]
data.plot <- alien.data.filtered[sites.plot,]
p.plot <-formatC(linreg[sites.plot, 'pvalue'], format="e", digits=2)


#start empty list for plots
list.plot <- vector(mode = "list", length = nrow(data.plot))

names(list.plot) <- rownames(data.plot)

	for(i in rownames(data.plot)){

		#boxplot and scatter of modification A by region (north/south)
		data <- data.frame(values= as.numeric(data.plot[i,]), group = alien.meta$region)


		#save to the corresponding element of the list
		list.plot[[i]]<-ggplot(data=data, aes(x=group, y=values, fill=group)) +
			geom_boxplot() +
			geom_jitter() +
			theme(legend.position="none", plot.title = element_text(size=11), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) +
			ggtitle(paste0(i)) +
			xlab("Region") +
			ylab("Proportion of modification A")
	
	}

#save all to pdf
pdf(paste0(output.dir, "boxplots_linear_regression_filtered10cov.pdf"))
	invisible(lapply(list.plot, print))

dev.off()
