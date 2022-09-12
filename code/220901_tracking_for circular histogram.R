rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# load some packages
library(tidyverse)
library(cowplot)
library(png)
library(patchwork)
library(magick)
library(ggplot2)
library(esquisse)
library(REdaS)
library(readr)

df_suvb5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_b5.csv")
df_suv5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_5.csv")
df_suv10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_10.csv")
df_suv15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_15.csv")
df_suv20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_20.csv")
df_suv25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_25.csv")
df_suv30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_30.csv")
df_suv35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_35.csv")
df_suv40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_40.csv")
df_suv45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_45.csv")
df_suv50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_50.csv")
df_suv55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_55.csv")
df_suv60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_60.csv")



df_suvb5_first <- df_suvb5 %>% filter(nor_x > 0, nor_y > 0)
df_suvb5_second <- df_suvb5 %>% filter(nor_x < 0, nor_y > 0)
df_suvb5_third <- df_suvb5 %>% filter(nor_x < 0, nor_y < 0)
df_suvb5_forth <- df_suvb5 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suvb5_first$nor_y/df_suvb5_first$nor_x))
df_suvb5_first <- cbind(df_suvb5_first, degree)

degree <- rad2deg(atan(df_suvb5_second$nor_y/df_suvb5_second$nor_x))
df_suvb5_second <- cbind(df_suvb5_second, degree)
df_suvb5_second$degree <- df_suvb5_second$degree + 180

degree <- rad2deg(atan(df_suvb5_third$nor_y/df_suvb5_third$nor_x))
df_suvb5_third <- cbind(df_suvb5_third, degree)
df_suvb5_third$degree <- df_suvb5_third$degree - 180

degree <- rad2deg(atan(df_suvb5_forth$nor_y/df_suvb5_forth$nor_x))
df_suvb5_forth <- cbind(df_suvb5_forth, degree)

df_suvb5 <- rbind(df_suvb5_first,df_suvb5_second,df_suvb5_third,df_suvb5_forth)

WT_histo_suvb5 <- ggplot(df_suvb5) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()




df_suv5_first <- df_suv5 %>% filter(nor_x > 0, nor_y > 0)
df_suv5_second <- df_suv5 %>% filter(nor_x < 0, nor_y > 0)
df_suv5_third <- df_suv5 %>% filter(nor_x < 0, nor_y < 0)
df_suv5_forth <- df_suv5 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv5_first$nor_y/df_suv5_first$nor_x))
df_suv5_first <- cbind(df_suv5_first, degree)

degree <- rad2deg(atan(df_suv5_second$nor_y/df_suv5_second$nor_x))
df_suv5_second <- cbind(df_suv5_second, degree)
df_suv5_second$degree <- df_suv5_second$degree + 180

degree <- rad2deg(atan(df_suv5_third$nor_y/df_suv5_third$nor_x))
df_suv5_third <- cbind(df_suv5_third, degree)
df_suv5_third$degree <- df_suv5_third$degree - 180

degree <- rad2deg(atan(df_suv5_forth$nor_y/df_suv5_forth$nor_x))
df_suv5_forth <- cbind(df_suv5_forth, degree)

df_suv5 <- rbind(df_suv5_first,df_suv5_second,df_suv5_third,df_suv5_forth)

WT_histo_suv5 <- ggplot(df_suv5) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()




df_suv10_first <- df_suv10 %>% filter(nor_x > 0, nor_y > 0)
df_suv10_second <- df_suv10 %>% filter(nor_x < 0, nor_y > 0)
df_suv10_third <- df_suv10 %>% filter(nor_x < 0, nor_y < 0)
df_suv10_forth <- df_suv10 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv10_first$nor_y/df_suv10_first$nor_x))
df_suv10_first <- cbind(df_suv10_first, degree)

degree <- rad2deg(atan(df_suv10_second$nor_y/df_suv10_second$nor_x))
df_suv10_second <- cbind(df_suv10_second, degree)
df_suv10_second$degree <- df_suv10_second$degree + 180

degree <- rad2deg(atan(df_suv10_third$nor_y/df_suv10_third$nor_x))
df_suv10_third <- cbind(df_suv10_third, degree)
df_suv10_third$degree <- df_suv10_third$degree - 180

degree <- rad2deg(atan(df_suv10_forth$nor_y/df_suv10_forth$nor_x))
df_suv10_forth <- cbind(df_suv10_forth, degree)

