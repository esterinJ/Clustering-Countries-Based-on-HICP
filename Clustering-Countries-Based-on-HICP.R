# Install pckgs 
install.packages("dplyr")
install.packages("ggplot2")
install.packages("eurostat")

# Load packages
library("dplyr")
library("ggplot2")
library("eurostat")

# Load Data
CP00 <- get_eurostat("prc_hicp_manr", select_time = "M", 
                     filters = list(
                       geo = c("BE", "BG", "CZ", "DK", "DE", "EE", "IE", "EL",
                               "ES", "FR", "HR", "IT", "CY", "LV", "LT", "LU", 
                               "HU", "MT", "NL", "AT",  "PL",  "PT",  "RO", 
                               "SI",  "SK",  "FI", "SE"),
                       coicop = "CP00"))

# Remove useless info
CP00 <- CP00[, -1]

# Filter by date
CP00 <- CP00 %>% filter(time > "2000-01") # From Feb 2000
CP00 <- CP00 %>% filter(time < "2022-10") # To Sept 2022

# Column labels
colnames(CP00)[1] = "id"
colnames(CP00)[2] = "country"

# Country Name from ISO2 
CP00 <- CP00 %>%
  mutate(country = recode(country,
                          BE = "Belgium",
                          BG = "Bulgaria",
                          CZ = "Czech Republic",
                          DK = "Denmark",
                          DE = "Germany",
                          EE = "Estonia",
                          IE = "Ireland",
                          EL = "Greece",
                          ES = "Spain",
                          FR = "France",
                          HR = "Croatia",
                          IT = "Italy",
                          CY = "Cyprus",
                          LV = "Latvia",
                          LT = "Lithuania",
                          LU = "Luxembourg",
                          HU = "Hungary",
                          MT = "Malta",
                          NL = "Netherlands",
                          AT = "Austria",
                          PL = "Poland",
                          PT = "Portugal",
                          RO = "Romania",
                          SI = "Slovenia",
                          SK = "Slovakia",
                          FI = "Finland",
                          SE = "Sweden"))

# Graphic visualization with ggplot2
CP00 %>%
  ggplot( aes(x = time, y = values, group = country, color = country))+
  geom_line() +
  ggtitle("HICP time series for EU countries")+ # title
  labs(caption = ("Source: Eurostat")) # source

# Remove useless info
CP00 <- CP00[, -1]

# Pivot data frame
CP00_pivot <- unstack(CP00, values ~ time, keep.names = TRUE)
row.names(CP00_pivot) <- unique(CP00$country)


# Convert pivot data frame to matrix
hicp_matrix <- as.matrix(CP00_pivot)

# Compute distance matrix
distance_matrix <- dist(hicp_matrix, method = "minkowski", p = 1.5)

# Perform clustering
clusters <- hclust(distance_matrix, method = "complete")

# Set the margins of the plot to reduce the size of the dendrogram
par(mar = c(1,3,2,1))

# Create dendrogram with labels
plot(clusters, labels = row.names(CP00_pivot), 
     cex = 0.8, 
     main = "Clustering countries based in HICP", 
     xlab = "", 
     ylab = "",
)

# Visualize the 4 clusters 
rect.hclust(clusters, k = 4, border = c(2, "red"))