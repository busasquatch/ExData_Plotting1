#load the sqldf package
library(sqldf)

#after setting working directory in R Studio, get name of file
filename <- "household_power_consumption.txt"

#read file using read.csv.sql, filtering for Dates of Feb.1,2007, Feb.2, 2007
df1 <- read.csv.sql(filename, sep = ";",  sql = 'select * from file where Date = "2/2/2007"or Date = "1/2/2007" ')

#make all ? strings as NA
is.na(df1) <- df1 == "?"

#convert $Date to date class, $Time to time class
df1$Date <- as.Date(df1$Date, "%d/%m/%Y")

#create datetime field, merging Date and Time
df1$datetime <- as.POSIXct(paste(df1$Date,df1$Time))

##########################
#BEGIN PLOT 4 R STUDIO
##########################
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#TOP LEFT PLOT
plot(df1$datetime, df1$Global_active_power, type = "n", main = NULL, xlab = "", ylab = "Global Active Power")
lines(df1$datetime, df1$Global_active_power)

#TOP RIGHT PLOT
plot(df1$datetime, df1$Voltage, type = "n", main = NULL, xlab = "datetime", ylab = "Voltage")
lines(df1$datetime, df1$Voltage)

#BOTTOM LEFT PLOT
with(df1,plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(df1, lines(datetime, Sub_metering_1))
with(df1, lines(datetime, Sub_metering_2, col = "red"))
with(df1, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1, bty = "n")

#BOTTOM RIGHT PLOT
with(df1, plot(datetime, Global_reactive_power, type = "n", main = NULL))
lines(df1$datetime, df1$Global_reactive_power)
dev.off()
##########################
#END PLOT 4 AS PNG
##########################