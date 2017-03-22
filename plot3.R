library(dplyr)
library(lubridate)
library(ggplot2)

dts <- read.table("household_power_consumption.txt", nrows = 70000, stringsAsFactors = FALSE, header=TRUE, sep=";")
glimpse(dts)

dts$datetime <- dmy_hms(paste(dts$Date, dts$Time, sep=" "))
dts$Date <- dmy(dts$Date)

dts3 <- dts[dts$Date =="2007-02-01" | dts$Date=="2007-02-02",]
dts3[,7] <- as.numeric(dts3[,7])
dts3[,8] <- as.numeric(dts3[,8])

first <- ggplot(dts3, aes(x=datetime, y=Sub_metering_1, col="Sub_metering_1")) + geom_line()
second <- geom_line(aes(x=datetime, y=Sub_metering_2, col="Sub_metering_2"))
third <- geom_line(aes(x=datetime, y=Sub_metering_3, col="Sub_metering_3")) 

label3 <- labs(x="", y="Energy sub metering")

plot3 <- first + second + third + label3
plot3

dev.copy(png, "plot3.png")
dev.off()