df_suv10 <- rbind(df_suv10_first,df_suv10_second,df_suv10_third,df_suv10_forth)

WT_histo_suv10 <- ggplot(df_suv10) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()



df_suv15_first <- df_suv15 %>% filter(nor_x > 0, nor_y > 0)
df_suv15_second <- df_suv15 %>% filter(nor_x < 0, nor_y > 0)
df_suv15_third <- df_suv15 %>% filter(nor_x < 0, nor_y < 0)
df_suv15_forth <- df_suv15 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv15_first$nor_y/df_suv15_first$nor_x))
df_suv15_first <- cbind(df_suv15_first, degree)

degree <- rad2deg(atan(df_suv15_second$nor_y/df_suv15_second$nor_x))
df_suv15_second <- cbind(df_suv15_second, degree)
df_suv15_second$degree <- df_suv15_second$degree + 180

degree <- rad2deg(atan(df_suv15_third$nor_y/df_suv15_third$nor_x))
df_suv15_third <- cbind(df_suv15_third, degree)
df_suv15_third$degree <- df_suv15_third$degree - 180

degree <- rad2deg(atan(df_suv15_forth$nor_y/df_suv15_forth$nor_x))
df_suv15_forth <- cbind(df_suv15_forth, degree)

df_suv15 <- rbind(df_suv15_first,df_suv15_second,df_suv15_third,df_suv15_forth)

WT_histo_suv15 <- ggplot(df_suv15) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()





df_suv20_first <- df_suv20 %>% filter(nor_x > 0, nor_y > 0)
df_suv20_second <- df_suv20 %>% filter(nor_x < 0, nor_y > 0)
df_suv20_third <- df_suv20 %>% filter(nor_x < 0, nor_y < 0)
df_suv20_forth <- df_suv20 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv20_first$nor_y/df_suv20_first$nor_x))
df_suv20_first <- cbind(df_suv20_first, degree)

degree <- rad2deg(atan(df_suv20_second$nor_y/df_suv20_second$nor_x))
df_suv20_second <- cbind(df_suv20_second, degree)
df_suv20_second$degree <- df_suv20_second$degree + 180

degree <- rad2deg(atan(df_suv20_third$nor_y/df_suv20_third$nor_x))
df_suv20_third <- cbind(df_suv20_third, degree)
df_suv20_third$degree <- df_suv20_third$degree - 180

degree <- rad2deg(atan(df_suv20_forth$nor_y/df_suv20_forth$nor_x))
df_suv20_forth <- cbind(df_suv20_forth, degree)

df_suv20 <- rbind(df_suv20_first,df_suv20_second,df_suv20_third,df_suv20_forth)

WT_histo_suv20 <- ggplot(df_suv20) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()





df_suv25_first <- df_suv25 %>% filter(nor_x > 0, nor_y > 0)
df_suv25_second <- df_suv25 %>% filter(nor_x < 0, nor_y > 0)
df_suv25_third <- df_suv25 %>% filter(nor_x < 0, nor_y < 0)
df_suv25_forth <- df_suv25 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv25_first$nor_y/df_suv25_first$nor_x))
df_suv25_first <- cbind(df_suv25_first, degree)

degree <- rad2deg(atan(df_suv25_second$nor_y/df_suv25_second$nor_x))
df_suv25_second <- cbind(df_suv25_second, degree)
df_suv25_second$degree <- df_suv25_second$degree + 180

degree <- rad2deg(atan(df_suv25_third$nor_y/df_suv25_third$nor_x))
df_suv25_third <- cbind(df_suv25_third, degree)
df_suv25_third$degree <- df_suv25_third$degree - 180

degree <- rad2deg(atan(df_suv25_forth$nor_y/df_suv25_forth$nor_x))
df_suv25_forth <- cbind(df_suv25_forth, degree)

df_suv25 <- rbind(df_suv25_first,df_suv25_second,df_suv25_third,df_suv25_forth)

WT_histo_suv25 <- ggplot(df_suv25) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()






df_suv30_first <- df_suv30 %>% filter(nor_x > 0, nor_y > 0)
df_suv30_second <- df_suv30 %>% filter(nor_x < 0, nor_y > 0)
df_suv30_third <- df_suv30 %>% filter(nor_x < 0, nor_y < 0)
df_suv30_forth <- df_suv30 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv30_first$nor_y/df_suv30_first$nor_x))
df_suv30_first <- cbind(df_suv30_first, degree)

