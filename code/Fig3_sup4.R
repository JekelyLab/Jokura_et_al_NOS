#Code to plot NOS mutant and wt mature worm stats for the Jokura et al Platynereis NOS paper

# source packages ---------------------
library(dplyr)
library(tidyr)
library(ggplot2)
Okabe_Ito <- c(
  "#E69F00",
  "#56B4E9",
  "#009E73",
  "#F0E442",
  "#0072B2",
  "#D55E00",
  "#CC79A7",
  "#000000"
)

# load data ---------------------------------------------------

NOS_stats <- tibble::as_tibble(rio::import(
  "data/NOS_mutant_and_WT_mature_animals.csv"
))
NOS_stats
# tidy the data -----------------

NOS_stats_tidy <- NOS_stats |>
  mutate(DATE = lubridate::as_date((DATE))) |>
  pivot_longer(cols = contains("_"),
    names_to = c("genotype", "sex"),
    names_sep = "_",
    values_to = "mature_worms"
    ) |>
  rename(date = DATE) |>
  mutate(sex = case_when(sex == 'F' ~ 'female',
                        sex == 'M' ~ 'male')
         ) |>
  mutate(genotype = case_when(genotype == 'NOS11' ~ 'NOSΔ11',
                        genotype == 'NOS23' ~ 'NOSΔ23',
                        genotype == 'WT' ~ 'wild type')
         )


NOS_stats_tidy

#export source data
rio::export(NOS_stats_tidy, "source_data/Figure3_supplement4_source_data1.csv")

#plotting ----------------

NOS_stats_plot <- NOS_stats_tidy |>
  group_by(genotype, sex) |>
  ggplot() +
  geom_line(aes(date, mature_worms), size = 0.3) +
  geom_smooth(
    aes(date, mature_worms), 
    span = 0.01, size = 0.3, 
    na.rm = TRUE
    ) +
  facet_grid(~genotype ~sex) +
  scale_y_continuous(limits = c(0, 40)) +
  labs(y = "mature worms") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90))

NOS_stats_plot

ggsave(
  "Manuscript/figures/Fig3_sup4.png",
  limitsize = FALSE,
  units = c("px"),
  NOS_stats_plot,
  width = 2200,
  height = 1400,
  bg = 'white'
)


ggsave(
  "Manuscript/figures/Fig3_sup4.pdf",
  limitsize = FALSE,
  units = c("px"),
  NOS_stats_plot,
  width = 2200,
  height = 1400
)
