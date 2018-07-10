####################
# created by : Tanvi Arora
# Created Date : 2018/07/08
###################


##@knitr SB_fetchtable

# get URL for website
sb.table.df <- get_web_table("http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs",2)

str(sb.table.df)

##@knitr SB_cleantable

# convert factor data to character
sb.table.df.c <- rapply(sb.table.df, as.character , classes="factor", how="replace")
str(sb.table.df.c)



# define column names
# first record is the header. Assign it to column names and remove it from the observation
# substitute '%' in header name with _per
sb.table.df.c[1,] <- str_replace_all(sb.table.df.c[1,],"%","_per")
# assign names
names(sb.table.df.c) <- sb.table.df.c[1,]
str(sb.table.df.c)
#first record is the header record, which is not an observation, remove it from dataframe
sb.table.df.c <- tail(sb.table.df.c,-1)
head(sb.table.df.c)
# last record is the Totals row, which is not an observation. Remove it from the dataframe

sb.table.df.c <- head(sb.table.df.c,-1)
tail(sb.table.df.c)

# convert character to numeric
sb.table.df.c[,2:15] <- lapply(sb.table.df.c[,2:15], function(x) as.numeric(as.character(x)))
str(sb.table.df.c)


# split PLAYER into Player_name, Player_position

sb.table.df.c$Playername <- sapply(sb.table.df.c$PLAYER , function(x)  head(strsplit(x,split = ",")[[1]] ,1))
sb.table.df.c$Playerposition <- sapply(sb.table.df.c$PLAYER , function(x) tail(strsplit(x,split = ",")[[1]] ,1))

# display dataframe
sb.table.df.c
str(sb.table.df.c)

##@knitr SB_Plottable

ggplot(data=sb.table.df.c, aes(reorder(Playername,FG_per),FG_per)) + geom_bar(stat= "identity", aes(fill = Playerposition)) + coord_flip() + labs(title="Field Goals Percentage Per Game of each Player", caption="source : http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs") + xlab("NBA Player") + ylab("Field Goals Percentage Per Game")


