# the purpose of this script is to get each teams batting average

# initialize

rm(list = ls()) # clear environment

library(tidyverse)
library(ggthemes)
library(patchwork)

# load data

atBats2023 <- read.csv("data/clean/atBats_clean.csv")
load("data/clean/atBats_list.rdata")

# dput(unique(atBats2023$events))

allEvents <- unique(atBats2023$events)
allEvents
# index by name not number

outs <- c("strikeout", "field_out", "force_out", "double_play")
hits <- c("triple", "single", "home_run", "double")

# indexing by conditional is the true ideal

na <- allEvents[!allEvents %in% c(outs, hits)]

# now I like to try it out for one team

team <- atBats_byTeam[[1]]

teamBA <- team %>%
  mutate(atBat = ifelse(events %in% c(outs, hits), 1, 0),
         hit = ifelse(events %in% hits, 1, 0)) %>%
  group_by(player_name) %>%
  summarise(total_atBats = sum(atBat),
            total_hits = sum(hit)) %>%
  mutate(BA = total_hits/total_atBats)

# convert to function

makeBA <- function(team){
  teamBA.one <- team %>%
    mutate(atBat = ifelse(events %in% c(outs, hits), 1, 0),
           hit = ifelse(events %in% hits, 1, 0)) %>%
    group_by(player_name) %>%
    summarise(total_atBats = sum(atBat),
              total_hits = sum(hit)) %>%
    mutate(BA = total_hits/total_atBats)
  return(teamBA.one)
}

# then run on every team 

teamBA.list <- lapply(atBats_byTeam, makeBA)

teamBA.list[[7]]

# and even consider splitting it into two functions with a wrapper

makeIsHit <- function(team){
  h <- team %>%
    mutate(atBat = ifelse(events %in% c(outs, hits), T, F),
           hit = ifelse(events %in% hits, T, F))
  return(h)
}

makeBA.isHit <- function(isHit.df){
  ba <- isHit.df %>%
    group_by(player_name) %>%
    summarise(total_atBats = sum(atBat),
              total_hits = sum(hit)) %>%
    mutate(BA = total_hits/total_atBats)
  return(ba)
}

makeBA.wrapper<- function(team.df){
  isHit <- makeIsHit(team.df)
  ba <- makeBA.isHit(isHit)
  return(ba)
}

teamBA.list <- lapply(atBats_byTeam, makeBA.wrapper)









