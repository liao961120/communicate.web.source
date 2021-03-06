Sys.setlocale(category = "LC_ALL", locale = "cht")
library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)

m2008 <- read_csv("./china/m2008.csv")%>%rename("Travelers"=`number of visitors`)
m2009 <- read_csv("./china/m2009.csv")%>%rename("Travelers"=`number of visitors`)
m2010 <- read_csv("./china/m2010.csv")%>%rename("Travelers"=`number of visitors`)
m2008_2010 <- read_csv("./china/m2008_2010.csv")%>%
    rename("Travelers"=`number of visitors`)%>%
    separate(Month,c("Year","Month"),sep="/") %>%
    mutate(Month=ifelse(Month %in% 1:9 ,paste(Year,"/0",Month,sep = ""),paste(Year,"/",Month,sep = ""))) %>%
    select(Month,Location,Travelers)

China08_17 <- read_csv("./china/China08_17.csv")%>%
    rename("Travelers"=`number of visitors`)%>%
    separate(Month,c("Year","Month"),sep="/") %>%
    mutate(Month=ifelse(Month %in% 1:9 ,paste(Year,"/0",Month,sep = ""),paste(Year,"/",Month,sep = ""))) %>%
    select(Month,Location,Travelers)

newm2012_2017 <- read_csv("./china/newm2012_2017.csv")%>%
    rename("Travelers"=`number of visitors`)%>%
    separate(Month,c("year","Month"),sep="/") %>%
    mutate(Month=ifelse(Month %in% 1:9 ,paste(year,"/0",Month,sep = ""),paste(year,"/",Month,sep = ""))) %>%
    select(Month,Location,Travelers)

m2008_2010_2 <- m2008_2010 %>%
    filter(Location=="中國大陸"|Location=="日本")

newm2012_2017_2 <- newm2012_2017 %>%
    filter(Location=="中國大陸"|Location=="日本")

## Plotting
pl_2008_ea <- ggplot(m2008,mapping = aes(x=Month, y=Travelers/10000))+
    geom_line(mapping = aes(color=Location))+
    scale_x_continuous(limits=c(1,12) ,breaks=1:12)+
    scale_y_continuous(breaks=seq(0, 30, by=2))+
    labs(title = "2008 台灣人前往東亞地區",x="月份",y="萬人\n \n",color="")
# ggplotly(pl_2008_ea)

pl_2009_ea <- ggplot(m2009,mapping = aes(x=Month, y=Travelers/10000))+
    geom_line(mapping = aes(color=Location))+
    scale_x_continuous(limits=c(1,12) ,breaks=1:12)+
    scale_y_continuous(breaks=seq(0, 30, by=2))+
    labs(title = "2009 台灣人前往東亞地區",x="月份",y="萬人\n \n",color="")
# ggplotly(pl_2009_ea)

pl_2010_ea <- ggplot(m2010,mapping = aes(x=Month, y=Travelers/10000))+
    geom_line(mapping = aes(color=Location))+
    scale_x_continuous(limits=c(1,12) ,breaks=1:12)+
    scale_y_continuous(breaks=seq(0, 30, by=2))+
    labs(title = "2010 台灣人前往東亞地區",x="月份",y="萬人\n \n",color="")
# ggplotly(pl_2010_ea)


mlabels=unique(m2008_2010$Month)
m2008_2010$Month = factor(m2008_2010$Month, labels=mlabels, ordered=T)
index <- seq.int(1, length(m2008_2010$Month), by=2)

pl_2008_10_ea <- ggplot(m2008_2010,mapping = aes(x=Month, y=Travelers/10000, group=Location))+
    geom_line(mapping = aes(color=Location))+
    scale_x_discrete(breaks=m2008_2010$Month[index]) +
    scale_y_continuous(breaks=seq(0, 30, by=2))+
    labs(title = "2008-2010 台灣人前往東亞地區(月)",x=" ",y="萬人\n \n",color="")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
# ggplotly(pl_2008_10_ea)


mlabels=unique(m2008_2010_2$Month)
m2008_2010_2$Month = factor(m2008_2010_2$Month, labels=mlabels, ordered=T)
index <- seq.int(1, length(m2008_2010_2$Month), by=2)

pl_2008_10_2 <- ggplot(m2008_2010_2,mapping = aes(x=Month, y=Travelers/10000, group=Location))+
    geom_line(mapping = aes(color=Location))+
    scale_x_discrete(breaks=m2008_2010_2$Month[index]) +
    scale_y_continuous(breaks=seq(0, 30, by=2))+
    labs(title = "2008-2010 台灣人前往中國/日本",x=" ",y="萬人\n \n",color="")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
# ggplotly(pl_2008_10_2)

mlabels=unique(China08_17$Month)
China08_17$Month = factor(China08_17$Month, labels=mlabels, ordered=T)
index <- seq.int(1, length(China08_17$Month), by=3)

pl_2008_17_ch <- ggplot(China08_17,mapping = aes(x=Month, y=Travelers/10000, group=Location))+
    geom_line(mapping = aes(color=Location))+
    geom_smooth(method="lm",formula=y~poly(x, 3),color="skyblue")+
    scale_x_discrete(breaks=China08_17$Month[index]) +
    scale_y_continuous(breaks=seq(0, 45, by=3))+
    labs(title = "2008-2017 台灣人前往中國(月)",x=" ",y="萬人<br> <br>",color="")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
# ggplotly(pl_2008_17_ch)


mlabels=unique(newm2012_2017$Month)
newm2012_2017$Month = factor(newm2012_2017$Month, labels=mlabels, ordered=T)
index <- seq.int(1, length(newm2012_2017$Month), by=2)

pl_2012_17_all <- ggplot(newm2012_2017,mapping = aes(x=Month, y=Travelers/10000, group=Location))+
    geom_line(mapping = aes(color=Location))+
    scale_x_discrete(breaks=newm2012_2017$Month[index]) +
    scale_y_continuous(breaks=seq(0, 45, by=3))+
    labs(title = "2012-2017 台灣人最常前往地區(月)",x=" ",y="萬人\n \n",color="")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
# ggplotly(pl_2012_17_all)

mlabels=unique(newm2012_2017_2$Month)
newm2012_2017_2$Month = factor(newm2012_2017_2$Month, labels=mlabels, ordered=T)
index <- seq.int(1, length(newm2012_2017_2$Month), by=2)

pl_2012_17_2<- ggplot(newm2012_2017_2,mapping = aes(x=Month, y=Travelers/10000, group=Location))+
    geom_line(mapping = aes(color=Location))+
    scale_x_discrete(breaks=newm2012_2017_2$Month[index]) +
    scale_y_continuous(breaks=seq(0, 45, by=3))+
    labs(title = "2012-2017 台灣人前往中國/日本",x=" ",y="萬人\n \n",color="")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
# ggplotly(pl_2012_17_2)
