# Preliminary analysis on time series data
# Import necessary packages
library(DBI)
library(RODBC)
library(odbc)
library(dplyr)
library(dbplyr)
library(RPostgreSQL)
# Read the configuration file
config <- config::get()

# Create a connection object
#conn <- dbConnect(
  #RPostgres::Postgres()
#  drv = dbDriver("PostgreSQL")
#  , user = config$user
#  , password = config$passwd
#  , port = config$port
#  , dbname = config$dbname
#)

tryCatch({
  drv <- dbDriver("PostgreSQL")
  print("Connecting to Database...")
  connec <- dbConnect(
    drv
    , dbname = config$dbname
    , host = config$host
    , port = config$port
    , user = config$user
    , password = config$passwd
  )
  print("Database Connected!")
},
error = function(cond) {
  print("Unable to connect to Database.")
})

dbListTables(connec)
connec

#drv <- dbDriver("PostgreSQL")
#connec <- dbCanConnect(
#  drv = dbDriver("PostgreSQL")
#  , dbname = config$dbname
#  , host = config$host
#  , port = config$port
#  , user = config$user
#  , password = config$passwd
#)
#connec

# Query the database and store the data in data frame
first_results <- dbGetQuery(
  connec
  , "SELECT *
  FROM timeseries_data
  LIMIT 25000;"
  )

# Quick view of the resulting data frame
head(first_results)
# Will plot the next 17 dependent variables
# Plot 1
plot(first_results$aimp ~ first_results$timestamp)
# Plot 2
plot(first_results$amud ~ first_results$timestamp)
# Plot 3
plot(first_results$arnd ~ first_results$timestamp)
# Plot 4
plot(first_results$asin1 ~ first_results$timestamp)
# Plot 5
plot(first_results$asin2 ~ first_results$timestamp)
# Plot 6
plot(first_results$adbr ~ first_results$timestamp)
# Plot 7
plot(first_results$adfl ~ first_results$timestamp)
# Plot 8
plot(first_results$bed1 ~ first_results$timestamp)
# Plot 9
plot(first_results$bed2 ~ first_results$timestamp, col = "blue")
# Plot 10
plot(first_results$bfo1 ~ first_results$timestamp, col = "darkolivegreen3")
# Plot 11
plot(first_results$bfo2 ~ first_results$timestamp, col = "darkcyan")
# Plot 12
plot(first_results$bso1 ~ first_results$timestamp, col = "deeppink4")
# Plot 13
plot(first_results$bso2 ~ first_results$timestamp, col = "cadetblue")
# Plot 14
plot(first_results$bso3 ~ first_results$timestamp, col = "darkorange")
# Plot 15
plot(first_results$ced1 ~ first_results$timestamp, col = "darkturquoise")
# Plot 16
plot(first_results$cfo1 ~ first_results$timestamp, col = "chartreuse4")
# Plot 17
plot(first_results$cso1 ~ first_results$timestamp, col = "coral3")

dbDisconnect(connec) # Disconnect from database
hist(first_results$cso1)
tail(first_results)
hist(first_results$asin1)


