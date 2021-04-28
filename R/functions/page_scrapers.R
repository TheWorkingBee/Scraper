## ---- page_scrapers.R ----
#packages used:
# library(tidyverse)
# library(rvest)

#Scrapes a supplied html-file for content that matches the supplied selector and returns the result as a char-array
scrape_selector <- function(html, selector = ".cfhypK") {
  scraped <- html_nodes(html, selector) %>% 
    html_text()
  #Makes sure to return a result if scrape fails
  if (is_empty(scraped)) {
    return(NA)
  }
  scraped
}

#Same functionality as scrape_selector but scrapes according to a classname instead. Returns html instead of text. 
div_html <- function(html, div_class) {
  html %>% 
    html_nodes(xpath = str_c('//*[@class="', div_class, '"]')) 

}

#As div_html, but returns the result as text instead of html
div_text <- function(html, div_class) {
  div_html(html, div_class) %>% 
    html_children() %>% 
    html_text()
}

#As div_text, but specifically for blocket-tables. Returns table as data.frame.
scrape_table <- function(html, div_class) {
  table_rows <- div_html(html, div_class)
  columns <- c()
  values <- c()
  for (i in table_rows) {
    scraped <- i %>% 
      html_children() %>% 
      html_text()
    
    columns <- append(columns, scraped[1])
    values <- append(values, scraped[2])
  }
  
  matrix(values, nrow = 1) %>% 
    data.frame() %>% 
    setNames(columns)
}

#Get all ad-urls from a html_page
scrape_urls <- function(html, ad_selector, page_home = home_url) {
  nodes <-  html_nodes(html, ad_selector)  
  links <- html_attr(nodes, "href")
  str_c(page_home, links)
}
