library(lubridate)

load_pc <- function(file_name){
  pc <- read.csv(file_name, sep = ';', na.strings = '?')
  pc$DT = dmy_hms(paste(pc$Date, pc$Time))
  i <- interval(dmy('1/2/2007'), dmy_hms('2/2/2007 23:59:59'))
  subset(pc, DT %within% i)
}

plot3 <- function(pc, bty = 'o', cex = 1){
  plot(pc$DT, pc$Sub_metering_1, type = 'l', xlab = '', ylab='Energy sub metering')
  lines(pc$DT, pc$Sub_metering_2, type = 'l', col = 'red')
  lines(pc$DT, pc$Sub_metering_3, type = 'l', col = 'blue')
  legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), cex = cex,
         lty=c(1,1,1), lwd = c(2.5,2.5,2.5), col = c('black', 'red','blue'), bty = bty)
}

plot3_main <- function (filename) {
  pc <- load_pc(filename)
  png(filename = 'plot3.png')
  plot3(pc)
  dev.off()
}
