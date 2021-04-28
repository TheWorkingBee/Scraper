## ---- geocoder.R ----
# Packages used:
# library(httr)
# library(jsonlite)
# library(tidyverse)

# Depends on:
# sql.R

#####################PREPARING REQUEST#####################################
url_encode_addresses <- function(ad_df) {
  ad_df %>% 
  select(Område, Gatuadress) %>% 
  #remove appartementnumber
  mutate(Gatuadress = str_remove_all(Gatuadress, "((L|l)(G|g)(H|h).*)")) %>% 
  #Combine street address and municipality
  mutate(Address = str_c(Gatuadress, ",", Område)) %>% 
  #percent encode result
  mutate(Encoded_address = map_chr(Address, ~ URLencode(.x, reserved = TRUE))) %>% 
  pull(Encoded_address)
}


##############################GETTING GEOCODED DATA###########################
#Returns a df with long and latitude given an address
geocode <- function(address) {
  key <- "Insert your key here" #Replace string with your api-key use this function
  request <- "https://api.opencagedata.com/geocode/v1/json?"
  query <- str_c("q=", address)
  key <- str_c("key=", key)
  parameters <- str_c(c(query, key), collapse = "&")
  request <- str_c(request, parameters)
  
  result = GET(url = request)
  
  content <- result %>% 
    content("text") %>% fromJSON()
  
  #Picks the best result from the dataframe with results
  coords <- content$results$geometry[1,]
  
  coords
}

# Uses geocode() iteratively to be able to geocode arrays
geocode_addresses <- function(url_encoded_addresses) {
  coords <- data.frame()
  iter <- 0
  for (address in url_encoded_addresses) {
    iter <- iter+1
    Sys.sleep(1)
    coord <- geocode(address)
    if(is.null(coord)) {print(iter)}
    coords <- coords %>%
      bind_rows(coord)
  }
  coords
}

#Used data saved in sql-db to 
get_saved_geodata <- function() {
  get_latest_df() %>% select(lng, lat)
}
