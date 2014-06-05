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
#BEGIN PLOT 1 SAVE AS PNG
##########################
png(filename = "plot1.png", width = 480, height = 480)
hist(df1$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
##########################
#END PLOT 1 SAVE AS PNG
##########################