degree <- rad2deg(atan(df_suv30_second$nor_y/df_suv30_second$nor_x))
df_suv30_second <- cbind(df_suv30_second, degree)
df_suv30_second$degree <- df_suv30_second$degree + 180

degree <- rad2deg(atan(df_suv30_third$nor_y/df_suv30_third$nor_x))
df_suv30_third <- cbind(df_suv30_third, degree)
df_suv30_third$degree <- df_suv30_third$degree - 180

degree <- rad2deg(atan(df_suv30_forth$nor_y/df_suv30_forth$nor_x))
df_suv30_forth <- cbind(df_suv30_forth, degree)

df_suv30 <- rbind(df_suv30_first,df_suv30_second,df_suv30_third,df_suv30_forth)

WT_histo_suv30 <- ggplot(df_suv30) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()










df_suv35_first <- df_suv35 %>% filter(nor_x > 0, nor_y > 0)
df_suv35_second <- df_suv35 %>% filter(nor_x < 0, nor_y > 0)
df_suv35_third <- df_suv35 %>% filter(nor_x < 0, nor_y < 0)
df_suv35_forth <- df_suv35 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv35_first$nor_y/df_suv35_first$nor_x))
df_suv35_first <- cbind(df_suv35_first, degree)

degree <- rad2deg(atan(df_suv35_second$nor_y/df_suv35_second$nor_x))
df_suv35_second <- cbind(df_suv35_second, degree)
df_suv35_second$degree <- df_suv35_second$degree + 180

degree <- rad2deg(atan(df_suv35_third$nor_y/df_suv35_third$nor_x))
df_suv35_third <- cbind(df_suv35_third, degree)
df_suv35_third$degree <- df_suv35_third$degree - 180

degree <- rad2deg(atan(df_suv35_forth$nor_y/df_suv35_forth$nor_x))
df_suv35_forth <- cbind(df_suv35_forth, degree)

df_suv35 <- rbind(df_suv35_first,df_suv35_second,df_suv35_third,df_suv35_forth)

WT_histo_suv35 <- ggplot(df_suv35) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()








df_suv40_first <- df_suv40 %>% filter(nor_x > 0, nor_y > 0)
df_suv40_second <- df_suv40 %>% filter(nor_x < 0, nor_y > 0)
df_suv40_third <- df_suv40 %>% filter(nor_x < 0, nor_y < 0)
df_suv40_forth <- df_suv40 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv40_first$nor_y/df_suv40_first$nor_x))
df_suv40_first <- cbind(df_suv40_first, degree)

degree <- rad2deg(atan(df_suv40_second$nor_y/df_suv40_second$nor_x))
df_suv40_second <- cbind(df_suv40_second, degree)
df_suv40_second$degree <- df_suv40_second$degree + 180

degree <- rad2deg(atan(df_suv40_third$nor_y/df_suv40_third$nor_x))
df_suv40_third <- cbind(df_suv40_third, degree)
df_suv40_third$degree <- df_suv40_third$degree - 180

degree <- rad2deg(atan(df_suv40_forth$nor_y/df_suv40_forth$nor_x))
df_suv40_forth <- cbind(df_suv40_forth, degree)

df_suv40 <- rbind(df_suv40_first,df_suv40_second,df_suv40_third,df_suv40_forth)

WT_histo_suv40 <- ggplot(df_suv40) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()






df_suv45_first <- df_suv45 %>% filter(nor_x > 0, nor_y > 0)
df_suv45_second <- df_suv45 %>% filter(nor_x < 0, nor_y > 0)
df_suv45_third <- df_suv45 %>% filter(nor_x < 0, nor_y < 0)
df_suv45_forth <- df_suv45 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv45_first$nor_y/df_suv45_first$nor_x))
df_suv45_first <- cbind(df_suv45_first, degree)

degree <- rad2deg(atan(df_suv45_second$nor_y/df_suv45_second$nor_x))
df_suv45_second <- cbind(df_suv45_second, degree)
df_suv45_second$degree <- df_suv45_second$degree + 180

degree <- rad2deg(atan(df_suv45_third$nor_y/df_suv45_third$nor_x))
df_suv45_third <- cbind(df_suv45_third, degree)
df_suv45_third$degree <- df_suv45_third$degree - 180

degree <- rad2deg(atan(df_suv45_forth$nor_y/df_suv45_forth$nor_x))
df_suv45_forth <- cbind(df_suv45_forth, degree)

