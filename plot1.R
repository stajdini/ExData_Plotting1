#Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Then unzip it in the working directory, making sure 
#"household_power_consumption.txt" is there
# Reading data fromy the working directory
d = read.table("household_power_consumption.txt", header = TRUE,  sep=";")

#converting dates and times to real date and time format and d$Global_active_power to numeric
d$Date=as.Date(d$Date, format="%d/%m/%Y")
d$Time=as.character(d$Time)
d$Time=strptime(d$Time, "%H:%M:%S")
d$Time=strftime(d$Time, "%H:%M:%S")
d$Global_active_power=as.numeric(levels(d$Global_active_power))[d$Global_active_power]

#making sure the class conversions have worked
sapply(d,class)

# turning the data.frame to table df format (a personal choice for more ease of use)
#choosing obervations only when date is either 2007-02-01 or 2007-02-02.
d = subset(d, Date== "2007-02-01"|Date=="2007-02-02")

#making plot 1
hist(d$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
# saving plot
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
