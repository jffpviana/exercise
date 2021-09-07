#This script formats the data into a usable format.
#It also generates a metadata file with regional location of each sample

input.dir <- "~/Documents/test/mitra/raw_data/" #set input directory
output.data.dir <- "~/Documents/test/mitra/data/"#set output data directory
output.metadata.dir <- "~/Documents/test/mitra/metadata/"#set output metadata directory


alien.data <- read.csv(paste0(input.dir, "exercise_data.csv"), stringsAsFactors=F) # read in experimenta data. Make sure the columns are not read as factors

#make dataframe with metadata
alien.meta <- data.frame(sample.id = paste0("Sample", seq(1:6)), region = as.factor(c(rep("north", 3), rep("south", 3)))) #the region column is stored as a factor, where 'north' is the first level (baseline)


#inspect the data
head(alien.data)
dim(alien.data)

#create new dataframe where the positions are row names and the onl contents of the dataframe is the data themselves
alien.data.less <- alien.data[, colnames(alien.data)[grep("Sample", colnames(alien.data))]] #extract columns with counts
rownames(alien.data.less) <- paste0(alien.data$Chromosome, ":", alien.data$Position) #change rownames of new dataframe to chr:pos format


#save reformated data for use in subsequent steps
write.csv(alien.data.less, file=paste0(output.data.dir, "alien_data_formatted.csv"))

write.csv(alien.meta, file=paste0(output.metadata.dir, "alien_metadata.csv"))