df_suv45 <- rbind(df_suv45_first,df_suv45_second,df_suv45_third,df_suv45_forth)

WT_histo_suv45 <- ggplot(df_suv45) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()








df_suv50_first <- df_suv50 %>% filter(nor_x > 0, nor_y > 0)
df_suv50_second <- df_suv50 %>% filter(nor_x < 0, nor_y > 0)
df_suv50_third <- df_suv50 %>% filter(nor_x < 0, nor_y < 0)
df_suv50_forth <- df_suv50 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv50_first$nor_y/df_suv50_first$nor_x))
df_suv50_first <- cbind(df_suv50_first, degree)

degree <- rad2deg(atan(df_suv50_second$nor_y/df_suv50_second$nor_x))
df_suv50_second <- cbind(df_suv50_second, degree)
df_suv50_second$degree <- df_suv50_second$degree + 180

degree <- rad2deg(atan(df_suv50_third$nor_y/df_suv50_third$nor_x))
df_suv50_third <- cbind(df_suv50_third, degree)
df_suv50_third$degree <- df_suv50_third$degree - 180

degree <- rad2deg(atan(df_suv50_forth$nor_y/df_suv50_forth$nor_x))
df_suv50_forth <- cbind(df_suv50_forth, degree)

df_suv50 <- rbind(df_suv50_first,df_suv50_second,df_suv50_third,df_suv50_forth)

WT_histo_suv50 <- ggplot(df_suv50) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()









df_suv55_first <- df_suv55 %>% filter(nor_x > 0, nor_y > 0)
df_suv55_second <- df_suv55 %>% filter(nor_x < 0, nor_y > 0)
df_suv55_third <- df_suv55 %>% filter(nor_x < 0, nor_y < 0)
df_suv55_forth <- df_suv55 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv55_first$nor_y/df_suv55_first$nor_x))
df_suv55_first <- cbind(df_suv55_first, degree)

degree <- rad2deg(atan(df_suv55_second$nor_y/df_suv55_second$nor_x))
df_suv55_second <- cbind(df_suv55_second, degree)
df_suv55_second$degree <- df_suv55_second$degree + 180

degree <- rad2deg(atan(df_suv55_third$nor_y/df_suv55_third$nor_x))
df_suv55_third <- cbind(df_suv55_third, degree)
df_suv55_third$degree <- df_suv55_third$degree - 180

degree <- rad2deg(atan(df_suv55_forth$nor_y/df_suv55_forth$nor_x))
df_suv55_forth <- cbind(df_suv55_forth, degree)

df_suv55 <- rbind(df_suv55_first,df_suv55_second,df_suv55_third,df_suv55_forth)

WT_histo_suv55 <- ggplot(df_suv55) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()








df_suv60_first <- df_suv60 %>% filter(nor_x > 0, nor_y > 0)
df_suv60_second <- df_suv60 %>% filter(nor_x < 0, nor_y > 0)
df_suv60_third <- df_suv60 %>% filter(nor_x < 0, nor_y < 0)
df_suv60_forth <- df_suv60 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv60_first$nor_y/df_suv60_first$nor_x))
df_suv60_first <- cbind(df_suv60_first, degree)

degree <- rad2deg(atan(df_suv60_second$nor_y/df_suv60_second$nor_x))
df_suv60_second <- cbind(df_suv60_second, degree)
df_suv60_second$degree <- df_suv60_second$degree + 180

degree <- rad2deg(atan(df_suv60_third$nor_y/df_suv60_third$nor_x))
df_suv60_third <- cbind(df_suv60_third, degree)
df_suv60_third$degree <- df_suv60_third$degree - 180

degree <- rad2deg(atan(df_suv60_forth$nor_y/df_suv60_forth$nor_x))
df_suv60_forth <- cbind(df_suv60_forth, degree)

df_suv60 <- rbind(df_suv60_first,df_suv60_second,df_suv60_third,df_suv60_forth)

WT_histo_suv60 <- ggplot(df_suv60) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()



df_suvb5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_b5.csv")
df_suv5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_5.csv")
df_suv10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_10.csv")
df_suv15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_15.csv")
df_suv20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_20.csv")
df_suv25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_25.csv")
df_suv30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_30.csv")
df_suv35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_35.csv")
df_suv40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_40.csv")
df_suv45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_45.csv")
df_suv50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_50.csv")
df_suv55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_55.csv")
df_suv60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_60.csv")


