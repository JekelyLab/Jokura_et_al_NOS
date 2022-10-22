
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

L_NAME_00mM_3d <- read_csv("data/2017-08-29_YDisplacement_3d_0mM_L-NAME_UV-Side-480nm-395nm-Good.csv")
L_NAME_01mM_3d <- read_csv("data/2017-08-29_YDisplacement_3d_0.1mM_L-NAME_UV-Side-480nm-395nm-Good.csv")
L_NAME_1mM_3d <- read_csv("data/2017-08-29_YDisplacement_3d_1mM_L-NAME_UV-Side-480nm-395nm-Good.csv")

L_NAME_00mM_3d_tidy <- gather(L_NAME_00mM_3d, key="0 mM", value="displacement", -time, -condition)
L_NAME_00mM_3d_conc <- gather(L_NAME_00mM_3d_tidy, key="concentration", value="batch", -time, -condition, -displacement)
L_NAME_01mM_3d_tidy <- gather(L_NAME_01mM_3d, key="0.1 mM", value="displacement", -time, -condition)
L_NAME_01mM_3d_conc <- gather(L_NAME_01mM_3d_tidy, key="concentration", value="batch", -time, -condition, -displacement)
L_NAME_1mM_3d_tidy <- gather(L_NAME_1mM_3d, key="1.0 mM", value="displacement", -time, -condition)
L_NAME_1mM_3d_conc <- gather(L_NAME_1mM_3d_tidy, key="concentration", value="batch", -time, -condition, -displacement)

L_NAME_3d <- bind_rows(L_NAME_00mM_3d_conc, L_NAME_01mM_3d_conc, L_NAME_1mM_3d_conc) %>%
  mutate(concentration = factor(concentration, levels = c("0 mM", "0.1 mM", "1.0 mM")))

L_NAME_3d %>%
  ggplot() +
  aes(x = reorder(condition, time), y = displacement, fill = concentration) +
  geom_boxplot() +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.75, 1.25))

ggsave("pictures/vertical_displacement_3dpf_L-NAME.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')







