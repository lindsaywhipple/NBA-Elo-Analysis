library(ggplot2)
library(gganimate)
library(ggthemes)
library(viridis)
library(readr)
library(dplyr)
library(lubridate)


# Load Top 5 Teams Data
nba_df <- read_csv("~/Desktop/NBA Mini Project/nbaallelo.csv")
nba_df <- nba_df %>% select(-c('_iscopy', notes, gameorder, elo_n, opp_elo_n, win_equiv))
nba_final <- nba_df %>% mutate(result = case_when(game_result == "W" ~ 1,
                                                  game_result == "L" ~ 0)) %>%
  mutate(date_game = mdy(date_game),
         month = month(date_game, label = TRUE),
         weekday = wday(date_game, label = TRUE)) %>%
  select(-game_result)

nba <- filter(nba_df, fran_id == "Heat" | fran_id == "Bulls" | fran_id == "Lakers" | fran_id == "Spurs" | fran_id == "Magic")  # this seems like I was hardcoding it?
nba <- filter(nba, year_id == "2000" | year_id == "2001" | year_id == "2002" | year_id == "2003" | year_id == "2004" | year_id == "2005" | year_id == "2006" | year_id == "2007" | year_id == "2008" | year_id == "2009" | year_id == "2010" | year_id == "2011" | year_id == "2011" | year_id == "2012" | year_id == "2013" | year_id == "2014" | year_id == "2015")
nba <- filter(nba, seasongame == "1")

# Load Bottom 5 Teams Data

nba2 <- filter(nba_df, fran_id == "Nets" | fran_id == "Wizards" | fran_id == "Pistons" | fran_id == "Clippers" | fran_id == "Warriors") 
nba2 <- filter(nba2, year_id == "2000" | year_id == "2001" | year_id == "2002" | year_id == "2003" | year_id == "2004" | year_id == "2005" | year_id == "2006" | year_id == "2007" | year_id == "2008" | year_id == "2009" | year_id == "2010" | year_id == "2011" | year_id == "2011" | year_id == "2012" | year_id == "2013" | year_id == "2014" | year_id == "2015")
nba2 <- filter(nba2, seasongame == "1")


# TOP 5 REGULAR SEASON POINTS
anim1 <- ggplot(nba, aes(x = year_id, y = pts, colour = fran_id)) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  theme_fivethirtyeight() +
  labs(title = "Top 5 Teams: Points Per Game", 
       subtitle = "Year: {frame_time}",
       x = "Year", y = "Points") +
  transition_time(year_id)

animate(anim1, width = 800, height = 500, renderer = gifski_renderer("top5_pts.gif"))

# BOTTOM 5 REGULAR SEASON POINTS

anim2 <- ggplot(nba2, aes(x = year_id, y = pts, colour = fran_id)) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  theme_fivethirtyeight() +
  labs(title = "Bottom 5 Teams: Points Per Game", 
       subtitle = "Points: {frame_time}",
       x = "Year", y = "Points") +
  transition_time(pts)

animate(anim2, width = 800, height = 500, renderer = gifski_renderer("bottom5_pts.gif"))

# TOP 5 POINTS VS. OPPONENT POINTS - maybe add a bottom 5 too?

anim3 <- ggplot(nba, aes(x = opp_pts, y = pts, colour = fran_id)) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  theme_fivethirtyeight() +
  labs(title = "Top 5: Points vs Opponent", 
       subtitle = "Opponent Points: {frame_time}",
       x = "Opponent Points", y = "Points") +
  transition_time(opp_pts)

animate(anim3, width = 800, height = 500, renderer = gifski_renderer("top5_vs_opp.gif"))

# BOTTOM 5 POINTS VS. OPPONENT POINTS

anim4 <- ggplot(nba2, aes(x = opp_pts, y = pts, colour = fran_id)) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  theme_fivethirtyeight() +
  labs(title = "Bottom 5: Points vs Opponent", 
       subtitle = "Opponent Points: {frame_time}",
       x = "Opponent Points", y = "Points") +
  transition_time(opp_pts)

animate(anim4, width = 800, height = 500, renderer = gifski_renderer("bottom5_vs_opp.gif"))

# TOP 5 POINTS VS. ELO

anim5 <- ggplot(nba, aes(x = elo_i, y = pts, colour = fran_id)) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  scale_x_log10() +
  theme_fivethirtyeight() +
  labs(title = "Top 5: Points vs Elo", 
       subtitle = "Elo: {frame_time}",
       x = "Elo Rating", y = "Points") +
  transition_time(elo_i)

animate(anim5, width = 800, height = 500, renderer = gifski_renderer("top5_vs_elo.gif"))

# BOTTOM 5 - POINTS VS. ELO

anim5 <- ggplot(nba2, aes(x = elo_i, y = pts, colour = fran_id)) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  scale_x_log10() +
  theme_fivethirtyeight() +
  labs(title = "Bottom 5: Points vs Elo", 
       subtitle = "Elo: {frame_time}",
       x = "Elo Rating", y = "Points") +
  transition_time(elo_i)

animate(anim5, width = 800, height = 500, renderer = gifski_renderer("bottom5_vs_elo.gif"))




