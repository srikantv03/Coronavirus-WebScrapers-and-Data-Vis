setwd("C:/Users/Srikant/Desktop/Coronavirus Data Stuff")
data <- read.csv(url("https://covidtracking.com/api/states/daily.csv"))
library(tidyverse)
library(gridExtra)
library(maps)
library(socviz)
library(tibble)
source("./myfunctionsaug.R")
source("./theme_map.R")

head(data)
names(data)

data <- data[c(1:4, 7, 8, 11:17)]
names(data)

us_states <- map_data("state")


view(us_states)

dim(data)



top_daily <- data[c(1:56),c(1:13)]


#add mergable values to socviz
top_daily <- add_column(top_daily, region = c(
  "alaska", "alabama", "arkansas", "am.somoa",
  "arizona", "california", "colorado", "connecticut",
  "district of columbia", "delaware", "florida", "georgia", "guam",
  "hawaii", "iowa", "idaho", "illinois", "indiana", 
  "kansas", "kentucky", "louisiana", "massachusetts", "maryland",
  "maine", "michigan", "minnesota", "missouri", "mp", "mississippi",
  "montana", "north carolina", "north dakota", "nebraska", "new hampshire",
  "new jersey", "new mexico", "nevada", "new york", "ohio", "oklahoma",
  "oregon", "pennsylvania", "pr", "rhode island", "south carolina", "south dakota",
  "tennessee", "texas", "utah", "virginia", "vi", "vermont", "washington",
  "wisconsin", "west virginia", "wyoming"
), .after = 13)

top_daily[c(1:56), c(2, 14)]
names(top_daily)

mergedCD <- left_join(us_states, top_daily)

mergedCD

totalIncrease <- 
  ggplot(data=mergedCD,
         mapping=aes(x=long, y=lat, group=group ,fill=positiveIncrease)) +
  geom_polygon(color="white", size=0.1) +
  coord_map(projection="albers", lat0=30, lat1=45) +
  scale_fill_gradient(low="#22369c", high="red") +
  labs(title="1-Day Increase in Coronavirus Cases Per State in Mainland US") +
  theme_map()

hist(top_daily$positiveIncrease, col="red",breaks=seq(0,8000,250),
                  main="Histogram of The Increases in Coronavirus Cases Within the Last Day",
                  xlab="Total Increase in Cases (within the last day)")


view(mergedCD)
print("Total Number of Cases in the United States")

names(top_daily)
totalIncrease
top_daily[, c(3)]
