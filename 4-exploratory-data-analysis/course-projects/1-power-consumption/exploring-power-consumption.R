


get_plots <- function()
{
      get_plot1()
      get_plot2()
      get_plot3()
      get_plot4()
}


get_plot1 <- function()
{
      ## Load power consumption data
      data <- read.table("household_power_consumption.txt", 
                         sep=";", 
                         na.strings = "?",
                         strip.white=TRUE,
                         header=TRUE)
      
      ## Extract only two days of data
      data <- subset(data, Date=="1/2/2007" | 
                           Date=="2/2/2007")
      
      ## Add a timestamp column
      data$Timestamp = strptime( paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S" )
      
      ## Plot 1 - Global Active Power vs. Frequency
      png( filename = "plot1.png", width = 480, height = 480)
      hist(data$Global_active_power, col = "red", 
                                     xlab = "Global Active Power (kilowatts)",
                                     ylab = "Frequency",
                                     main = "Global Active Power" ) 
      dev.off() 
}


get_plot2 <- function()
{
      ## Load power consumption data
      data <- read.table("household_power_consumption.txt", 
                         sep=";", 
                         na.strings = "?",
                         strip.white=TRUE,
                         header=TRUE)
      
      ## Extract only two days of data
      data <- subset(data, Date=="1/2/2007" | 
                           Date=="2/2/2007")
      
      ## Add a timestamp column
      data$Timestamp = strptime( paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S" )      
      
      ## Plot 2 - Date vs. Global Active Power
      png( filename = "plot2.png", width = 480, height = 480)
      plot(x = data$Timestamp, 
           y = data$Global_active_power, 
           type ="l",
           xlab = "",
           ylab = "Global Active Power (kilowatts)")
      dev.off()
}


get_plot3 <- function()
{
      ## Load power consumption data
      data <- read.table("household_power_consumption.txt", 
                         sep=";", 
                         na.strings = "?",
                         strip.white=TRUE,
                         header=TRUE)
      
      ## Extract only two days of data
      data <- subset(data, Date=="1/2/2007" | 
                           Date=="2/2/2007")
      
      ## Add a timestamp column
      data$Timestamp = strptime( paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S" )      
      
      ## Plot 3 - Energy Sub Metering
      png( filename = "plot3.png", width = 480, height = 480)
      plot( x = data$Timestamp, y = data$Sub_metering_1,
            xlab = "",
            ylab = "Energy sub metering",
            type = "n")
      
      lines( data$Timestamp, data$Sub_metering_1, col = "black" )
      lines( data$Timestamp, data$Sub_metering_2, col = "red" )
      lines( data$Timestamp, data$Sub_metering_3, col = "blue" )
      legend( "topright", 
              legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
              col = c("black", "red", "blue"),
              lty = c(1,1,1) )
      dev.off()
}


get_plot4 <- function()
{
      ## Load power consumption data
      data <- read.table("household_power_consumption.txt", 
                         sep=";", 
                         na.strings = "?",
                         strip.white=TRUE,
                         header=TRUE)
      
      ## Extract only two days of data
      data <- subset(data, Date=="1/2/2007" | 
                           Date=="2/2/2007")
      
      ## Add a timestamp column
      data$Timestamp = strptime( paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S" )      
      
      png( filename = "plot4.png", width = 480, height = 480)
      par( mfrow = c(2, 2) )
      
      ## Plot 1 
      plot(x = data$Timestamp, y = data$Global_active_power, 
           type ="l",
           xlab = "",
           ylab = "Global Active Power (kilowatts)")
      
      
      ## Plot 2 
      plot(x = data$Timestamp, y = data$Voltage, 
           type ="l",
           xlab = "datetime",
           ylab = "Voltage")
      
      
      ## Plot 3
      plot( x = data$Timestamp, y = data$Sub_metering_1,
            xlab = "",
            ylab = "Energy sub metering",
            type = "n")
      lines( data$Timestamp, data$Sub_metering_1, col = "black" )
      lines( data$Timestamp, data$Sub_metering_2, col = "red" )
      lines( data$Timestamp, data$Sub_metering_3, col = "blue" )
      legend( "topright", 
              legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
              col = c("black", "red", "blue"),
              lty = c(1,1,1),
              bty = "n" )
      
      ## Plot 4
      plot(x = data$Timestamp, y = data$Global_reactive_power, 
           type ="l",
           xlab = "datetime")
      
      dev.off()
}

