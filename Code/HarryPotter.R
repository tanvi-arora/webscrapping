####################
# created by : Tanvi Arora
# Created Date : 2018/07/08
###################

##@knitr HP_fetchtable

# get URL for website
HP.file <- "https://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1"
#HP.doc<- xmlTreeParse(HP.fileurl, useInternal = TRUE)
HP.fileurl <- getURL(HP.file)

# Read HTML tables
HP.table.df <- readHTMLTable(HP.fileurl,as.data.frame=T)


##@knitr HP_cleantable


#fetch required table
#######################
# List of Casts seems to be the 3rd table

str(HP.table.df[[3]])

#extract cast and role 

HP.casts <- HP.table.df[[3]][,c(2,4)]
names(HP.casts) <- c("Actor","Character")
#HP.casts <- as.character(HP.casts)
str(HP.casts)

#HP.casts

# tidy table data
####################
# remove rows with NA
HP.casts <- HP.casts[!is.na(HP.casts$Actor),]

# remove carraigereturns or newlines 
HP.casts$Character <- str_replace_all(HP.casts$Character, "[\r\n]", "")

#HP.casts

# replace multiple whitespaces with single whitespace

HP.casts$Character <- str_squish(HP.casts$Character)

HP.casts

##@knitr HP_display
# Data Presentation

#Split Name into First Name , LastName
HP.casts$FirstName <- lapply(HP.casts$Actor, function(x) head(strsplit(as.character(x),split = " ")[[1]],-1))
HP.casts$Surname <- lapply(HP.casts$Actor, function(x) tail(strsplit(as.character(x),split = " ")[[1]],1))
#HP.casts$LastName <- strsplit(HP.casts$Actor, " ")[[-1]]

HP.casts.display <- subset(HP.casts,select =c("FirstName","Surname","Character"))

# Present the first 10 rows of the cast list
head(HP.casts.display,10)
