#Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Then unzip it in the working directory, making sure 
#"household_power_consumption.txt" is there
# Reading data fromy the working directory
d = read.table("household_power_consumption.txt", header = TRUE,  sep=";")

#choosing obervations only when date is either 2007-02-01 or 2007-02-02.
d2 = subset(d, Date== "1/2/2007"|Date=="2/2/2007")

#converting dates and times to real date and time format and others to numeric
d2$Date=as.Date(d2$Date, format="%d/%m/%Y")
d2$Time=as.character(d2$Time)
d2$Time=strptime(d2$Time, "%H:%M:%S")
d2$Time=strftime(d2$Time, "%H:%M:%S")
d2$Global_active_power=as.numeric(levels(d2$Global_active_power))[d2$Global_active_power]
d2$Global_reactive_power=as.numeric(levels(d2$Global_reactive_power))[d2$Global_reactive_power]
d2$Voltage=as.numeric(levels(d2$Voltage))[d2$Voltage]
d2$Sub_metering_1=as.numeric(levels(d2$Sub_metering_1))[d2$Sub_metering_1]
d2$Sub_metering_2=as.numeric(levels(d2$Sub_metering_2))[d2$Sub_metering_2]
#making sure the class conversions have worked
sapply(d2,class)

# making a new variable as the combination of date and time
dateTime <- paste(d2$Date, d2$Time)
d2$DateTime <- as.POSIXct(dateTime)

#saving the png
png(file="plot4.png", height=480, width=480)

#asking R to show  plots in 2 rows and 2 columns
par(mfrow=c(2,2))

# ordering plots in the clock-wise order
#plot 1
plot(d2$Global_active_power ~d2$DateTime , xlab="", type="l",
     ylab="Global Active Power")

#plot 2
plot(d2$Voltage ~d2$DateTime , xlab="datetime", type="l",
     ylab="Voltage")

#plot 3
plot(d2$Sub_metering_1 ~d2$DateTime , xlab="", type="l",
     ylab="Energy sub metering")
lines(d2$Sub_metering_2 ~d2$DateTime, col = "red")
lines(d2$Sub_metering_3 ~d2$DateTime, col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", 
                            "Sub_metering_3"), lty=c(1,1),
       lwd=c(2.5,2.5),col=c("black","red","blue"),cex=.7)

#plot 4
plot(d2$Global_reactive_power ~d2$DateTime , xlab="datetime", type="l",
     ylab="Global reactive Power")


# closing the device

dev.off()
