#This script formats the data into a usable format.
#It also generates a metadata file with regional location of each sample

input.dir <- "~/Documents/test/mitra/raw_data/" #set input directory
output.data.dir <- "~/Documents/test/mitra/data/"#set output data directory
output.metadata.dir <- "~/Documents/test/mitra/metadata/"#set output metadata directory


alian.data <- read.csv(paste0(input.dir, "exercise_data.csv"), stringsAsFactors=F) # read in experimenta data. Make sure the columns are not read as factors

#make dataframe with metadata
alian.meta <- data.frame(sample.id = paste0("Sample", seq(1:6)), region = as.factor(c(rep("north", 3), rep("south", 3)))) #the region column is stored as a factor, where 'north' is the first level (baseline)


#inspect the data
head(alian.data)
dim(alian.data)

#create new dataframe where the positions are row names and the onl contents of the dataframe is the data themselves
alian.data.less <- alian.data[, colnames(alian.data)[grep("Sample", colnames(alian.data))]] #extract columns with counts
rownames(alian.data.less) <- paste0(alian.data$Chromosome, ":", alian.data$Position) #change rownames of new dataframe to chr:pos format


#save reformated data for use in subsequent steps
write.csv(alian.data.less, file=paste0(output.data.dir, "alian_data_formatted.csv"))

write.csv(alian.meta, file=paste0(output.metadata.dir, "alian_metadata.csv"))
