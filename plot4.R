### Read data only from 1 Feb 2007 to 2 Feb 2007
my_data <- subset(read.table("./household_power_consumption.txt", sep = ";", 
                header = TRUE, colClasses = c("character", "character", 
                "numeric", "numeric", "numeric", "numeric", "numeric", 
                "numeric", "numeric"), na.strings = "?"), 
                Date=="1/2/2007" | Date=="2/2/2007")

### Merge Date and Time column
my_data <- within(my_data, "DatenTime" <- paste(Date,Time))
my_data <- subset(my_data, select = c(DatenTime,Global_active_power,
                Global_reactive_power,Voltage,Global_intensity,
                Sub_metering_1,Sub_metering_2,Sub_metering_3))

### Convert Date column to Date/Time format
my_data$DatenTime <- strptime(my_data$DatenTime, "%d/%m/%Y %H:%M:%S")

### Plot the graph
png(file="plot4.png",width=504,height=504,type="cairo")
par(mfrow=c(2,2),mar=c(5.1,4.1,4.1,2.1),cex=0.75)

plot(my_data$DatenTime,my_data$Global_active_power,type = "n",
     xlab = "",ylab = "Global Active Power")
lines(my_data$DatenTime,my_data$Global_active_power)

plot(my_data$DatenTime,my_data$Voltage,type = "n",
     xlab = "datetime",ylab = "Voltage")
lines(my_data$DatenTime,my_data$Voltage)

plot(my_data$DatenTime,my_data$Sub_metering_1,type = "n",
     xlab = "",ylab = "Energy sub metering")
lines(my_data$DatenTime,my_data$Sub_metering_1)
lines(my_data$DatenTime,my_data$Sub_metering_2,col = "red")
lines(my_data$DatenTime,my_data$Sub_metering_3,col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1),bty="n")

plot(my_data$DatenTime,my_data$Global_reactive_power,type = "n",
     xlab = "datetime",ylab = "Global_reactive_power")
lines(my_data$DatenTime,my_data$Global_reactive_power)

### Close PNG device
dev.off()