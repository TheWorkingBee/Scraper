## ---- 5_finalize_df.R ----
#Gets the coordinates for each ads address and returns them in a df data.frame(lng, lat)
coord_df <- get_saved_geodata()  
  #Use code below if you've setup the geocoder with your own api-key
  # ad_df %>% 
  # url_encode_addresses() %>% 
  # geocode_addresses()

#Clusters the prices of the ads
clusters <- ad_df %>% 
  pull(Pris) %>% 
  assign_cluster(3)

df <- ad_df %>% 
  #Add extra data
  bind_cols(coord_df) %>% 
  mutate(Cluster = factor(clusters, levels = c(3,2,1))) %>% 
  #Rename to correct language
  rename("Price" = Pris, 
         "Area" = Boarea, 
         "Rooms" = Antal_rum, 
         "Price_m2" = Pris_m2, 
         "Address" = Gatuadress,
         "County" = Område,
         "Rent" = Månadsavgift)
  
  
save_latest_df(df)
