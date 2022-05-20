
#Clear R's Brain
rm(list = ls())

library(dplyr)
library(ggplot2)
library(tidyverse)
library(scales)
library(plotly)
library(ggplotgui)
library(tidyr)
library(esquisse)
library(ggraptR)
library(readr)

DAFFM <- read_csv("data/220213_DAF-FM_long.csv")

#20220214_DAF-FM DA was injected and changes in nitric oxide during UV irradiation were observed.

ggplot(DAFFM) +
  aes(x = frame, y = intencity, colour = stimuli) +
  geom_line(size = 0.5) +
  scale_color_hue(direction = 1) +
  theme_minimal()


ggplot(DAFFMDA) +
  aes(x = frame, y = `DAF-FM`, colour = stimuli) +
  geom_ribbon(
    mapping = aes(ymin = SE_lower,
                  ymax = SE_upper),
    fill = "#A4A4A4"
  ) +
  geom_line(size = 1L) +
  scale_color_hue(direction = 1) +
  theme_minimal() +
  ylim(0.8, 1.2)



