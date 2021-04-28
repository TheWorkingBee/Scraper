## ---- downloaders.R ----
# Packages used:
# library(tidyverse)

#Input: url filled characterarray and a folder-name 
#Action: creates a folder with given name and downloads all files corresponding to the urls into it. 
download_pages <- function(urls, name) {
  #Creates a directory in current directory 
  dir.create(name)
  n_ads <- length(urls)
  print(name)  
  #Downloads all urls and names them according to name. Numbers them to distinguish files  
  for (i in 1:n_ads) {
    download.file(urls[i], str_c(name, "/", i, ".html"))
  }
  
}

#Outputs link to adpage on page page_number given an url and a page_number
#Will be used to generate the urls to listing-pages
next_ad_page <- function(url, page_number) {
  wanted_page <- str_c(url, "&page=", page_number)
  wanted_page
}
## ---- testing ----

#download_pages(c(urls[1], urls[2]), "ad")
