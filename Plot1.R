
#Ensure the unzipped text file is there in the current working directory  
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)

power=read.table("filtered.txt",sep=";",header=TRUE, na.strings="?",stringsAsFactors=FALSE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$DateTime<- paste(power$Date, power$Time)
power$DateTime <- strptime(power$DateTime, format = "%Y-%m-%d %H:%M:%S")
png(filename = "Plot1.png",width = 480, height = 480, units = "px")
par(mfrow=c(1,1),oma=c(0,0,0,0),mar=c(4,4,3,3))
hist(power$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",col="red",cex.axis=.7,cex.lab=.7)
dev.off()