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

#Merge date and time
power$datetime <- with(power, ymd(Date) + hms(Time))



png(filename = "plot3.png", width = 480, height = 480)

with(power, plot(datetime, Sub_metering_1, type = "l", col = "black", ylab = "Energy Sub metering", xlab = "datetime"))
with(power, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(power, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright",pch=c(1,1,1),col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2", "sub_metering_3"))

dev.off()
            

