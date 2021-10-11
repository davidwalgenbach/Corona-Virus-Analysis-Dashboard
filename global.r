library(shiny)
library(leaflet)
library(leaflet.minicharts)
library(dplyr)

data <- read.csv('us-counties.csv')
data2 <- read.csv('us-counties-geocodes.csv')
