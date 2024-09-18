# the purpose of this script is to split the big data frame
# into a list of data frames for each team

# initialize

rm(list = ls()) # clear environment

library(tidyverse)

# load data

atBats2023 <- read.csv("data/raw/atBats2023.csv")

# modify to determine which team is at bat
# I do this in both scripts, which should send off warning bells!

# people have mixed feelings about overwriting objects
# so do I...
atBats2023 <- atBats2023 %>%
  mutate(atBatTeam = ifelse(inning_topbot %in% "Top", 
                            away_team, home_team))

atBats_byTeam <- split(atBats2023, ~atBatTeam)  

# save what I want

write.csv(atBats2023, file = "data/clean/atBats_clean.csv", row.names = F)
save(atBats_byTeam, file = "data/clean/atBats_list.rdata")
  
  
  
  
  
  

