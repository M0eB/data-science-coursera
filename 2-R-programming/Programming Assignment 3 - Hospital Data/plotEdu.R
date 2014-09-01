



plotEdu <- function(data, xCol, yCol, title) {
      
      ##Extract columns
      xData <- data[,xCol]
      yData <- data[,yCol]
      
      
      
      
      ## Create and save plot      
      ##plot(maleAttSec,maleLit, col = 4)
      
      png(filename = paste(title,".png"), width = 1000, height = 600)
      par(bg = 'black')
      par(col.axis = 'white')
      par(col.main = 'white')
      par(col.lab = 'white')
      par(fg = 'white')
      
      plot(xData, yData, col = data[,'continent'], main = title, xlab = xCol, ylab = yCol, xlim = c(0,100), ylim = c(0,100), pch = 19)
      
      dev.off()
}


setDir <- function(){      
      setwd("C:/Users/Mohamed/Google Drive/Shared")
}

loadEduData <- function(filename) {
      data <- read.csv(filename, na.strings = c("?","_"))
      data[is.na(data)] <- ""      
      #na.omit(data)
}


runPlots <- function() {
      
      
      eduData <- loadEduData("edu.csv")
      #plotEdu(eduData, "literacy.male", "net.attendance.male.1", "Male Literacy VS Attendance - Primary School")
      
      plotEdu(eduData, "net.attendance.male", "literacy.male", "Primary SChool Attendance vs. Literacy - Male")
      plotEdu(eduData, "net.attendance.female", "literacy.female", "Primary School Attendance vs. Literacy - Female")
      
      plotEdu(eduData, "net.attendance.male.1", "literacy.male", "Secondary SChool Attendance vs. Literacy - Male")
      plotEdu(eduData, "net.attendance.female.1", "literacy.female", "Secondary School Attendance vs. Literacy - Female")
      
      plotEdu(eduData, "preschool.attendance.male", "literacy.male", "Pre-School Attendance vs. Literacy - Male")
      plotEdu(eduData, "preschool.attendance.female", "literacy.female", "Pre-School Attendance vs. Literacy - Female")
      
      plotEdu(eduData, "preschool.attendance.male", "literacy.male", "Pre-School Attendance vs. Literacy - Male")
      plotEdu(eduData, "preschool.attendance.female", "literacy.female", "Pre-School Attendance vs. Literacy - Female")
      
      
      
      
      plotEdu(eduData, "learning.support.male", "literacy.male", "Support vs Literacy - Male")
      plotEdu(eduData, "learning.support.female", "literacy.female", "Support VS Literacy - Female")
      
      plotEdu(eduData, "learning.support.father", "literacy.male", "Father Support VS Literacy - Male")
      plotEdu(eduData, "learning.support.father", "literacy.female", "Father Support VS Literacy - Female")
      
      plotEdu(eduData, "learning.support.rich", "literacy.male", "Learning Support VS Literacy - Rich - Male")      
      plotEdu(eduData, "learning.support.rich", "literacy.female", "Learning Support VS Literacy - Rich - Female")      
      
      
      
}




