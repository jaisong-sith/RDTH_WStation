# Project Name: RD Weather station report and analysis
# Programmer: Sith Jaisong
# Date:03152022

#---- Load library ----
library(tidyverse)
library(hms)
library(rvest)
library(lubridate)

#---- setting para ---- #
stationNo <- "23" # NKS station

sensorNo <- "000" # Temp sensor

startDate <- "2022-01-01"

endDate <- "2022-03-15"
#----------------#

# NOTE
#sensorNo
# 000 = temperature
# 001 = humidity
# 002 = pressure
# 003 = pyrometer
# 004 = rain gauge
# 005 = dew point
# 006 = BUS

#-----------------#

# stationNo
# KBI_RRC = 24  work
# KKN_RRC = 40  not work
# KLG_RRC = 2   klong long
# CSS_RRC = 8   not work
# CNT_RRC = 9   work
# CMP_RRC = 16  not work
# NRS_RRC = 17  not work
# NSR_RRC = 23  work
# PTT_RRC = 1   work
# PCR_RRC = 4   work
# PTN_RRC = 25  work
# AYT_RRC = 3   work
# PTL_RRC = 6   work
# PSL_RRC = 10  work
# RBR_RRC = 7   not work
# LBR_RRC = 22  not work
# SKN_RRC = 19  not work
# SMG_RRC = 11  not work
# SPB_RRC = 5   not work
# SRN_RRC = 21  not work
# NKN_RRC = 20  not work
# UDN_RRC = 18  not work
# UBN_RRC = 15  work
# CRI_RRC = 12  work
# CMI_RRC1 = 39 work
# CMI_RRC2 = 37 work
# PRE_RRC = 14  work
# MHS_RRC = 13  work
# KPP_RCC = 32  not work
# SBR_RCC = 28  not work
# UTT_RCC = 29  not work
# NKS_RCC = 38  work
# PYY_RCC = 36 not work
# PSL_RCC = 34 not work
# RBR_RCC(SPB) = 31 work
# RBR_RCC(Mueng) = 30 work
# ROI_RCC = 27 not work
# RBR_RCC = 33 work
# SKT_RCC = 35 not work
# PRE_RCC = 26 not work


#
baseUrl <- "http://bph.ricethailand.go.th/getdatalogger.php?"

url <- paste0(baseUrl,"dept=", stationNo, "&sensor=", sensorNo, "&from=", startDate, "&to=", endDate, "#")

dat.tab <- url %>% read_html() %>%
  html_table(header = TRUE) %>% .[[1]]

names(dat.tab) <- c("entry", "date", "time", "temp")
dat.tab$StationNo <- stationNo
dat.new <- dat.tab %>% mutate(entry = as.character(entry),
                              date = dmy(date),
                              time = as_hms(time),
                              temp = as.numeric(temp))

dat.new$date_time <- paste(dat.new$date, dat.new$time) %>% ymd_hms()


#----Visualize ----
dat.new %>% ggplot(aes(x = date_time, y = temp)) + geom_point() + geom_line()

