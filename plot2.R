#Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Then unzip it in the working directory, making sure 
#"household_power_consumption.txt" is there
# Reading data fromy the working directory
d = read.table("household_power_consumption.txt", header = TRUE,  
               sep=";",na.strings = c("?",""))

#choosing obervations only when date is either 2007-02-01 or 2007-02-02.
d2 = subset(d, Date== "1/2/2007"|Date=="2/2/2007")

#converting dates and times to real date and time format and others to numeric
d2$Date=as.Date(d2$Date, format="%d/%m/%Y")
d2$timetemp = strptime(d2$Time, format= "%H:%M:%S")
d2$Time = format(as.POSIXct(strptime(d2$timetemp,"%Y-%m-%d %H:%M:%S",
            tz="")), format = "%H:%M:%S")
d2$Global_active_power=as.numeric(levels(d2$Global_active_power))[d2$Global_active_power]

#making sure the class conversions have worked
sapply(d2,class)

# making a new variable as the combination of date and time
dateTime <- paste(d2$Date, d2$Time)
d2$DateTime <- as.POSIXct(dateTime)

#making plot 2
plot(d2$Global_active_power ~d2$DateTime , xlab="", type="l",
     ylab="Global Active Power (kilowatts)")

# saving plot
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()