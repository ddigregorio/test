## this script is used to re-create plot #1 for exploratory data analysis assignment #1
## to run this script 
## source("plot1.r")
library(data.table)

## first correctly set your working directory
## setwd()

## load the data 
## going to break this into 2 smaller pieces because while I have enough resources a peer might not

## file
f = "Fhousehold_power_consumption/household_power_consumption.txt"

## grab the header from the file
header = read.table(f, sep=";", header=TRUE, nrows = 1)
cnames = names(header)

## grab the specific data from the file
## only using data from 2-1-2007 and 2-2-2007
epc <- read.table( text=grep("^[1|2]/2/2007", readLines(f), value=TRUE ), sep=";", header=FALSE)

## change the generic column names in the data subset to the actual dataset column names
colnames(epc) = cnames

## check (for debug only, comment out for final use)
#head(epc)
#tail(epc)

e=epc
#e$Date <- as.Date(e$Date , format="%d/%m/%Y")
e$datetime = strptime(paste(e$Date, e$Time), format = "%d/%m/%Y %H:%M:%S")


## create a histogram from the data
par(mfrow=c(1,1) )
hist(epc$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")  

## save the file to a PNG file 480 x 480

# "plot1.png"
dev.copy(png, "plot1.png", width=480, height = 480)  
dev.off()
  
  
  
  
  
  