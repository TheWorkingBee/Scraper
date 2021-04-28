## ---- 3_format_df.R ----
#Making column names more user friendly
ad_df_formatted <- ad_df_raw %>% 
  rename("Antal_rum" = `Antal rum`, Pris_m2 = `Pris/m²`)

#Function to ease the formatting needed before casting each column
wrangler <- function(raw_strings, keyvals) {
  strings <- switch (keyvals,
                     "area" = raw_strings %>% 
                               str_replace_all(c("m²" = "", " " = "", "," = ".")),
                     "rooms" = raw_strings %>% 
                               str_replace_all(c("," = ".")) %>% 
                               str_remove("\\+"),
                     "rent" = raw_strings %>% 
                               str_replace_all(c("kr" = "", " " = "", "," = ".")),
                     "price_m2" = raw_strings %>% 
                               str_replace_all(c("kr" = "", " " = "", "," = ".")), 
                     "price" = raw_strings %>% 
                               str_replace_all(c("kr" = "", " " = "", "," = ".")),
                     raw_strings %>% 
                               str_replace_all(keyvals)
                     
  )
  strings %>%
    as.numeric()
}

#Formatting and casting all columns of the dataframe, making it ready for analysis
ad_df_formatted <- ad_df_formatted %>% 
  mutate(Boarea = wrangler(Boarea, "area")) %>% 
  mutate(Antal_rum = wrangler(Antal_rum, "rooms")) %>% 
  mutate(Månadsavgift = wrangler(Månadsavgift, "rent")) %>% 
  mutate(Pris_m2 = wrangler(Pris_m2, "price_m2")) %>%
  mutate(Pris = wrangler(Pris, "price"))