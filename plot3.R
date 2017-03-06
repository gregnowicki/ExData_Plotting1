
#download, unzip and read in the data into R
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, paste(getwd(),"/electric_data_dl.zip", sep = ""))
unzip("electric_data_dl.zip")
eData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#add a DateTime variable, by combining Data and Time and formating using strptime
DateTime <- paste(eData$Date, eData$Time, sep = " ")
DateTime <- strptime(DateTime, format = "%d/%m/%Y %T")
eData <- cbind(eData, DateTime)

#subset eData with only the rows we're interested in
plotData <- eData[eData$Date %in% c("1/2/2007", "2/2/2007"), ]

#create the plot
plot(plotData$DateTime, plotData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(plotData$DateTime, plotData$Sub_metering_2, type = "l", col = "red")
lines(plotData$DateTime, plotData$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2 )

#copy into a png file and turn off the PNG device
dev.copy(png, "plot3.png")
dev.off() #