df_suvb5_first <- df_suvb5 %>% filter(nor_x > 0, nor_y > 0)
df_suvb5_second <- df_suvb5 %>% filter(nor_x < 0, nor_y > 0)
df_suvb5_third <- df_suvb5 %>% filter(nor_x < 0, nor_y < 0)
df_suvb5_forth <- df_suvb5 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suvb5_first$nor_y/df_suvb5_first$nor_x))
df_suvb5_first <- cbind(df_suvb5_first, degree)

degree <- rad2deg(atan(df_suvb5_second$nor_y/df_suvb5_second$nor_x))
df_suvb5_second <- cbind(df_suvb5_second, degree)
df_suvb5_second$degree <- df_suvb5_second$degree + 180

degree <- rad2deg(atan(df_suvb5_third$nor_y/df_suvb5_third$nor_x))
df_suvb5_third <- cbind(df_suvb5_third, degree)
df_suvb5_third$degree <- df_suvb5_third$degree - 180

degree <- rad2deg(atan(df_suvb5_forth$nor_y/df_suvb5_forth$nor_x))
df_suvb5_forth <- cbind(df_suvb5_forth, degree)

df_suvb5 <- rbind(df_suvb5_first,df_suvb5_second,df_suvb5_third,df_suvb5_forth)

NOS_histo_suvb5 <- ggplot(df_suvb5) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()




df_suv5_first <- df_suv5 %>% filter(nor_x > 0, nor_y > 0)
df_suv5_second <- df_suv5 %>% filter(nor_x < 0, nor_y > 0)
df_suv5_third <- df_suv5 %>% filter(nor_x < 0, nor_y < 0)
df_suv5_forth <- df_suv5 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv5_first$nor_y/df_suv5_first$nor_x))
df_suv5_first <- cbind(df_suv5_first, degree)

degree <- rad2deg(atan(df_suv5_second$nor_y/df_suv5_second$nor_x))
df_suv5_second <- cbind(df_suv5_second, degree)
df_suv5_second$degree <- df_suv5_second$degree + 180

degree <- rad2deg(atan(df_suv5_third$nor_y/df_suv5_third$nor_x))
df_suv5_third <- cbind(df_suv5_third, degree)
df_suv5_third$degree <- df_suv5_third$degree - 180

degree <- rad2deg(atan(df_suv5_forth$nor_y/df_suv5_forth$nor_x))
df_suv5_forth <- cbind(df_suv5_forth, degree)

df_suv5 <- rbind(df_suv5_first,df_suv5_second,df_suv5_third,df_suv5_forth)

NOS_histo_suv5 <- ggplot(df_suv5) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()




df_suv10_first <- df_suv10 %>% filter(nor_x > 0, nor_y > 0)
df_suv10_second <- df_suv10 %>% filter(nor_x < 0, nor_y > 0)
df_suv10_third <- df_suv10 %>% filter(nor_x < 0, nor_y < 0)
df_suv10_forth <- df_suv10 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv10_first$nor_y/df_suv10_first$nor_x))
df_suv10_first <- cbind(df_suv10_first, degree)

degree <- rad2deg(atan(df_suv10_second$nor_y/df_suv10_second$nor_x))
df_suv10_second <- cbind(df_suv10_second, degree)
df_suv10_second$degree <- df_suv10_second$degree + 180

degree <- rad2deg(atan(df_suv10_third$nor_y/df_suv10_third$nor_x))
df_suv10_third <- cbind(df_suv10_third, degree)
df_suv10_third$degree <- df_suv10_third$degree - 180

degree <- rad2deg(atan(df_suv10_forth$nor_y/df_suv10_forth$nor_x))
df_suv10_forth <- cbind(df_suv10_forth, degree)

df_suv10 <- rbind(df_suv10_first,df_suv10_second,df_suv10_third,df_suv10_forth)

NOS_histo_suv10 <- ggplot(df_suv10) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()



df_suv15_first <- df_suv15 %>% filter(nor_x > 0, nor_y > 0)
df_suv15_second <- df_suv15 %>% filter(nor_x < 0, nor_y > 0)
df_suv15_third <- df_suv15 %>% filter(nor_x < 0, nor_y < 0)
df_suv15_forth <- df_suv15 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv15_first$nor_y/df_suv15_first$nor_x))
df_suv15_first <- cbind(df_suv15_first, degree)

