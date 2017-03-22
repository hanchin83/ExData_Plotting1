library(dplyr)
library(lubridate)
library(ggplot2)

dts <- read.table("household_power_consumption.txt", nrows = 70000, stringsAsFactors = FALSE, header=TRUE, sep=";")
glimpse(dts)

dts$Date <- dmy(dts$Date)
dts$Time <- hms(dts$Time)
dts1 <- dts[dts$Date =="2007-02-01" | dts$Date=="2007-02-02",]
dts1$Global_active_power <- as.numeric(dts1$Global_active_power)

main1 <- ggplot(dts1, aes(x=Global_active_power)) + stat_bin(fill="red", geom="bar", binwidth=0.5, boundary = 0.5)

text1 <- labs(title = "Global Active Power", x = "Global Active Power (kilowatts)", y = "Frequency")

plot1 <- main1 + text1 + theme(plot.title = element_text(hjust = 0.5))

plot1
dev.copy(png, "plot1.png")
dev.off()
