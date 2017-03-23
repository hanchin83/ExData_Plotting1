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

main3 <- first + second + third + label3 + theme(legend.position = c(0.8, 0.8)) + scale_color_manual(values=c("black","red", "blue"))
scalelabel <-  scale_x_datetime(date_labels = "%A", date_breaks = "1 day")
plot3 <- main3 + scalelabel
plot3

dev.copy(png, "plot3.png")
dev.off()
