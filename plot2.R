library(lubridate)

load_pc <- function(file_name){
  pc <- read.csv(file_name, sep = ';', na.strings = '?')
  pc$DT = dmy_hms(paste(pc$Date, pc$Time))
  i <- interval(dmy('1/2/2007'), dmy_hms('2/2/2007 23:59:59'))
  subset(pc, DT %within% i)
}

plot2 <- function(pc, ylab = 'Global Active Power (kilowatts)') {
  plot(pc$DT, pc$Global_active_power, type = 'l', xlab = '', ylab=ylab)
}

plot2_main <- function (filename) {
  pc <- load_pc(filename)
  png(filename = 'plot2.png')
  plot2(pc)
  dev.off()
}
