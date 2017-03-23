library(dplyr)
library(lubridate)
library(ggplot2)
library(gridExtra)

dts <- read.table("household_power_consumption.txt", nrows = 70000, stringsAsFactors = FALSE, header=TRUE, sep=";")
glimpse(dts)

dts$datetime <- dmy_hms(paste(dts$Date, dts$Time, sep=" "))
dts$Date <- dmy(dts$Date)

dts4 <- dts[dts$Date =="2007-02-01" | dts$Date=="2007-02-02",]

dts4[,3] <- as.numeric(dts4[,3])
dts4[,4] <- as.numeric(dts4[,4])
dts4[,5] <- as.numeric(dts4[,5])
dts4[,7] <- as.numeric(dts4[,7])
dts4[,8] <- as.numeric(dts4[,8])

scalelabel <-  scale_x_datetime(date_labels = "%A", date_breaks = "1 day")

first <- ggplot(dts4, aes(x=datetime, y=Global_active_power)) + geom_line() + labs(x="", y="Global Active Power") + scalelabel
second <- ggplot(dts4, aes(x=datetime, y= Voltage)) + geom_line() + scalelabel

meter_first <- ggplot(dts4, aes(x=datetime, y=Sub_metering_1, col="Sub_metering_1")) + geom_line()
meter_second <- geom_line(aes(x=datetime, y=Sub_metering_2, col="Sub_metering_2"))
meter_third <- geom_line(aes(x=datetime, y=Sub_metering_3, col="Sub_metering_3")) 
meter_label <- labs(x="", y="Energy sub metering")

third <- meter_first + meter_second + meter_third + meter_label + theme(legend.position = c(0.8, 0.8)) + scale_color_manual(values=c("black","red", "blue")) + scalelabel

fourth <- ggplot(dts4, aes(x=datetime, y= Global_reactive_power)) + geom_line() + scalelabel

grid.arrange(first, second, third, fourth, nrow=2, ncol=2)

dev.copy(png, "plot4.png")
dev.off()
