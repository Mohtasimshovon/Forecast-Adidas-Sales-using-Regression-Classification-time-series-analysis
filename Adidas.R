install.packages("readxl")        # For reading Excel files
install.packages("dplyr")         # For data manipulation
install.packages("ggplot2")       # For visualization
install.packages("caret")         # For ML utilities and data partitioning
install.packages("randomForest")  # For classification modeling
install.packages("cluster")       # For clustering methods
install.packages("forecast")      # For time series forecasting
install.packages("tseries")       # For time series analysis
install.packages("lubridate")     # For date parsing
install.packages("tidyr") 
library(readxl)        # For reading Excel files
library(dplyr)         # For data manipulation
library(ggplot2)       # For visualization
library(caret)         # For machine learning utilities
library(randomForest)  # For classification
library(cluster)       # For clustering
library(forecast)      # For time series analysis
library(tseries)       # For time series tools
library(lubridate)     # For working with dates
library(tidyr)         # For data reshaping
df <- read_excel("Adidas US Sales Datasets.xlsx")