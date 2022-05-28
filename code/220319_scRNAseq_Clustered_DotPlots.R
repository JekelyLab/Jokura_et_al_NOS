#Clear R's Brain
rm(list = ls())

library(tidyverse)
library(ggdendro)
library(patchwork)
library(ggtree)
library(cowplot)


gene_cluster <- read_csv('data/220319_scRNAseq_forR.csv')

gene_cluster %>%
  ggplot(aes(x=cluster, y = Gene, color = count, size = `% Expressing`)) + 
  geom_point()  


gene_cluster %>%
  filter(count > 0, `% Expressing` > 1) %>% 
  ggplot(aes(x=cluster, y = Gene, color = count, size = `% Expressing`)) + 
  geom_point() + 
  scale_color_viridis_c(name = 'log10') + 
  cowplot::theme_cowplot() + 
  theme(axis.line  = element_blank()) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ylab('') +
  theme(axis.ticks = element_blank())















