# the purpose of this script is to show an example
# of how I would get a clean data frame of just red sox at bats

# initialize

rm(list = ls()) # clear environment

library(tidyverse)

# load data

atBats2023 <- read.csv("data/raw/atBats2023.csv")

# get red sox batters

redSoxBats <- atBats2023 %>%
  
  # make a column showing which team is at bat
  mutate(atBatTeam = ifelse(inning_topbot %in% "Top", 
                            away_team, home_team)) %>%
  
  # filter down to just red sox
  filter(atBatTeam %in% "BOS")

# write a clean csv

write.csv(redSoxBats, file = "data/clean/redSoxBats.csv",
          row.names = F)



