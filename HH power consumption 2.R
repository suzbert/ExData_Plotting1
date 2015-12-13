## get data

hpc<- file("household_power_consumption.txt")

data <- read.table(text = grep("^[1,2]/2/2007", readLines(hpc), value = TRUE), 
                   col.names = c("Date", "Time", "Global_active_power", 
                                 "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", 
                                 "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)


## read in data

data_all <- read.csv("household_power_consumption.txt", header = T, sep = ';',
                     na.strings = "?", nrows = 2075259, check.names = F,
                     stringsAsFactors = F, comment.char = "", quote = '\"')
data_all$Date <- as.Date(data_all$Date, format = "%d/%m/%Y")

##Subset data
data <- subset(data_all, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_all)

## Convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


## Generating Plot 2
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")