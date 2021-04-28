## ---- site_scrapers.R ----
# Depends on:
# page_scrapers.R

#Uses one of the scrapers from page_scrapers.R to scrape listingspages from the webb
#Scrapes n_pages starting from the start_page_url, using a supplied scraper to target what the selector matches
#Returns an char array
scrape_pages <- function(start_page_url, n_pages, selector, scraper) {
  scraped <- c()  
  
  for (i in 1:n_pages) {
    current_page <- next_ad_page(start_page_url, i)
    page_html <- read_html(current_page)
    page_content <- scraper(page_html, selector)

    scraped <- append(scraped, page_content)
  }
  scraped  
}

#Built on same concept as scrape_pages, but works on html-files within folder_path instead. 
scrape_files <- function(folder_path, selector, scraper) {
  #Gets the names of all ad-files in ad_folder
  file_names <- dir(path = folder_path, pattern = ".*html")
  names <- str_c(folder_path, "/", file_names)
  #Sort names to match id with ad
  names <- names[order(nchar(names), names)]
  
  all_scraped <- c()
  for (name in names) {
    html <- read_html(name)
    scraped <- scraper(html, selector)
    all_scraped <- append(all_scraped, scraped)
  }
  all_scraped
}

