data_file <- "C:/Users/jesse/documents/code/4_semester/biometrie/ruwe_data/meten.csv"

#data format: gender;lengte;l arm;meter;Id
res_data <- read.table(file = data_file,
                             header = TRUE,
                             sep = ";")

res_data$ratio <- res_data$lengte / res_data$"l.arm"

mean(res_data[res_data$gender == "Vrouw" , "l.arm"]) # vrouw arm lengte

mean(res_data[res_data$gender == "Man" , "l.arm"]) # man arm lengte

#split over gender into list of dataframes
gender_split_data <- split(x = res_data,
                           f = res_data$gender)

#apply a function to report means of both measurements
sapply(X = gender_split_data,
       FUN = function(x){
         c(length = mean(x$lengte),
           arm = mean(x$l.arm),
           ratio = mean(x$ratio))
       })
