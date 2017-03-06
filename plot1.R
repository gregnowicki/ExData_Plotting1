library(dplyr)

#download, unzip and read in the data into R
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, paste(getwd(),"/electric_data_dl.zip", sep = ""))
unzip("electric_data_dl.zip")
eData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#create a 'tibble' called eData and add the DateTime variable by pasting Data and Time and converting it to POSIXCT
eData <- tbl_df(mutate(eData, DateTime = paste(eData$Date, eData$Time, sep = " ")))

#subset eData with only the rows we're interested in
plotData <- filter(eData, eData$Date %in% c("1/2/2007", "2/2/2007"))

#create the plot
hist(as.numeric(as.character(plotData$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#copy into a png file and turn off the PNG device
dev.copy(png, "plot1.png")
dev.off() #