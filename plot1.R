if (!file.exists("household_power_consumption.txt")) {
        rawfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url = rawfile, destfile = "raw_data.zip",method = "curl" )
        unzip(zipfile = "raw_data.zip")
}

power <- read.csv2(file = "household_power_consumption.txt")
library(lubridate)
power$Date <- dmy(power$Date)
library(dplyr)
power <- power %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")
power[,3:9] <- sapply(power[,3:9], as.numeric)

png(filename = "plot1.png", width = 480, height = 480)
with(power, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
              