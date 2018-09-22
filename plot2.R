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
dates <- Feb_household_pwr$Date
times <- Feb_household_pwr$Time
Datetime <- paste(Feb_household_pwr$Date, " ", Feb_household_pwr$Time)
Datetime <- strptime(Datetime, "%d/%m/%Y %H:%M:%S")

## get Global active power data
global_active_pwr <- Feb_household_pwr$Global_active_power

# Plot 2  , Datetime VS global active power
png('plot2.png', height = 480, width = 480)
plot(Datetime, global_active_pwr, type="l", ylab = "Global Active Power (Kilowatts)", xlab = "")
dev.off()

