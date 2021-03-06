
#Ensure the unzipped text file is there in the current working directory 
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)

power=read.table("filtered.txt",sep=";",header=TRUE, na.strings="?",stringsAsFactors=FALSE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$DateTime<- paste(power$Date, power$Time)
power$DateTime <- strptime(power$DateTime, format = "%Y-%m-%d %H:%M:%S")
png(filename = "Plot3.png",width = 480, height = 480, units = "px")
par(mar=c(2,4,1,5))
with(power,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab="",cex.axis=.8,cex.lab=.8))
with(power,lines(DateTime,Sub_metering_1))
with(power,lines(DateTime,Sub_metering_2,col="Red"))
with(power,lines(DateTime,Sub_metering_3,col="Blue"))
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.9)
dev.off()