
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
