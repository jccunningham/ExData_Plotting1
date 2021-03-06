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
png(file="plot3.png", units="px", width=480, height=480)

#plot Global Active Power by timeline
plot(plotdata$DateTime, plotdata$Sub_metering_1, type="n",  ylab="Energy sub metering", xlab="")
lines(plotdata$DateTime, plotdata$Sub_metering_1)
lines(plotdata$DateTime, plotdata$Sub_metering_2, col="red")
lines(plotdata$DateTime, plotdata$Sub_metering_3, col="blue")
legend(x="topright", 
      legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      col=c("black", "blue", "red"),
      lwd=1,
      lty=c(1,1,1))
dev.off()
