# 📦 Install and loadinstall.packages(c("readxl", "dplyr", "caret", "cluster", "factoextra")) required packages

library(readxl)
library(dplyr)
library(caret)
library(cluster)
library(factoextra)

# 📄 Load data
df <- read_excel("Adidas US Sales Datasets.xlsx")

# 🧹 Clean and select necessary numeric columns
df_clust <- df %>%
  select(`Total Sales`, `Price per Unit`, `Units Sold`) %>%
  na.omit()

# 🔁 Create labels (Low, Medium, High) based on Total Sales for evaluation
df_clust$Sales_Class <- cut(df_clust$`Total Sales`,
                            breaks = quantile(df_clust$`Total Sales`, probs = c(0, 1/3, 2/3, 1)),
                            labels = c("Low", "Medium", "High"),
                            include.lowest = TRUE)

# ⚖️ Standardize features
scaled_data <- scale(df_clust[, c("Total Sales", "Price per Unit", "Units Sold")])

# 🔵 Run K-Means (3 clusters)
set.seed(123)
k_model <- kmeans(scaled_data, centers = 3, nstart = 25)

# ➕ Add cluster to original data
df_clust$Cluster <- as.factor(k_model$cluster)

# 🎨 Visualize clusters
fviz_cluster(k_model, data = scaled_data, geom = "point", ellipse.type = "norm")

library(cluster)
sil <- silhouette(k_model$cluster, dist(scaled_data))
summary(sil)
fviz_silhouette(sil)
view(df)