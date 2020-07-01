#-------------------------------------------------------------------------------

# download zip file - only if it is not downloaded already
zipfile <- "Dataset.zip"

if (!file.exists(zipfile)){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, zipfile)
}  

# unzip - only if not done already
if (!file.exists("household_power_consumption.txt")) { 
  unzip(zipfile) 
}

#-------------------------------------------------------------------------------

data <- read.table("household_power_consumption.txt",
                header=TRUE, sep=";",
                na.strings = "?",
                colClasses = c('character','character','numeric','numeric',
                               'numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Filter data set from the dates 2007-02-01 and 2007-02-02
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# create datetime column and then drop date & time columns
dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(dateTime, data)
data$dateTime <- as.POSIXct(dateTime)

#-------------------------------------------------------------------------------

# source('plot1.R')
# source('plot2.R')
# source('plot3.R')
# source('plot4.R')

#-------------------------------------------------------------------------------
