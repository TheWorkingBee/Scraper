## ---- extra.R ----
# Packages used:
# library(tidyverse)
# library(rvest)
# library(rstudioapi)

#sets directory to current directory when sourcing this file
this.directory <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(this.directory)

#Opens the html page (in webb browser) of the ads that corresponds to the supplied ids
open_files <- function(ids, file_location = ad_folder_path) {
  #Gets the names of all ad-files in ad_folder
  folder <- str_c(file_location, "/")
  file_names <- dir(path = folder, pattern = ".*html")
  names <- str_c(folder, file_names)
  #Sort names to match id with ad
  names <- names[order(nchar(names), names)]
  
  for (i in ids) {
    rstudioapi::viewer(names[i])
  }
}

#Reads the html of the ad with the supplied id
ad <- function(id, file_location = ad_folder_path) {
  #Gets the names of all ad-files in ad_folder
  folder <- str_c(file_location, "/")
  file_names <- dir(path = folder, pattern = ".*html")
  names <- str_c(folder, file_names)
  #Sort names to match id with ad
  names <- names[order(nchar(names), names)]
  
  read_html(names[id])

}

#used to get working directory in right place
wd <- function(){
  this.directory <- dirname(rstudioapi::getSourceEditorContext()$path)
  setwd(this.directory)
}





