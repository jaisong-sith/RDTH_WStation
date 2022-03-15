# Project Name: RD Weather station report and analysis
# Programmer: Sith Jaisong
# Date:03152022

#---- Load library ----
library(tidyverse)
library(rvest)
library(lubridate)

#---- setting para ---- #
stationNo <- "23" # NKS station

sensorNo <- "000" # Temp sensor

startDate <- "2022-01-01"

endDate <- "2022-03-15"
#----------------#

baseUrl <- "http://bph.ricethailand.go.th/getdatalogger.php?"

url <- paste0(baseUrl,"dept=", stationNo, "&sensor=", sensorNo, "&from=", startDate, "&to=", endDate, "#")

dat.tab <- url %>% read_html() %>%
  html_table(header = TRUE) %>% .[[1]]

# R cant read Thai
names(dat.tab) <- c("entry", "date", "time", "temp")
dat.tab$StationNo <- stationNo
dat.tab$date_strf <- strftime(dat.tab$date, "%d/%m/%y")
dat.tab$date_time <- mdy_hms(paste(dat.tab$date, dat.tab$time))

#v problem with thai year 2565 to AD  2022
#----------------------------

#----Visualize ----
dat.tab %>% ggplot(x = date, y = temp) + geom_point()

