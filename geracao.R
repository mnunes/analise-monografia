library(lubridate)

data <- ymd("2021-02-01")
i    <- 10

for (j in 1:20){
  
  system(paste("lorem.sh -p ", 
               round(i, digits = 0), 
               " | pandoc -o ", 
               data, 
               ".pdf", 
               sep = ""))
  
  data <- data + 7*(rbinom(1, 1, prob = 0.5)+1)
  i    <- i + rnorm(1, mean = 10, sd = 5)

}

