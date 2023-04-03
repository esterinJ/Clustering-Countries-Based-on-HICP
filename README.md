# Clustering-Countries-Based-on-HICP

This project aims to cluster European Union countries based on their Harmonized Index of Consumer Prices (HICP) time series data. The code is written in R programming language and uses the dplyr, ggplot2, and eurostat packages.

## Installation
To run this project, you need to install the following packages:
```R
install.packages("dplyr")
install.packages("ggplot2")
install.packages("eurostat")
```


After installation, you need to load the packages:
```R
library("dplyr")
library("ggplot2")
library("eurostat")
```

## Data
The project loads HICP data for 28 EU countries from the Eurostat database. The data covers the period from January 2000 to September 2022.

The code cleans the data by removing unused columns, filtering the data by date, and renaming the columns. Additionally, the country codes are converted into country names.

## Clustering
The project clusters the countries using the hierarchical clustering method with complete linkage. The distance matrix is computed using the Minkowski distance with p=1.5. The dendrogram is plotted using the plot function in R, and the clusters are visually identified using the rect.hclust function.

## Usage
To run the project, copy the code into an R script, and run it in R. The code will download the data from the Eurostat database, perform clustering, and produce a dendrogram with country labels and cluster borders.
