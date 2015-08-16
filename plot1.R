library(lubridate)

load_pc <- function(file_name){
  pc <- read.csv(file_name, sep = ';', na.strings = '?')
  pc$DT = dmy_hms(paste(pc$Date, pc$Time))
  i <- interval(dmy('1/2/2007'), dmy_hms('2/2/2007 23:59:59'))
  subset(pc, DT %within% i)
}

plot1 <- function(pc) {
  hist(pc$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)',main='Global Active Power')
}

plot1_main <- function (filename) {
  pc <- load_pc(filename)
  png(filename = 'plot1.png')
  plot1(pc)
  dev.off()
}
