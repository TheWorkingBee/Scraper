## ---- sql.R ----
# Packages used:
# library(RSQLite)

#saves dataframe in a sql-database to avoid redoing all work when knitting the project for the first time
save_latest_df <- function(table = df, name_table_to = "df") {
  #Remove previous version of df
  file.remove(db_path)
  
  conn <- dbConnect(RSQLite::SQLite(), db_path)
  dbWriteTable(conn, name_table_to, table)
  
  dbDisconnect(conn)
}

#retrieves the dataframe back into R
get_latest_df <- function(table = "df") {
  conn <- dbConnect(RSQLite::SQLite(), db_path)
  df <- dbReadTable(conn, table)
  
  dbDisconnect(conn)
  
  df
}
