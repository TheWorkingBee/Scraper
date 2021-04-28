## ---- 2_create_raw_df.R ----

#Gets the names of all ad-files in the adfolder and appends their path to each name
ad_folder <- str_c(ad_folder_path, "/")
file_names <- dir(path = ad_folder, pattern = ".*html")
names <- str_c(ad_folder, file_names)
#Sort names to match id with adnumber
names <- names[order(nchar(names), names)]

#Empty dataframe for results from iterated scrape_table
ad_df_raw <- data.frame()

#A loop is used instead of scrape_files as bind_rows places the observations in the correct columns, thus preventing data mixup. We get colnames for free. 
# We get data.frame(Housetype, Area, Number of rooms, Rent, Price per m2, Street-address)
for (name in names) {
  file <- read_html(name)
  ad_df_raw <- bind_rows(ad_df_raw, scrape_table(file, table_div))
}

#Creating wanted variables that are not avaliable within the table
prices <- scrape_files(ad_folder_path, price_selector, scrape_selector)  
title <- scrape_files(ad_folder_path, title_selector, scrape_selector)  
Ids <- 1:length(names)
county <- scrape_files(page_folder_path, geo_selector, scrape_selector)  
#description <- scrape_files(ad_folder_path, description_selector, scrape_selector)  

#Finalizing df by collecting all that was scraped in one df
ad_df_raw <- ad_df_raw %>%
  mutate(Id = Ids, Pris = prices, Område = county, Titel = title)#, Beskrivning = description) 
