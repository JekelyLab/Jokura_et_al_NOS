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


WTvsNOS23_cPRC_INRGWa <- read_csv("data/211209_WTvsNOS23_cPRC_INRGWa.csv")

#in English
WT_cPRC <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("WT_cPRC"))

#変換
WT_cPRC_tidy <- WT_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#すべてのデータを確認してみる  
ggplot(WT_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
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

#抽出
NOS23_cPRC <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("NOS23_cPRC"))

#変換
NOS23_cPRC_tidy <- NOS23_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#すべてのデータを確認してみる  
ggplot(NOS23_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
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






#抽出
WT_INRGWa <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("WT_INRGWa"))

#変換
WT_INRGWa_tidy <- WT_INRGWa %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#すべてのデータを確認してみる  
ggplot(WT_INRGWa_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
WT_INRGWa_tidy_mean <- data.frame(frame = WT_INRGWa$frame, 
                                   number = tapply(WT_INRGWa_tidy$intensity, WT_INRGWa_tidy$frame, length), 
                                   mean = tapply(WT_INRGWa_tidy$intensity, WT_INRGWa_tidy$frame, mean))

#sd
WT_INRGWa_tidy_mean$sd <- tapply(WT_INRGWa_tidy$intensity, WT_INRGWa_tidy$frame, sd)
#se
WT_INRGWa_tidy_mean$se <- WT_INRGWa_tidy_mean$sd/sqrt(WT_INRGWa_tidy_mean$n-1)

#95% confidence interval
WT_INRGWa_tidy_mean$CI_lower <- 
  WT_INRGWa_tidy_mean$mean + qt((1-0.95)/2, df=WT_INRGWa_tidy_mean$n-1) * WT_INRGWa_tidy_mean$se
WT_INRGWa_tidy_mean$CI_upper <- 
  WT_INRGWa_tidy_mean$mean - qt((1-0.95)/2, df=WT_INRGWa_tidy_mean$n-1) * WT_INRGWa_tidy_mean$se



#抽出
NOS23_INRGWa <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("NOS23_INRGWa"))

#変換
NOS23_INRGWa_tidy <- NOS23_INRGWa %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#すべてのデータを確認してみる  
ggplot(NOS23_INRGWa_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
NOS23_INRGWa_tidy_mean <- data.frame(frame = NOS23_INRGWa$frame, 
                                  number = tapply(NOS23_INRGWa_tidy$intensity, NOS23_INRGWa_tidy$frame, length), 
                                  mean = tapply(NOS23_INRGWa_tidy$intensity, NOS23_INRGWa_tidy$frame, mean))

#sd
NOS23_INRGWa_tidy_mean$sd <- tapply(NOS23_INRGWa_tidy$intensity, NOS23_INRGWa_tidy$frame, sd)
#se
NOS23_INRGWa_tidy_mean$se <- NOS23_INRGWa_tidy_mean$sd/sqrt(NOS23_INRGWa_tidy_mean$n-1)

#95% confidence interval
NOS23_INRGWa_tidy_mean$CI_lower <- 
  NOS23_INRGWa_tidy_mean$mean + qt((1-0.95)/2, df=NOS23_INRGWa_tidy_mean$n-1) * NOS23_INRGWa_tidy_mean$se
NOS23_INRGWa_tidy_mean$CI_upper <- 
  NOS23_INRGWa_tidy_mean$mean - qt((1-0.95)/2, df=NOS23_INRGWa_tidy_mean$n-1) * NOS23_INRGWa_tidy_mean$se






#グラフ
p1 <- ggplot(WT_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=20, xend=40, y=1.5, yend=1.5, size=1)+
  annotate("segment", x=20, xend=20, y=1.5, yend=1.65, size=1)+
  annotate("text", x=30, y=1.45, label="10 sec")+
  annotate("text", x=37, y=1.58, label="0.2 ΔF/F0")+
  ylim(0.4,1.7)+
  theme_void()
p1

p2 <- ggplot(NOS23_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS23_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="green", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.4,1.7)+
  theme_void()
p1 / p2

p3 <- ggplot(WT_INRGWa_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_INRGWa_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=20, xend=40, y=1.5, yend=1.5, size=1)+
  annotate("segment", x=20, xend=20, y=1.5, yend=1.65, size=1)+
  annotate("text", x=30, y=1.46, label="10 sec")+
  annotate("text", x=37, y=1.58, label="0.2 ΔF/F0")+
  ylim(0.7,1.7)+
  theme_void()
p3

p4 <- ggplot(NOS23_INRGWa_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS23_INRGWa_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="green", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.7,1.7)+
  theme_void()

(p1 + p2) / (p3 + p4) +
  plot_annotation(tag_levels = "A")




