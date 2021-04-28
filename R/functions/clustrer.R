## ---- clustrer.R ----
# Packages used:
# library(tidyverse)

#Takes a vector of values and returns their clusternuber in the same order as supplied
assign_cluster <- function(vals, n_clusts, clustring_method = "average") {
  vals %>% 
    dist() %>% 
    hclust(method = clustring_method) %>% 
    cutree(k = n_clusts)
}