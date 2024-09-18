# you could initialize, or...

source("analysis/00_calculateBattingAvg.R")

# load in the extra packages you need 
# consider going back to the previous script to add it,
# or even writing an initialization script


# now we can just jump right into it
# make a plot for just one team...

ggplot(team, aes(x = location_x, y = location_y)) +
  geom_point(aes(color = player_name)) +
  theme_tufte()

# but we can do it even better 
# using functions from our previous script

teamIsHit.list <- lapply(atBats_byTeam, makeIsHit)
teamIH <- teamIsHit.list[[1]]

ggplot(teamIH, aes(x = location_x, y = location_y)) +
  geom_point(aes(color = player_name, shape = hit)) +
  theme_tufte()

# function time!

makeSpray <- function(team){
  teamName <- team$atBatTeam[4559]
  teamIsHit <- makeIsHit(team)
  
  teamIsHit <- teamIsHit[grepl("^A",teamIsHit$player_name), ]
  
  p <- ggplot(teamIsHit, aes(x = location_x, y = location_y)) +
    geom_point(aes(color = player_name, shape = hit)) +
    theme_tufte() +
    ggtitle(teamName)
  return(p)
}


makeSpray(atBats_byTeam[[1]])
makeSpray(atBats_byTeam[[2]])
makeSpray(atBats_byTeam[[3]])
makeSpray(atBats_byTeam[[4]])


teamSprays <- lapply(atBats_byTeam, makeSpray)

teamSprays$LAA

teamSprays$BOS + teamSprays$NYY

# talk about hardcoding and qualifying
# talk about removing NAs (non hits)











