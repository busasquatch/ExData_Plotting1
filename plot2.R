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
#BEGIN PLOT 2 SAVE AS PNG
##########################
png(filename = "plot2.png", width = 480, height = 480)
plot(df1$datetime, df1$Global_active_power, type = "n", main = NULL, xlab = "", ylab = "Global Active Power (kilowatts)")
lines(df1$datetime, df1$Global_active_power)
dev.off()
##########################
#END PLOT 2 SAVE AS PNG
##########################