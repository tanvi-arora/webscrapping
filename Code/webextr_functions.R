####################
# created by : Tanvi Arora
# Created Date : 2018/07/08
###################


get_web_table <- function(fileurlstring, tablenum)
{
  
  # convert URL String to URL
  fileurl <- getURL(fileurlstring)
  
  # Read HTML tables
  table.df <- readHTMLTable(fileurl,as.data.frame=T)
  
  #return table requested
  table.df[[tablenum]]
}