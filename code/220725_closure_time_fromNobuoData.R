
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
library(multcomp)

#closure time for boxplot
closure_analysis <- read_csv("data/closure_time_inhibitor_donor.csv")

#Check all data  
ggplot(closure_analysis) +
  aes(x=condition, y = second, fill = condition) +
  geom_boxplot(shape = "circle") +
  geom_jitter(size = 3, alpha = 0.25, width = 0, colour = 'black') +
  scale_fill_manual(values = c(`Control` = "gray80",
                               `SNAP0.1` = "steelblue3",
                               `SNAP0.01` = "steelblue2",
                               `L-NAME1` = "lightcoral")
  ) +
  scale_y_continuous(breaks=seq(0,60,length=4),limits = c(0, 60))+
  labs(x = "Conditions", y = "Ciliary closure time (sec)") +
  scale_x_discrete(labels = c("L-NAME1"="NOS inhibitor","SNAP0.01"="10 µM \n NO donor","SNAP0.1"="100 µM \n NO donor"))+
  theme_classic() +
  theme(
    legend.position = "none",
    axis.title.y = element_text(size = 14L,face = "bold"),
    axis.title.x = element_text(size = 14L,face = "bold"),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
    )


#statistical test
SG_data <- lm(second ~ condition, data = closure_analysis) 
SG_res1<-aov(second ~ condition, d = closure_analysis)
summary(SG_res1)

conditionx=factor(closure_analysis$condition)
secondx=closure_analysis$second
summary(glht(aov(secondx~conditionx),linfct=mcp(conditionx="Dunnett")))




