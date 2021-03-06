# setwd("C:/Users/user/rlads_communicate/communicate.web.source")
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(plotly)
library(dygraphs)
library(flexdashboard)
library(RColorBrewer)
library(scales)

# hue_pal()(4) # function to generate ggplot palette, 4 indicates 4 colors


## unemployment rate and total # of travelers
tour_unem <- read_csv("./unemployment.disease/data/unemployment_tour.csv") %>% ## source: unemployment.R
    mutate("Count"=Count/1000000) %>% # rescale to become more readable
    select(Year, Count, rate)


pl_unem <- dygraph(tour_unem,main="2001-2015 失業率vs.出國旅遊人數") %>%
    dyOptions(axisLabelFontSize = 12, axisLineWidth = 0.8, drawGrid=F) %>%
    dyAxis("y", label = "旅遊人數(百萬)",axisLabelColor = hue_pal()(2)[2]) %>%
    dyAxis("y2", label = "失業率(%)",axisLabelColor = hue_pal()(2)[1],independentTicks = TRUE) %>%
    dySeries("rate", axis = 'y2', label = "失業率(%)",strokeWidth =1.5,color = hue_pal()(2)[1]) %>%
    dySeries("Count", axis = 'y', label = "旅遊人數(百萬)",strokeWidth =1.5,color=hue_pal()(2)[2]) %>%
    # dyRangeSelector(height = 20, strokeColor = "") %>%
    dyHighlight(highlightSeriesOpts = list(strokeWidth = 3),highlightSeriesBackgroundAlpha = 1) %>%
    dyLegend(labelsSeparateLines=T)
