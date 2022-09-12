
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

WT_2d <- read_csv("data/2017-08-29_YDisplacement_2d_NNxNN_UV-Side-480nm-395nm-Good.csv")
WT_2d_tidy <- gather(WT_2d, key="WT", value="displacement", -time, -condition)
WT_2d_tidy_phenotype <- gather(WT_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

NOS_2d <- read_csv("data/2017-08-29_YDisplacement_2d_nnxnn_UV-Side-480nm-395nm-Good (1).csv")
NOS_2d_tidy <- gather(NOS_2d, key="NOS", value="displacement", -time, -condition)
NOS_2d_tidy_phenotype <- gather(NOS_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

WTvsNOS_2d <- bind_rows(WT_2d_tidy_phenotype, NOS_2d_tidy_phenotype) %>%
  mutate(phenotype = factor(phenotype, levels = c("WT", "NOS")))

WTvsNOS_2d %>%
  ggplot() +
  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
  geom_boxplot() +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-1, 1.2))

ggsave("pictures/vertical_displacement_2dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')







