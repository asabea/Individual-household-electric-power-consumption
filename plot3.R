fileName<-"Dataset.zip"
lnk<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download file,if the file doesnot exit 
if(!file.exists(fileName))
{
  download.file(lnk,destfile="Dataset.zip", mode = "wb")
}

# File Extraction
if(file.exists(getwd())){
  unzip("Dataset.zip", files = NULL, exdir=".")
}

## Read Table
household_pwr <- read.table("household_power_consumption.txt", sep = ';',dec = '.', header = TRUE, stringsAsFactors = FALSE)

#get the 2 days of Feb. data frame
Feb_household_pwr <-household_pwr[household_pwr$Date %in% c('1/2/2007', '2/2/2007'), ]


## Merging Date & Time Colmns
Datetime <- paste(Feb_household_pwr$Date, " ", Feb_household_pwr$Time)
Feb_household_pwr$Datetime <-as.POSIXlt(Datetime, format = "%d/%m/%Y %H:%M:%S")
Feb_household_pwr$Global_active_power <- as.numeric(Feb_household_pwr$Global_active_power)

## get Global active power data
global_active_pwr <- Feb_household_pwr$Global_active_power

# Plot 3  , 
png("plot3.png", width = 480, height = 480)
plot(Feb_household_pwr$Datetime, Feb_household_pwr$Sub_metering_1, type = "l", ylab = "Energy Sub Metering", xlab = "") 
lines(Feb_household_pwr$Datetime, Feb_household_pwr$Sub_metering_2, col = "red") 
lines(Feb_household_pwr$Datetime, Feb_household_pwr$Sub_metering_3, col = "blue") 
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col  = c("black", "red", "blue"), lty=1 ,cex=0.65)

dev.off()


