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
library(patchwork)


WTvsNOS11_cPRC_INNOS <- read_csv("data/211129_WTvsNOS11_cPRC_INNOS (2).csv")

WT_cPRC <- WTvsNOS11_cPRC_INNOS %>% select(frame, starts_with("WT_cPRC"))
NOS11_cPRC <- WTvsNOS11_cPRC_INNOS %>% select(frame, starts_with("NOS11_cPRC"))


WT_cPRC_tidy <- WT_cPRC %>% 
  pivot_longer(cols = -c("frame"),
    names_to = "phenotype",
    values_to = "intensity"
    ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")

NOS11_cPRC_tidy <- NOS11_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")

#Check all data   
ggplot(NOS11_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 



#tapply
WT_cPRC_tidy_mean <- data.frame(frame = WT_cPRC$frame, 
                                number = tapply(WT_cPRC_tidy$intensity, WT_cPRC_tidy$frame, length), 
                                mean = tapply(WT_cPRC_tidy$intensity, WT_cPRC_tidy$frame, mean))

#sd
WT_cPRC_tidy_mean$sd <- tapply(WT_cPRC_tidy$intensity, WT_cPRC_tidy$frame, sd)
#se
WT_cPRC_tidy_mean$se <- WT_cPRC_tidy_mean$sd/sqrt(WT_cPRC_tidy_mean$n-1)

#95% confidence interval
WT_cPRC_tidy_mean$CI_lower <- 
  WT_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=WT_cPRC_tidy_mean$n-1) * WT_cPRC_tidy_mean$se

WT_cPRC_tidy_mean$CI_upper <- 
  WT_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=WT_cPRC_tidy_mean$n-1) * WT_cPRC_tidy_mean$se





#tapply
NOS11_cPRC_tidy_mean <- data.frame(frame = NOS11_cPRC$frame, 
                                number = tapply(NOS11_cPRC_tidy$intensity, NOS11_cPRC_tidy$frame, length), 
                                mean = tapply(NOS11_cPRC_tidy$intensity, NOS11_cPRC_tidy$frame, mean))
#sd
NOS11_cPRC_tidy_mean$sd <- tapply(NOS11_cPRC_tidy$intensity, NOS11_cPRC_tidy$frame, sd)
#se
NOS11_cPRC_tidy_mean$se <- NOS11_cPRC_tidy_mean$sd/sqrt(NOS11_cPRC_tidy_mean$n-1)

#95% confidence interval
NOS11_cPRC_tidy_mean$CI_lower <- 
  NOS11_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=NOS11_cPRC_tidy_mean$n-1) * NOS11_cPRC_tidy_mean$se

NOS11_cPRC_tidy_mean$CI_upper <- 
  NOS11_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=NOS11_cPRC_tidy_mean$n-1) * NOS11_cPRC_tidy_mean$se


head(NOS11_cPRC_tidy_mean)


#graph
p1 <- ggplot(WT_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=20, xend=40, y=1.5, yend=1.5, size=1)+
  annotate("segment", x=20, xend=20, y=1.5, yend=1.8, size=1)+
  annotate("text", x=30, y=1.42, label="10 sec")+
  annotate("text", x=37, y=1.65, label="0.2 ΔF/F0")+
  ylim(0.3,2.8)+
  theme_void()
p1

ggsave("WTvsNOS11_WTcPRC.png", plot = p1, path = "pictures", dpi = 400, bg = "white")


p2 <- ggplot(NOS11_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS11_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.3,2.8)+
  theme_void()
p2

ggsave("WTvsNOS11_NOS11cPRC.png", plot = p2, path = "pictures", dpi = 400, bg = "white")







WT_INNOS <- WTvsNOS11_cPRC_INNOS %>% select(frame, starts_with("WT_INNOS"))

WT_INNOS_tidy <- WT_INNOS %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")

#Check all data   
ggplot(WT_INNOS_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 



#tapply
WT_INNOS_tidy_mean <- data.frame(frame = WT_INNOS$frame, 
                                   number = tapply(WT_INNOS_tidy$intensity, WT_INNOS_tidy$frame, length), 
                                   mean = tapply(WT_INNOS_tidy$intensity, WT_INNOS_tidy$frame, mean))
#sd
WT_INNOS_tidy_mean$sd <- tapply(WT_INNOS_tidy$intensity, WT_INNOS_tidy$frame, sd)
#se
WT_INNOS_tidy_mean$se <- WT_INNOS_tidy_mean$sd/sqrt(WT_INNOS_tidy_mean$n-1)

#95% confidence interval
WT_INNOS_tidy_mean$CI_lower <- 
  WT_INNOS_tidy_mean$mean + qt((1-0.95)/2, df=WT_INNOS_tidy_mean$n-1) * WT_INNOS_tidy_mean$se

WT_INNOS_tidy_mean$CI_upper <- 
  WT_INNOS_tidy_mean$mean - qt((1-0.95)/2, df=WT_INNOS_tidy_mean$n-1) * WT_INNOS_tidy_mean$se


head(WT_INNOS_tidy_mean)


#graph
p3 <- ggplot(WT_INNOS_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_INNOS_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "deepskyblue3") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="deepskyblue3", alpha=0.3)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=20, xend=40, y=1.5, yend=1.5, size=1)+
  annotate("segment", x=20, xend=20, y=1.5, yend=1.8, size=1)+
  annotate("text", x=30, y=1.44, label="10 sec")+
  annotate("text", x=31, y=1.65, label="0.2 ΔF/F0")+
  ylim(0.5,3.2)+
  theme_void()
p3

ggsave("WTvsNOS11_WTINNOS.png", plot = p3, path = "pictures", dpi = 400, bg = "white")



NOS11_INNOS <- WTvsNOS11_cPRC_INNOS %>% select(frame, starts_with("NOS11_INNOS"))

NOS11_INNOS_tidy <- NOS11_INNOS %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")

#Check all data   
ggplot(NOS11_INNOS_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 



#tapply
NOS11_INNOS_tidy_mean <- data.frame(frame = NOS11_INNOS$frame, 
                                 number = tapply(NOS11_INNOS_tidy$intensity, NOS11_INNOS_tidy$frame, length), 
                                 mean = tapply(NOS11_INNOS_tidy$intensity, NOS11_INNOS_tidy$frame, mean))
#sd
NOS11_INNOS_tidy_mean$sd <- tapply(NOS11_INNOS_tidy$intensity, NOS11_INNOS_tidy$frame, sd)
#se
NOS11_INNOS_tidy_mean$se <- NOS11_INNOS_tidy_mean$sd/sqrt(NOS11_INNOS_tidy_mean$n-1)

#95% confidence interval
NOS11_INNOS_tidy_mean$CI_lower <- 
  NOS11_INNOS_tidy_mean$mean + qt((1-0.95)/2, df=NOS11_INNOS_tidy_mean$n-1) * NOS11_INNOS_tidy_mean$se

NOS11_INNOS_tidy_mean$CI_upper <- 
  NOS11_INNOS_tidy_mean$mean - qt((1-0.95)/2, df=NOS11_INNOS_tidy_mean$n-1) * NOS11_INNOS_tidy_mean$se


head(NOS11_INNOS_tidy_mean)


#graph
p4 <- ggplot(NOS11_INNOS_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS11_INNOS_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "deepskyblue3") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="deepskyblue3", alpha=0.3)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.5,3.2)+
  theme_void()
p4

ggsave("WTvsNOS11_NOS11INNOS.png", plot = p4, path = "pictures", dpi = 400, bg = "white")








