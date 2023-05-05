
#Code to assemble Key resourece table of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
library(tidyverse)
library(gt)

library(readxl)
keyresource <- read_excel("~/NOSpaper_keyresourcetale.xlsx")

keyresource %>% 
  gt()
