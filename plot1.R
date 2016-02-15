#SOURCE DATA
# To run this script please dowload this zip archive: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and extract the household_power_consumption.txt data file to your working directory 

#READ DATA SAMPLE FROM SOURCE
#retrieve column names from the data source  
sample<- read.table(file="household_power_consumption.txt",nrows=100, sep=";")

names(sample)
cnames<-lapply(sample[1,], as.character)

#read the data into R
classes<-c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
hpc<- read.table(file="household_power_consumption.txt",col.names = cnames,
                 skip=1,  sep=";", stringsAsFactors=FALSE,na.strings = "?")

#add a column combining Date and Time values in a datetime format
hpc$DateTime <- strptime(paste(hpc$Date, " ", hpc$Time), "%d/%m/%Y %H:%M:%S")


hpc<-as.data.frame.matrix(hpc) 

#select only rows dated 1st or 2nd February 2007 
daterange<-hpc$DateTime>=as.POSIXct("2007-02-01")&hpc$DateTime<as.POSIXct("2007-02-03")&is.na(hpc$DateTime)==FALSE
plotdata <- hpc[daterange, ]

#CREATE PLOT
#open 480x480 pixel canvas
png(file="plot2.png", units="px", width=480, height=480)

#create histogram of Global Active Power for sample dates and copy to a png file
hist(plotdata[,3], main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
