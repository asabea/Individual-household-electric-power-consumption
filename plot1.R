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

###########Plot1 Data #######
Global_active_pwr<-as.numeric(Feb_household_pwr[,"Global_active_power"])
png('plot1.png', height = 480, width = 480)
#Plot 1
hist(Global_active_pwr, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off()