degree <- rad2deg(atan(df_suv15_second$nor_y/df_suv15_second$nor_x))
df_suv15_second <- cbind(df_suv15_second, degree)
df_suv15_second$degree <- df_suv15_second$degree + 180

degree <- rad2deg(atan(df_suv15_third$nor_y/df_suv15_third$nor_x))
df_suv15_third <- cbind(df_suv15_third, degree)
df_suv15_third$degree <- df_suv15_third$degree - 180

degree <- rad2deg(atan(df_suv15_forth$nor_y/df_suv15_forth$nor_x))
df_suv15_forth <- cbind(df_suv15_forth, degree)

df_suv15 <- rbind(df_suv15_first,df_suv15_second,df_suv15_third,df_suv15_forth)

NOS_histo_suv15 <- ggplot(df_suv15) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()





df_suv20_first <- df_suv20 %>% filter(nor_x > 0, nor_y > 0)
df_suv20_second <- df_suv20 %>% filter(nor_x < 0, nor_y > 0)
df_suv20_third <- df_suv20 %>% filter(nor_x < 0, nor_y < 0)
df_suv20_forth <- df_suv20 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv20_first$nor_y/df_suv20_first$nor_x))
df_suv20_first <- cbind(df_suv20_first, degree)

degree <- rad2deg(atan(df_suv20_second$nor_y/df_suv20_second$nor_x))
df_suv20_second <- cbind(df_suv20_second, degree)
df_suv20_second$degree <- df_suv20_second$degree + 180

degree <- rad2deg(atan(df_suv20_third$nor_y/df_suv20_third$nor_x))
df_suv20_third <- cbind(df_suv20_third, degree)
df_suv20_third$degree <- df_suv20_third$degree - 180

degree <- rad2deg(atan(df_suv20_forth$nor_y/df_suv20_forth$nor_x))
df_suv20_forth <- cbind(df_suv20_forth, degree)

df_suv20 <- rbind(df_suv20_first,df_suv20_second,df_suv20_third,df_suv20_forth)

NOS_histo_suv20 <- ggplot(df_suv20) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()





df_suv25_first <- df_suv25 %>% filter(nor_x > 0, nor_y > 0)
df_suv25_second <- df_suv25 %>% filter(nor_x < 0, nor_y > 0)
df_suv25_third <- df_suv25 %>% filter(nor_x < 0, nor_y < 0)
df_suv25_forth <- df_suv25 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv25_first$nor_y/df_suv25_first$nor_x))
df_suv25_first <- cbind(df_suv25_first, degree)

degree <- rad2deg(atan(df_suv25_second$nor_y/df_suv25_second$nor_x))
df_suv25_second <- cbind(df_suv25_second, degree)
df_suv25_second$degree <- df_suv25_second$degree + 180

degree <- rad2deg(atan(df_suv25_third$nor_y/df_suv25_third$nor_x))
df_suv25_third <- cbind(df_suv25_third, degree)
df_suv25_third$degree <- df_suv25_third$degree - 180

degree <- rad2deg(atan(df_suv25_forth$nor_y/df_suv25_forth$nor_x))
df_suv25_forth <- cbind(df_suv25_forth, degree)

df_suv25 <- rbind(df_suv25_first,df_suv25_second,df_suv25_third,df_suv25_forth)

NOS_histo_suv25 <- ggplot(df_suv25) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()






df_suv30_first <- df_suv30 %>% filter(nor_x > 0, nor_y > 0)
df_suv30_second <- df_suv30 %>% filter(nor_x < 0, nor_y > 0)
df_suv30_third <- df_suv30 %>% filter(nor_x < 0, nor_y < 0)
df_suv30_forth <- df_suv30 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv30_first$nor_y/df_suv30_first$nor_x))
df_suv30_first <- cbind(df_suv30_first, degree)

degree <- rad2deg(atan(df_suv30_second$nor_y/df_suv30_second$nor_x))
df_suv30_second <- cbind(df_suv30_second, degree)
df_suv30_second$degree <- df_suv30_second$degree + 180

degree <- rad2deg(atan(df_suv30_third$nor_y/df_suv30_third$nor_x))
df_suv30_third <- cbind(df_suv30_third, degree)
df_suv30_third$degree <- df_suv30_third$degree - 180

degree <- rad2deg(atan(df_suv30_forth$nor_y/df_suv30_forth$nor_x))
df_suv30_forth <- cbind(df_suv30_forth, degree)

