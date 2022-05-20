
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

ggplot(DAFFM_cPRC) +
  aes(x = frame, y = intensity, colour = stimuli) +
  geom_line(size = 0.5) +
  scale_color_hue(direction = 1) +
  theme_minimal()

DAFFM_cPRC <- subset(DAFFM, subset = stimuli == "cPRC")
DAFFM_NC <- subset(DAFFM, subset = stimuli == "NC")

DAFFM_cPRC_mean <- data.frame(frame = DAFFM_cPRC$frame, 
                                number = tapply(DAFFM_cPRC$intensity, DAFFM_cPRC$frame, length), 
                                mean = tapply(DAFFM_cPRC$intensity, DAFFM_cPRC$frame, mean))

DAFFM_NC_mean <- data.frame(frame = DAFFM_NC$frame, 
                              number = tapply(DAFFM_NC$intensity, DAFFM_NC$frame, length), 
                              mean = tapply(DAFFM_NC$intensity, DAFFM_NC$frame, mean))

#PRC
#sd
DAFFM_cPRC_mean$sd <- tapply(DAFFM_cPRC$intensity, DAFFM_cPRC$frame, sd)
#se
DAFFM_cPRC_mean$se <- DAFFM_cPRC_mean$sd/sqrt(DAFFM_cPRC_mean$n-1)

#95% confidence interval
DAFFM_cPRC_mean$CI_lower <- 
  DAFFM_cPRC_mean$mean + qt((1-0.95)/2, df=DAFFM_cPRC_mean$n-1) * DAFFM_cPRC_mean$se

DAFFM_cPRC_mean$CI_upper <- 
  DAFFM_cPRC_mean$mean - qt((1-0.95)/2, df=DAFFM_cPRC_mean$n-1) * DAFFM_cPRC_mean$se

#NC
#sd
DAFFM_NC_mean$sd <- tapply(DAFFM_NC$intensity, DAFFM_NC$frame, sd)
#se
DAFFM_NC_mean$se <- DAFFM_NC_mean$sd/sqrt(DAFFM_NC_mean$n-1)

#95% confidence interval
DAFFM_NC_mean$CI_lower <- 
  DAFFM_NC_mean$mean + qt((1-0.95)/2, df=DAFFM_NC_mean$n-1) * DAFFM_NC_mean$se

DAFFM_NC_mean$CI_upper <- 
  DAFFM_NC_mean$mean - qt((1-0.95)/2, df=DAFFM_NC_mean$n-1) * DAFFM_NC_mean$se

#graph:cPRC
ggplot(DAFFM_cPRC_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = DAFFM_cPRC, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color="deeppink3") +
  ylim(0.65,1.35)+
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=1.33, alpha=0.05, fill="purple") +
  annotate("segment", x=145, xend=165, y=1.15, yend=1.15, size=1.5)+
  annotate("segment", x=145, xend=145, y=1.15, yend=1.225, size=1.5)+
  annotate("text", x=155, y=1.138, label="10 sec", size=4.5)+
  annotate("text", x=157, y=1.19, label="0.5 ΔF/F0", size=4.5)+
  theme_void()

#graph:NC
ggplot(DAFFM_NC_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = DAFFM_NC, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=0.75, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.65,1.35)+
  theme_void()

