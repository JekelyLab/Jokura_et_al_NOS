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


WTvsNOS23 <- read_csv("data/211121_WTvsNOS23_cPRC.csv")




#Selection
WT_cPRC <- WTvsNOS23 %>% select(frame, starts_with("WT_cPRC"))

#Transformation
WT_cPRC_tidy <- WT_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

#Check all data  
ggplot(WT_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
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


#graph
WT_graph <- ggplot(WT_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="gray") +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.15)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=20, xend=40, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=20, xend=20, y=1.3, yend=1.4, size=1)+
  annotate("text", x=30, y=1.275, label="10 sec")+
  annotate("text", x=31, y=1.36, label="0.2 ΔF/F0")+
  ylim(0.2,1.6)+
  theme_void()
WT_graph



















#Selection
NOS23_cPRC <- WTvsNOS23 %>% select(frame, starts_with("NOS23_cPRC"))

#Transformation
NOS23_cPRC_tidy <- NOS23_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

#Check all data  
ggplot(NOS23_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
NOS23_cPRC_tidy_mean <- data.frame(frame = NOS23_cPRC$frame, 
                                number = tapply(NOS23_cPRC_tidy$intensity, NOS23_cPRC_tidy$frame, length), 
                                mean = tapply(NOS23_cPRC_tidy$intensity, NOS23_cPRC_tidy$frame, mean))

#sd
NOS23_cPRC_tidy_mean$sd <- tapply(NOS23_cPRC_tidy$intensity, NOS23_cPRC_tidy$frame, sd)
#se
NOS23_cPRC_tidy_mean$se <- NOS23_cPRC_tidy_mean$sd/sqrt(NOS23_cPRC_tidy_mean$n-1)

#95% confidence interval
NOS23_cPRC_tidy_mean$CI_lower <- 
  NOS23_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=NOS23_cPRC_tidy_mean$n-1) * NOS23_cPRC_tidy_mean$se
NOS23_cPRC_tidy_mean$CI_upper <- 
  NOS23_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=NOS23_cPRC_tidy_mean$n-1) * NOS23_cPRC_tidy_mean$se


#graph
NOS23_graph <- ggplot(NOS23_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS23_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="gray") +
  geom_line(size = 1.1, color = "black") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.15)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.2,1.6)+
  theme_void()
NOS23_graph



#Save
ggsave("WTvsNOS23_WT_cPRC.png", plot = WT_graph, path = "pictures", dpi = 400, bg = "white")
ggsave("WTvsNOS23_NOS23_cPRC.png", plot = NOS23_graph, path = "pictures", dpi = 400, bg = "white")