df_suv30 <- rbind(df_suv30_first,df_suv30_second,df_suv30_third,df_suv30_forth)

NOS_histo_suv30 <- ggplot(df_suv30) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()










df_suv35_first <- df_suv35 %>% filter(nor_x > 0, nor_y > 0)
df_suv35_second <- df_suv35 %>% filter(nor_x < 0, nor_y > 0)
df_suv35_third <- df_suv35 %>% filter(nor_x < 0, nor_y < 0)
df_suv35_forth <- df_suv35 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv35_first$nor_y/df_suv35_first$nor_x))
df_suv35_first <- cbind(df_suv35_first, degree)

degree <- rad2deg(atan(df_suv35_second$nor_y/df_suv35_second$nor_x))
df_suv35_second <- cbind(df_suv35_second, degree)
df_suv35_second$degree <- df_suv35_second$degree + 180

degree <- rad2deg(atan(df_suv35_third$nor_y/df_suv35_third$nor_x))
df_suv35_third <- cbind(df_suv35_third, degree)
df_suv35_third$degree <- df_suv35_third$degree - 180

degree <- rad2deg(atan(df_suv35_forth$nor_y/df_suv35_forth$nor_x))
df_suv35_forth <- cbind(df_suv35_forth, degree)

df_suv35 <- rbind(df_suv35_first,df_suv35_second,df_suv35_third,df_suv35_forth)

NOS_histo_suv35 <- ggplot(df_suv35) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()








df_suv40_first <- df_suv40 %>% filter(nor_x > 0, nor_y > 0)
df_suv40_second <- df_suv40 %>% filter(nor_x < 0, nor_y > 0)
df_suv40_third <- df_suv40 %>% filter(nor_x < 0, nor_y < 0)
df_suv40_forth <- df_suv40 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv40_first$nor_y/df_suv40_first$nor_x))
df_suv40_first <- cbind(df_suv40_first, degree)

degree <- rad2deg(atan(df_suv40_second$nor_y/df_suv40_second$nor_x))
df_suv40_second <- cbind(df_suv40_second, degree)
df_suv40_second$degree <- df_suv40_second$degree + 180

degree <- rad2deg(atan(df_suv40_third$nor_y/df_suv40_third$nor_x))
df_suv40_third <- cbind(df_suv40_third, degree)
df_suv40_third$degree <- df_suv40_third$degree - 180

degree <- rad2deg(atan(df_suv40_forth$nor_y/df_suv40_forth$nor_x))
df_suv40_forth <- cbind(df_suv40_forth, degree)

df_suv40 <- rbind(df_suv40_first,df_suv40_second,df_suv40_third,df_suv40_forth)

NOS_histo_suv40 <- ggplot(df_suv40) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()






df_suv45_first <- df_suv45 %>% filter(nor_x > 0, nor_y > 0)
df_suv45_second <- df_suv45 %>% filter(nor_x < 0, nor_y > 0)
df_suv45_third <- df_suv45 %>% filter(nor_x < 0, nor_y < 0)
df_suv45_forth <- df_suv45 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv45_first$nor_y/df_suv45_first$nor_x))
df_suv45_first <- cbind(df_suv45_first, degree)

degree <- rad2deg(atan(df_suv45_second$nor_y/df_suv45_second$nor_x))
df_suv45_second <- cbind(df_suv45_second, degree)
df_suv45_second$degree <- df_suv45_second$degree + 180

degree <- rad2deg(atan(df_suv45_third$nor_y/df_suv45_third$nor_x))
df_suv45_third <- cbind(df_suv45_third, degree)
df_suv45_third$degree <- df_suv45_third$degree - 180

degree <- rad2deg(atan(df_suv45_forth$nor_y/df_suv45_forth$nor_x))
df_suv45_forth <- cbind(df_suv45_forth, degree)

df_suv45 <- rbind(df_suv45_first,df_suv45_second,df_suv45_third,df_suv45_forth)

NOS_histo_suv45 <- ggplot(df_suv45) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()








df_suv50_first <- df_suv50 %>% filter(nor_x > 0, nor_y > 0)
df_suv50_second <- df_suv50 %>% filter(nor_x < 0, nor_y > 0)
df_suv50_third <- df_suv50 %>% filter(nor_x < 0, nor_y < 0)
df_suv50_forth <- df_suv50 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv50_first$nor_y/df_suv50_first$nor_x))
df_suv50_first <- cbind(df_suv50_first, degree)

