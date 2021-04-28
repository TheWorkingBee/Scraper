## ---- 1_download_files.R ----
#Creates urls for and downloads pages that contain the wanted ads
dir.create(data_file_path)
page_urls <- c()
for (i in 1:n_pages) {page_urls <- append(page_urls, next_ad_page(start_url, i))}
download_pages(page_urls, page_folder_path)

#Gets ad urls and then downloads them
urls <- scrape_files(page_folder_path, url_selector, scrape_urls)
download_pages(urls, ad_folder_path)
