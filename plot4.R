
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

#set the global graphics parameters
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

#create the plot
plot(plotData$DateTime, as.numeric(as.character(plotData$Global_active_power)), type = "l", xlab = "", ylab ="Global Active Power")

plot(plotData$DateTime, plotData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", col = "black")

plot(plotData$DateTime, plotData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(plotData$DateTime, plotData$Sub_metering_2, type = "l", col = "red")
lines(plotData$DateTime, plotData$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n" )

plot(plotData$DateTime, plotData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", col = "black")

#copy into a png file and turn off the PNG device
dev.copy(png, "plot4.png")
dev.off() #
