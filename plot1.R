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

colnames(EPC) <- EPC[1,]

EPC = EPC[-1, ]
#Convert Date var to Date Class AND Convert time var to Time Class
#time <- EPC[EPC$Date,EPC$Time]
EPC$Time<-paste(EPC$Date,EPC$Time,sep=" ")
EPC[,"Date"]<-as.Date(EPC[,"Date"],format="%d/%m/%Y")
EPC[,"Time"]<-list(strptime(EPC[,"Time"],format="%d/%m/%Y %H:%M:%S"))
#Subset the data frame wihtin the given date Range
reqdData<-EPC[EPC$Date>="2007-02-01" & EPC$Date<="2007-02-02",]

#Convert global active power from character to numeric
reqdData[,"Global_active_power"]<-as.numeric(reqdData[,"Global_active_power"])

#Plot the Histogram
with(reqdData,hist(Global_active_power,col="red",xlab = "Global Active Power(kilowatts)",main="Global Active Power"), width=480, height=480)


#Save the plot in png format
dev.copy(png,file="plot1.png")
dev.off()