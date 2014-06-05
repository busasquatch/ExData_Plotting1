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
#BEGIN PLOT 3 AS PNG
##########################
png(filename = "plot3.png", width = 480, height = 480)
with(df1,plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(df1, lines(datetime, Sub_metering_1))
with(df1, lines(datetime, Sub_metering_2, col = "red"))
with(df1, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1)
dev.off()
##########################
#END PLOT 3 AS PNG
##########################