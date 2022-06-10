
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

WT_3d <- read_csv("data/2017-08-29_YDisplacement_3d_NNxNN_UV-Side-480nm-395nm-Good.csv")
WT_3d_tidy <- gather(WT_3d, key="WT", value="displacement", -time, -condition)
WT_3d_tidy_phenotype <- gather(WT_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

NOS_3d <- read_csv("data/2017-08-29_YDisplacement_3d_nnxnn_UV-Side-480nm-395nm-Good (1).csv")
NOS_3d_tidy <- gather(NOS_3d, key="NOS", value="displacement", -time, -condition)
NOS_3d_tidy_phenotype <- gather(NOS_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

WTvsNOS_3d <- bind_rows(WT_3d_tidy_phenotype, NOS_3d_tidy_phenotype) %>%
  mutate(phenotype = factor(phenotype, levels = c("WT", "NOS")))

WTvsNOS_3d %>%
  filter(!(condition %in% c("dark_30", "dark_60", "dark_90", "dark_120", "dark_150", "dark_180", 
                            "dark_210", "dark_240", "dark_270", "dark_300", "sideUV_30", "sideUV_60", "sideUV_90", "sideUV_120")))%>%
  ggplot() +
  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
  geom_boxplot() +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-1, 1))









