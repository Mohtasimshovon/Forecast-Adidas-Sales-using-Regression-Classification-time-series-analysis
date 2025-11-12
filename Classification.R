# Load necessary libraries
install.packages("janitor")
library(janitor)
library(readxl)
library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)
library(lubridate)

# Read data and clean column names
df <- read_excel("Adidas US Sales Datasets.xlsx")
df <- janitor::clean_names(df)  # Removes spaces and converts to snake_case

# Extract month and year
df$month <- month(df$invoice_date)
df$year <- year(df$invoice_date)

# Remove missing values
df <- na.omit(df)

# Create 3 quantile bins for Total Sales
df$sales_class <- cut(df$total_sales,
                      breaks = quantile(df$total_sales, probs = c(0, 1/3, 2/3, 1)),
                      labels = c("Low", "Medium", "High"),
                      include.lowest = TRUE)

# Convert variables to appropriate types
df$retailer <- as.factor(df$retailer)
df$sales_method <- as.factor(df$sales_method)
df$sales_class <- as.factor(df$sales_class)
df$region <- as.factor(df$region)

# Convert numeric columns (even if already numeric, this ensures format)
df$price_per_unit <- as.numeric(df$price_per_unit)
df$total_sales <- as.numeric(df$total_sales)
df$units_sold <- as.numeric(df$units_sold)
df$operating_margin <- as.numeric(df$operating_margin)

# Select classification features
data_class <- df %>%
  select(sales_class, price_per_unit, units_sold, operating_margin,
         retailer, sales_method, region, month)

# Split into training and testing sets
set.seed(123)
train_index <- createDataPartition(data_class$sales_class, p = 0.7, list = FALSE)
train_data <- data_class[train_index, ]
test_data  <- data_class[-train_index, ]

# Train Random Forest model
model_rf <- randomForest(sales_class ~ ., data = train_data, importance = TRUE)

# Predict on test set
pred_rf <- predict(model_rf, test_data)

# Confusion matrix and accuracy
conf_mat <- confusionMatrix(pred_rf, test_data$sales_class)
print(conf_mat)
print(conf_mat$overall['Accuracy'])
