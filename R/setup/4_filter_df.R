## ---- 4_filter_df.R ----
#############################################FITERING##########################################
vacation_places <- c("((Å|å)re|(A|a)lanya|(K|k)airo)")

#Filtering ads that were wrongly listed or incomplete
ad_df_filtered <- ad_df_formatted %>% 
  #40k was used as appartments below this value were for rent, cabins, clickbait or appartement- shares (i.e. wrong type)
  filter(Pris > 40000) %>% 
  filter(!is.na(Pris)) %>%
  #Commercial flats are not to be included
  filter(!str_detect(Titel, "(l|L)okal")) %>%
  #Vacation places are outside of the scope of this report
  filter(!str_detect(Titel, vacation_places)) %>%
  #To compare the same observations on all aspects, we remove entries with missing information
  filter(!is.na(Boarea)) %>%
  filter(!is.na(Antal_rum)) %>%
  filter(!is.na(Månadsavgift)) %>%
  filter(!is.na(Pris_m2)) 
#############################################CORRECTING#########################################
correct <- function(df, ids, column, values) {
  #remove incorrect entries
  result <- df %>% 
    filter(!(Id %in% ids))
  
  corrected <- df %>% 
    filter((Id %in% ids))
  
  corrected[[column]] = values
  
  bind_rows(result, corrected)
}

#These ads were wrongfully removed due to information beeing entered in the wrong place
corrected_prices <- ad_df_formatted %>%
  filter(Id == 102 | Id == 58) %>%
  mutate(Pris = c(1100000, 1260000)) %>%
  mutate(Pris_m2 = Pris/Boarea)

#Creating the final data frame that is to be used for the analysis
ad_df <- ad_df_filtered %>% 
  #correct incorrect area in ad 316
  correct(316,"Boarea", 57.5) %>% 
  #correct streetaddresses
  correct(c(74, 101, 125, 237, 290),"Gatuadress",
          c("Boliden", "Hedvägen, Segeltorp", "Trädgårdsgatan 5, Oxelösund", "Södermalm", "Sörberge")) %>%
  #Skaraborg is not a county anymore and should be Västra Götaland
  mutate(Område = replace(Område, Område == "Skaraborg", "Västra Götaland")) %>% 
  #add wrongfully filtered ads
  bind_rows(corrected_prices) %>% 
  #remove columns that were only added for quality assurance
  select(-Titel, -Bostadstyp) %>% 
  #remove all entries that cannot be compared with the rest in all aspects
  na.omit()
  
  