degree <- rad2deg(atan(df_suv50_second$nor_y/df_suv50_second$nor_x))
df_suv50_second <- cbind(df_suv50_second, degree)
df_suv50_second$degree <- df_suv50_second$degree + 180

degree <- rad2deg(atan(df_suv50_third$nor_y/df_suv50_third$nor_x))
df_suv50_third <- cbind(df_suv50_third, degree)
df_suv50_third$degree <- df_suv50_third$degree - 180

degree <- rad2deg(atan(df_suv50_forth$nor_y/df_suv50_forth$nor_x))
df_suv50_forth <- cbind(df_suv50_forth, degree)

df_suv50 <- rbind(df_suv50_first,df_suv50_second,df_suv50_third,df_suv50_forth)

NOS_histo_suv50 <- ggplot(df_suv50) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()









df_suv55_first <- df_suv55 %>% filter(nor_x > 0, nor_y > 0)
df_suv55_second <- df_suv55 %>% filter(nor_x < 0, nor_y > 0)
df_suv55_third <- df_suv55 %>% filter(nor_x < 0, nor_y < 0)
df_suv55_forth <- df_suv55 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv55_first$nor_y/df_suv55_first$nor_x))
df_suv55_first <- cbind(df_suv55_first, degree)

degree <- rad2deg(atan(df_suv55_second$nor_y/df_suv55_second$nor_x))
df_suv55_second <- cbind(df_suv55_second, degree)
df_suv55_second$degree <- df_suv55_second$degree + 180

degree <- rad2deg(atan(df_suv55_third$nor_y/df_suv55_third$nor_x))
df_suv55_third <- cbind(df_suv55_third, degree)
df_suv55_third$degree <- df_suv55_third$degree - 180

degree <- rad2deg(atan(df_suv55_forth$nor_y/df_suv55_forth$nor_x))
df_suv55_forth <- cbind(df_suv55_forth, degree)

df_suv55 <- rbind(df_suv55_first,df_suv55_second,df_suv55_third,df_suv55_forth)

NOS_histo_suv55 <- ggplot(df_suv55) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()








df_suv60_first <- df_suv60 %>% filter(nor_x > 0, nor_y > 0)
df_suv60_second <- df_suv60 %>% filter(nor_x < 0, nor_y > 0)
df_suv60_third <- df_suv60 %>% filter(nor_x < 0, nor_y < 0)
df_suv60_forth <- df_suv60 %>% filter(nor_x > 0, nor_y < 0)


degree <- rad2deg(atan(df_suv60_first$nor_y/df_suv60_first$nor_x))
df_suv60_first <- cbind(df_suv60_first, degree)

degree <- rad2deg(atan(df_suv60_second$nor_y/df_suv60_second$nor_x))
df_suv60_second <- cbind(df_suv60_second, degree)
df_suv60_second$degree <- df_suv60_second$degree + 180

degree <- rad2deg(atan(df_suv60_third$nor_y/df_suv60_third$nor_x))
df_suv60_third <- cbind(df_suv60_third, degree)
df_suv60_third$degree <- df_suv60_third$degree - 180

degree <- rad2deg(atan(df_suv60_forth$nor_y/df_suv60_forth$nor_x))
df_suv60_forth <- cbind(df_suv60_forth, degree)

df_suv60 <- rbind(df_suv60_first,df_suv60_second,df_suv60_third,df_suv60_forth)

NOS_histo_suv60 <- ggplot(df_suv60) + 
  geom_histogram(aes(x=degree), binwidth=8) +
  scale_x_continuous(breaks=seq(-180,180,10), limits=c(-180,180)) +
  coord_polar(theta="x", start=pi/2, direction=-1) + 
  theme_bw()



WT_histo_suvb5|NOS_histo_suvb5
WT_histo_suv5|NOS_histo_suv5
WT_histo_suv10|NOS_histo_suv10
WT_histo_suv15|NOS_histo_suv15
WT_histo_suv20|NOS_histo_suv20
WT_histo_suv25|NOS_histo_suv25
WT_histo_suv30|NOS_histo_suv30
WT_histo_suv35|NOS_histo_suv35
WT_histo_suv40|NOS_histo_suv40
WT_histo_suv45|NOS_histo_suv45
WT_histo_suv50|NOS_histo_suv50
WT_histo_suv55|NOS_histo_suv55
WT_histo_suv60|NOS_histo_suv60





