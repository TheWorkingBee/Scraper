## ---- user_input.R ----

#Date 2020-03-12
#Link to starting page for appartements that listed for sale on blocket and number of pages to be scraped
home_url <- "https://www.blocket.se"
start_url <- "https://www.blocket.se/annonser/hela_sverige/bostad/lagenheter?cg=3020"
n_pages <- 9

#selectors
table_div <- "KeyValTable__Row-ku6uw2-0 dhntKE"
price_selector <- ".EkzGO"
geo_selector <- ".dxqCwo+ .dxqCwo"
url_selector <- ".Rycta"
title_selector <- ".gjFLVU"
description_selector <- ".bYSeDO"

#names of folders to be created
data_file_path <- "../Data"
ad_folder_path <- str_c(data_file_path, "/", "ad")
page_folder_path <- str_c(data_file_path, "/", "page")
db_path <- str_c(data_file_path, "/", "df.db")


