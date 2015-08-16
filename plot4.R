library(lubridate)

load_pc <- function(file_name){
  pc <- read.csv(file_name, sep = ';', na.strings = '?')
  pc$DT = dmy_hms(paste(pc$Date, pc$Time))
  i <- interval(dmy('1/2/2007'), dmy_hms('2/2/2007 23:59:59'))
  subset(pc, DT %within% i)
}

plot4 <- function(pc){
  old.par = par(mfrow = c(2, 2))
  plot(pc$DT, pc$Global_active_power, type = 'l', xlab = '', ylab='Global Active Power')
  plot(pc$DT, pc$Voltage, type = 'l', xlab = 'datetime', ylab='Voltage')
  plot(pc$DT, pc$Sub_metering_1, type = 'l', xlab = '', ylab='Energy sub metering')
  lines(pc$DT, pc$Sub_metering_2, type = 'l', col = 'red')
  lines(pc$DT, pc$Sub_metering_3, type = 'l', col = 'blue')
  legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), cex = .75,
         lty=c(1,1,1), lwd = c(2.5,2.5,2.5), col = c('black', 'red','blue'), bty = 'n')
  plot(pc$DT, pc$Global_reactive_power, type = 'l', xlab = 'datetime', ylab='Global_reactive_power')
  par(old.par)
}

plot4_main <- function (filename) {
  pc <- load_pc(filename)
  png(filename = 'plot4.png')
  plot4(pc)
  dev.off()
}
