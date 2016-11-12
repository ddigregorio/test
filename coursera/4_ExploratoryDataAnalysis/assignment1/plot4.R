## this script is used to re-create plot #4 for exploratory data analysis assignment #1

## to run this script 
## source("plot2.r")
#library(data.table)

## fir st correctly set your working directory
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


#######e=epc
#e$Date <- as.Date(e$Date , format="%d/%m/%Y") does work but not enough
########e$datetime = strptime(paste(e$Date, e$Time), format = "%d/%m/%Y %H:%M:%S")
epc$datetime = strptime(paste(epc$Date, epc$Time), format = "%d/%m/%Y %H:%M:%S")


## create a 4-plot graph
par(mfrow=c(2,2) )
#1
plot(epc$datetime, epc$Global_active_power, type= "l", ylab="Global Active Power", xlab="" , col="black"  ) 


#2
plot(epc$datetime, epc$Voltage, type= "l", ylab="Voltage", xlab="datetime", col="black" ) 

#3
plot(epc$datetime, epc$Sub_metering_1, type= "l", ylab="Energy sub metering", xlab="", col="black" )
points(epc$datetime, epc$Sub_metering_2,type = "l", col = "red")
points(epc$datetime, epc$Sub_metering_3,type = "l", col = "blue" )
legend( "topright", bty = "n" ,yjust=1, cex=0.5, lty=c(1,1,1), col=c("black" , "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#lty=c(1,1,1) ## gives the legend the lines. 

#4
plot(epc$datetime, epc$Global_reactive_power, type="l", ylim=c(0.0,0.5) ,  ylab="Global_reactive_power", xlab="datetime", col="black")


## save the file to a PNG file 480 x 480

# "plot1.png"
dev.copy(png, "plot4.png", width=480, height = 480)  
dev.off() 

