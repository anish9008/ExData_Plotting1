
#Ensure the unzipped text file is there in the current working directory 
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)

power=read.table("filtered.txt",sep=";",header=TRUE, na.strings="?",stringsAsFactors=FALSE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$DateTime<- paste(power$Date, power$Time)
power$DateTime <- strptime(power$DateTime, format = "%Y-%m-%d %H:%M:%S")
png(filename = "Plot2.png",width = 480, height = 480, units = "px")
par(mfrow=c(1,1),oma=c(0,0,0,0),mar=c(4,5,1,5))
with (power,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="",cex.lab=.9,cex.axis=.7))
dev.off()