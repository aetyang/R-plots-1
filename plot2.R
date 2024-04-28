##Read Data:
#Download and unzip the File
ZipName<-"HouseholdPowerConsumption.zip"
fileName<-"household_power_consumption.txt"
if(!file.exists(ZipName)){
    fileUrl<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile=ZipName)
}
if(!file.exists(fileName)){
    unzip(ZipName)
}
#Estimate Size of data frame (75346368 bytes)
sizeEstimate<-object.size(read.table(fileName,sep = ";"))
#Read the file into data frame EPC(Electric power consumption)
EPC<-read.table(fileName,sep = ";",colClasses = "character")

#Make the first row as variable names
colnames(EPC) <-unlist(EPC[1,])
EPC = EPC[-1, ]

#Convert Date var to Date Class AND Convert time var to Time Class
EPC$Time<-paste(EPC$Date,EPC$Time,sep=" ")
EPC[,"Date"]<-as.Date(EPC[,"Date"],format="%d/%m/%Y")
EPC[,"Time"]<-list(strptime(EPC[,"Time"],format="%d/%m/%Y %H:%M:%S"))

#Subset the data frame wihtin the given date Range
reqdData<-EPC[EPC$Date>="2007-02-01" & EPC$Date<="2007-02-02",]

#Change global active power and time to numeric 
reqdData[,"Global_active_power"]<-as.numeric(reqdData[,"Global_active_power"])
reqdData$Time<-as.numeric(reqdData$Time)

#Plot:
#Plot the graph without x axis
with(reqdData,plot(Time,Global_active_power,type="l",xlab="",ylab = "Global Active Power(kilowatts)",xaxt="n"))
#Create X axis
#1170268200 secs at Thursday beginning,
#1170354600 secs at Friday beginning 
#and 1170440940 secs at Sat beginning (dara from table "reqdData")
axis(side=1,at=c(1170268200,1170354600,1170440940),labels = c("Thu","Fri","Sat"))

#Writing to PNG:
dev.copy(png,file="plot2.png")
dev.off()