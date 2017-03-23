library(dplyr)
library(lubridate)
library(ggplot2)

dts <- read.table("household_power_consumption.txt", nrows = 70000, stringsAsFactors = FALSE, header=TRUE, sep=";")
glimpse(dts)

dts$datetime <- dmy_hms(paste(dts$Date, dts$Time, sep=" "))
dts$Date <- dmy(dts$Date)

dts2 <- dts[dts$Date =="2007-02-01" | dts$Date=="2007-02-02",]

dts2$Global_active_power <- as.numeric(dts2$Global_active_power)

main2 <- ggplot(dts2, aes(x=datetime, y=Global_active_power)) + geom_line() 
label2 <- labs(x="", y = "Global Active Power (kilowatts)")
scale2 <- scale_x_datetime(date_labels = "%A", date_breaks = "1 day")
plot2 <- main2 + label2 + scale2 
plot2

dev.copy(png, "plot2.png")
dev.off()
