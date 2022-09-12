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
library(readr)

tf_suv_WT_0701_08_b5 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_before_1-5_t.csv", 
                                 col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_5 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_1-5_t.csv", 
                                 col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_10 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_6-10_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_15 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_11-15_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_20 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_16-20_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_25 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_21-25_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_30 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_26-30_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_35 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_31-35_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_40 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_36-40_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_45 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_41-45_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_50 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_46-50_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_55 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_51-55_t.csv", 
                                col_names = FALSE, skip = 4)
tf_suv_WT_0701_08_60 <- read_csv("~/Martin behaviour/WT/WT_0701_08/tracking parameters/WT_0701_08_sUV_56-60_t.csv", 
                                col_names = FALSE, skip = 4)

tf_suv_mean <- data.frame(genotype = 'WT', batch = '0701_08', duration = 'before',
                          Mn_sp=mean(tf_suv_WT_0701_08_b5$X17),
                          Total_dist=mean(tf_suv_WT_0701_08_b5$X23),
                          Cfn_ratio=mean(tf_suv_WT_0701_08_b5$X25),
                          Mn_straight_sp=mean(tf_suv_WT_0701_08_b5$X26),
                          Line_fwd_prog=mean(tf_suv_WT_0701_08_b5$X27),
                          Mn_directional_change_rate=mean(tf_suv_WT_0701_08_b5$X28))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '5s',
                                Mn_sp=mean(tf_suv_WT_0701_08_5$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_5$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_5$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_5$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_5$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '10s',
                                Mn_sp=mean(tf_suv_WT_0701_08_10$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_10$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_10$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_10$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_10$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '15s',
                                Mn_sp=mean(tf_suv_WT_0701_08_15$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_15$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_15$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_15$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_15$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '20s',
                                Mn_sp=mean(tf_suv_WT_0701_08_20$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_20$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_20$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_20$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_20$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '25s',
                                Mn_sp=mean(tf_suv_WT_0701_08_25$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_25$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_25$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_25$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_25$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '30s',
                                Mn_sp=mean(tf_suv_WT_0701_08_30$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_30$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_30$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_30$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_30$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '35s',
                                Mn_sp=mean(tf_suv_WT_0701_08_35$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_35$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_35$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_35$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_35$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '40s',
                                Mn_sp=mean(tf_suv_WT_0701_08_40$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_40$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_40$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_40$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_40$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '45s',
                                Mn_sp=mean(tf_suv_WT_0701_08_45$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_45$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_45$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_45$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_45$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '50s',
                                Mn_sp=mean(tf_suv_WT_0701_08_50$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_50$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_50$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_50$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_50$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '55s',
                                Mn_sp=mean(tf_suv_WT_0701_08_55$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_55$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_55$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_55$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_55$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, 
                     data.frame(genotype = 'WT', batch = '0701_08', duration = '60s',
                                Mn_sp=mean(tf_suv_WT_0701_08_60$X17),
                                Total_dist=mean(tf_suv_WT_0701_08_60$X23),
                                Cfn_ratio=mean(tf_suv_WT_0701_08_60$X25),
                                Mn_straight_sp=mean(tf_suv_WT_0701_08_60$X26),
                                Line_fwd_prog=mean(tf_suv_WT_0701_08_60$X27),
                                Mn_directional_change_rate=mean(tf_suv_WT_0701_08_60$X28)))

rm(tf_suv_WT_0701_08_b5)
rm(tf_suv_WT_0701_08_5)
rm(tf_suv_WT_0701_08_10)
rm(tf_suv_WT_0701_08_15)
rm(tf_suv_WT_0701_08_20)
rm(tf_suv_WT_0701_08_25)
rm(tf_suv_WT_0701_08_30)
rm(tf_suv_WT_0701_08_35)
rm(tf_suv_WT_0701_08_40)
rm(tf_suv_WT_0701_08_45)
rm(tf_suv_WT_0701_08_50)
rm(tf_suv_WT_0701_08_55)
rm(tf_suv_WT_0701_08_60)










tf_suv_WT_0701_09_b5 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_5 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_10 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_15 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_20 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_25 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_30 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_35 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_40 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_45 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_50 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_55 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0701_09_60 <- read_csv("~/Martin behaviour/WT/WT_0701_09/tracking parameters/WT_0701_09_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = 'before',Mn_sp=mean(tf_suv_WT_0701_09_b5$X17),Total_dist=mean(tf_suv_WT_0701_09_b5$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '5s',Mn_sp=mean(tf_suv_WT_0701_09_5$X17),Total_dist=mean(tf_suv_WT_0701_09_5$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_5$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_5$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '10s',Mn_sp=mean(tf_suv_WT_0701_09_10$X17),Total_dist=mean(tf_suv_WT_0701_09_10$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_10$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_10$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '15s',Mn_sp=mean(tf_suv_WT_0701_09_15$X17),Total_dist=mean(tf_suv_WT_0701_09_15$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_15$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_15$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '20s',Mn_sp=mean(tf_suv_WT_0701_09_20$X17),Total_dist=mean(tf_suv_WT_0701_09_20$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_20$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_20$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '25s',Mn_sp=mean(tf_suv_WT_0701_09_25$X17),Total_dist=mean(tf_suv_WT_0701_09_25$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_25$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_25$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '30s',Mn_sp=mean(tf_suv_WT_0701_09_30$X17),Total_dist=mean(tf_suv_WT_0701_09_30$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_30$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_30$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '35s',Mn_sp=mean(tf_suv_WT_0701_09_35$X17),Total_dist=mean(tf_suv_WT_0701_09_35$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_35$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_35$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '40s',Mn_sp=mean(tf_suv_WT_0701_09_40$X17),Total_dist=mean(tf_suv_WT_0701_09_40$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_40$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_40$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '45s',Mn_sp=mean(tf_suv_WT_0701_09_45$X17),Total_dist=mean(tf_suv_WT_0701_09_45$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_45$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_45$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '50s',Mn_sp=mean(tf_suv_WT_0701_09_50$X17),Total_dist=mean(tf_suv_WT_0701_09_50$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_50$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_50$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '55s',Mn_sp=mean(tf_suv_WT_0701_09_55$X17),Total_dist=mean(tf_suv_WT_0701_09_55$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_55$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_55$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0701_09', duration = '60s',Mn_sp=mean(tf_suv_WT_0701_09_60$X17),Total_dist=mean(tf_suv_WT_0701_09_60$X23),Cfn_ratio=mean(tf_suv_WT_0701_09_60$X25),Mn_straight_sp=mean(tf_suv_WT_0701_09_60$X26),Line_fwd_prog=mean(tf_suv_WT_0701_09_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0701_09_60$X28)))

rm(tf_suv_WT_0701_09_b5)
rm(tf_suv_WT_0701_09_5)
rm(tf_suv_WT_0701_09_10)
rm(tf_suv_WT_0701_09_15)
rm(tf_suv_WT_0701_09_20)
rm(tf_suv_WT_0701_09_25)
rm(tf_suv_WT_0701_09_30)
rm(tf_suv_WT_0701_09_35)
rm(tf_suv_WT_0701_09_40)
rm(tf_suv_WT_0701_09_45)
rm(tf_suv_WT_0701_09_50)
rm(tf_suv_WT_0701_09_55)
rm(tf_suv_WT_0701_09_60)







tf_suv_WT_0702_03_b5 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_5 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_10 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_15 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_20 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_25 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_30 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_35 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_40 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_45 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_50 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_55 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_03_60 <- read_csv("~/Martin behaviour/WT/WT_0702_03/tracking parameters/WT_0702_03_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = 'before',Mn_sp=mean(tf_suv_WT_0702_03_b5$X17),Total_dist=mean(tf_suv_WT_0702_03_b5$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '5s',Mn_sp=mean(tf_suv_WT_0702_03_5$X17),Total_dist=mean(tf_suv_WT_0702_03_5$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_5$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_5$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '10s',Mn_sp=mean(tf_suv_WT_0702_03_10$X17),Total_dist=mean(tf_suv_WT_0702_03_10$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_10$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_10$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '15s',Mn_sp=mean(tf_suv_WT_0702_03_15$X17),Total_dist=mean(tf_suv_WT_0702_03_15$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_15$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_15$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '20s',Mn_sp=mean(tf_suv_WT_0702_03_20$X17),Total_dist=mean(tf_suv_WT_0702_03_20$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_20$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_20$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '25s',Mn_sp=mean(tf_suv_WT_0702_03_25$X17),Total_dist=mean(tf_suv_WT_0702_03_25$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_25$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_25$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '30s',Mn_sp=mean(tf_suv_WT_0702_03_30$X17),Total_dist=mean(tf_suv_WT_0702_03_30$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_30$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_30$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '35s',Mn_sp=mean(tf_suv_WT_0702_03_35$X17),Total_dist=mean(tf_suv_WT_0702_03_35$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_35$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_35$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '40s',Mn_sp=mean(tf_suv_WT_0702_03_40$X17),Total_dist=mean(tf_suv_WT_0702_03_40$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_40$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_40$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '45s',Mn_sp=mean(tf_suv_WT_0702_03_45$X17),Total_dist=mean(tf_suv_WT_0702_03_45$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_45$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_45$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '50s',Mn_sp=mean(tf_suv_WT_0702_03_50$X17),Total_dist=mean(tf_suv_WT_0702_03_50$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_50$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_50$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '55s',Mn_sp=mean(tf_suv_WT_0702_03_55$X17),Total_dist=mean(tf_suv_WT_0702_03_55$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_55$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_55$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_03', duration = '60s',Mn_sp=mean(tf_suv_WT_0702_03_60$X17),Total_dist=mean(tf_suv_WT_0702_03_60$X23),Cfn_ratio=mean(tf_suv_WT_0702_03_60$X25),Mn_straight_sp=mean(tf_suv_WT_0702_03_60$X26),Line_fwd_prog=mean(tf_suv_WT_0702_03_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_03_60$X28)))

rm(tf_suv_WT_0702_03_b5)
rm(tf_suv_WT_0702_03_5)
rm(tf_suv_WT_0702_03_10)
rm(tf_suv_WT_0702_03_15)
rm(tf_suv_WT_0702_03_20)
rm(tf_suv_WT_0702_03_25)
rm(tf_suv_WT_0702_03_30)
rm(tf_suv_WT_0702_03_35)
rm(tf_suv_WT_0702_03_40)
rm(tf_suv_WT_0702_03_45)
rm(tf_suv_WT_0702_03_50)
rm(tf_suv_WT_0702_03_55)
rm(tf_suv_WT_0702_03_60)







tf_suv_WT_0702_04_b5 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_5 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_10 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_15 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_20 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_25 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_30 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_35 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_40 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_45 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_50 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_55 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_04_60 <- read_csv("~/Martin behaviour/WT/WT_0702_04/tracking parameters/WT_0702_04_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = 'before',Mn_sp=mean(tf_suv_WT_0702_04_b5$X17),Total_dist=mean(tf_suv_WT_0702_04_b5$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '5s',Mn_sp=mean(tf_suv_WT_0702_04_5$X17),Total_dist=mean(tf_suv_WT_0702_04_5$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_5$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_5$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '10s',Mn_sp=mean(tf_suv_WT_0702_04_10$X17),Total_dist=mean(tf_suv_WT_0702_04_10$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_10$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_10$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '15s',Mn_sp=mean(tf_suv_WT_0702_04_15$X17),Total_dist=mean(tf_suv_WT_0702_04_15$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_15$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_15$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '20s',Mn_sp=mean(tf_suv_WT_0702_04_20$X17),Total_dist=mean(tf_suv_WT_0702_04_20$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_20$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_20$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '25s',Mn_sp=mean(tf_suv_WT_0702_04_25$X17),Total_dist=mean(tf_suv_WT_0702_04_25$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_25$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_25$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '30s',Mn_sp=mean(tf_suv_WT_0702_04_30$X17),Total_dist=mean(tf_suv_WT_0702_04_30$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_30$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_30$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '35s',Mn_sp=mean(tf_suv_WT_0702_04_35$X17),Total_dist=mean(tf_suv_WT_0702_04_35$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_35$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_35$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '40s',Mn_sp=mean(tf_suv_WT_0702_04_40$X17),Total_dist=mean(tf_suv_WT_0702_04_40$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_40$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_40$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '45s',Mn_sp=mean(tf_suv_WT_0702_04_45$X17),Total_dist=mean(tf_suv_WT_0702_04_45$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_45$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_45$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '50s',Mn_sp=mean(tf_suv_WT_0702_04_50$X17),Total_dist=mean(tf_suv_WT_0702_04_50$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_50$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_50$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '55s',Mn_sp=mean(tf_suv_WT_0702_04_55$X17),Total_dist=mean(tf_suv_WT_0702_04_55$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_55$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_55$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_04', duration = '60s',Mn_sp=mean(tf_suv_WT_0702_04_60$X17),Total_dist=mean(tf_suv_WT_0702_04_60$X23),Cfn_ratio=mean(tf_suv_WT_0702_04_60$X25),Mn_straight_sp=mean(tf_suv_WT_0702_04_60$X26),Line_fwd_prog=mean(tf_suv_WT_0702_04_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_04_60$X28)))

rm(tf_suv_WT_0702_04_b5)
rm(tf_suv_WT_0702_04_5)
rm(tf_suv_WT_0702_04_10)
rm(tf_suv_WT_0702_04_15)
rm(tf_suv_WT_0702_04_20)
rm(tf_suv_WT_0702_04_25)
rm(tf_suv_WT_0702_04_30)
rm(tf_suv_WT_0702_04_35)
rm(tf_suv_WT_0702_04_40)
rm(tf_suv_WT_0702_04_45)
rm(tf_suv_WT_0702_04_50)
rm(tf_suv_WT_0702_04_55)
rm(tf_suv_WT_0702_04_60)







tf_suv_WT_0702_05_b5 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_5 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_10 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_15 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_20 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_25 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_30 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_35 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_40 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_45 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_50 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_55 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0702_05_60 <- read_csv("~/Martin behaviour/WT/WT_0702_05/tracking parameters/WT_0702_05_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = 'before',Mn_sp=mean(tf_suv_WT_0702_05_b5$X17),Total_dist=mean(tf_suv_WT_0702_05_b5$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '5s',Mn_sp=mean(tf_suv_WT_0702_05_5$X17),Total_dist=mean(tf_suv_WT_0702_05_5$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_5$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_5$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '10s',Mn_sp=mean(tf_suv_WT_0702_05_10$X17),Total_dist=mean(tf_suv_WT_0702_05_10$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_10$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_10$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '15s',Mn_sp=mean(tf_suv_WT_0702_05_15$X17),Total_dist=mean(tf_suv_WT_0702_05_15$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_15$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_15$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '20s',Mn_sp=mean(tf_suv_WT_0702_05_20$X17),Total_dist=mean(tf_suv_WT_0702_05_20$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_20$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_20$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '25s',Mn_sp=mean(tf_suv_WT_0702_05_25$X17),Total_dist=mean(tf_suv_WT_0702_05_25$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_25$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_25$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '30s',Mn_sp=mean(tf_suv_WT_0702_05_30$X17),Total_dist=mean(tf_suv_WT_0702_05_30$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_30$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_30$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '35s',Mn_sp=mean(tf_suv_WT_0702_05_35$X17),Total_dist=mean(tf_suv_WT_0702_05_35$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_35$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_35$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '40s',Mn_sp=mean(tf_suv_WT_0702_05_40$X17),Total_dist=mean(tf_suv_WT_0702_05_40$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_40$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_40$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '45s',Mn_sp=mean(tf_suv_WT_0702_05_45$X17),Total_dist=mean(tf_suv_WT_0702_05_45$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_45$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_45$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '50s',Mn_sp=mean(tf_suv_WT_0702_05_50$X17),Total_dist=mean(tf_suv_WT_0702_05_50$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_50$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_50$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '55s',Mn_sp=mean(tf_suv_WT_0702_05_55$X17),Total_dist=mean(tf_suv_WT_0702_05_55$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_55$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_55$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0702_05', duration = '60s',Mn_sp=mean(tf_suv_WT_0702_05_60$X17),Total_dist=mean(tf_suv_WT_0702_05_60$X23),Cfn_ratio=mean(tf_suv_WT_0702_05_60$X25),Mn_straight_sp=mean(tf_suv_WT_0702_05_60$X26),Line_fwd_prog=mean(tf_suv_WT_0702_05_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0702_05_60$X28)))

rm(tf_suv_WT_0702_05_b5)
rm(tf_suv_WT_0702_05_5)
rm(tf_suv_WT_0702_05_10)
rm(tf_suv_WT_0702_05_15)
rm(tf_suv_WT_0702_05_20)
rm(tf_suv_WT_0702_05_25)
rm(tf_suv_WT_0702_05_30)
rm(tf_suv_WT_0702_05_35)
rm(tf_suv_WT_0702_05_40)
rm(tf_suv_WT_0702_05_45)
rm(tf_suv_WT_0702_05_50)
rm(tf_suv_WT_0702_05_55)
rm(tf_suv_WT_0702_05_60)







tf_suv_WT_0703_07_b5 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_5 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_10 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_15 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_20 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_25 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_30 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_35 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_40 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_45 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_50 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_55 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0703_07_60 <- read_csv("~/Martin behaviour/WT/WT_0703_07/tracking parameters/WT_0703_07_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = 'before',Mn_sp=mean(tf_suv_WT_0703_07_b5$X17),Total_dist=mean(tf_suv_WT_0703_07_b5$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '5s',Mn_sp=mean(tf_suv_WT_0703_07_5$X17),Total_dist=mean(tf_suv_WT_0703_07_5$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_5$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_5$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '10s',Mn_sp=mean(tf_suv_WT_0703_07_10$X17),Total_dist=mean(tf_suv_WT_0703_07_10$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_10$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_10$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '15s',Mn_sp=mean(tf_suv_WT_0703_07_15$X17),Total_dist=mean(tf_suv_WT_0703_07_15$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_15$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_15$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '20s',Mn_sp=mean(tf_suv_WT_0703_07_20$X17),Total_dist=mean(tf_suv_WT_0703_07_20$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_20$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_20$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '25s',Mn_sp=mean(tf_suv_WT_0703_07_25$X17),Total_dist=mean(tf_suv_WT_0703_07_25$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_25$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_25$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '30s',Mn_sp=mean(tf_suv_WT_0703_07_30$X17),Total_dist=mean(tf_suv_WT_0703_07_30$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_30$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_30$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '35s',Mn_sp=mean(tf_suv_WT_0703_07_35$X17),Total_dist=mean(tf_suv_WT_0703_07_35$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_35$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_35$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '40s',Mn_sp=mean(tf_suv_WT_0703_07_40$X17),Total_dist=mean(tf_suv_WT_0703_07_40$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_40$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_40$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '45s',Mn_sp=mean(tf_suv_WT_0703_07_45$X17),Total_dist=mean(tf_suv_WT_0703_07_45$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_45$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_45$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '50s',Mn_sp=mean(tf_suv_WT_0703_07_50$X17),Total_dist=mean(tf_suv_WT_0703_07_50$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_50$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_50$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '55s',Mn_sp=mean(tf_suv_WT_0703_07_55$X17),Total_dist=mean(tf_suv_WT_0703_07_55$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_55$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_55$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0703_07', duration = '60s',Mn_sp=mean(tf_suv_WT_0703_07_60$X17),Total_dist=mean(tf_suv_WT_0703_07_60$X23),Cfn_ratio=mean(tf_suv_WT_0703_07_60$X25),Mn_straight_sp=mean(tf_suv_WT_0703_07_60$X26),Line_fwd_prog=mean(tf_suv_WT_0703_07_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0703_07_60$X28)))

rm(tf_suv_WT_0703_07_b5)
rm(tf_suv_WT_0703_07_5)
rm(tf_suv_WT_0703_07_10)
rm(tf_suv_WT_0703_07_15)
rm(tf_suv_WT_0703_07_20)
rm(tf_suv_WT_0703_07_25)
rm(tf_suv_WT_0703_07_30)
rm(tf_suv_WT_0703_07_35)
rm(tf_suv_WT_0703_07_40)
rm(tf_suv_WT_0703_07_45)
rm(tf_suv_WT_0703_07_50)
rm(tf_suv_WT_0703_07_55)
rm(tf_suv_WT_0703_07_60)







tf_suv_WT_0704_02_b5 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_5 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_10 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_15 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_20 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_25 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_30 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_35 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_40 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_45 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_50 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_55 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0704_02_60 <- read_csv("~/Martin behaviour/WT/WT_0704_02/tracking parameters/WT_0704_02_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = 'before',Mn_sp=mean(tf_suv_WT_0704_02_b5$X17),Total_dist=mean(tf_suv_WT_0704_02_b5$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '5s',Mn_sp=mean(tf_suv_WT_0704_02_5$X17),Total_dist=mean(tf_suv_WT_0704_02_5$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_5$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_5$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '10s',Mn_sp=mean(tf_suv_WT_0704_02_10$X17),Total_dist=mean(tf_suv_WT_0704_02_10$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_10$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_10$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '15s',Mn_sp=mean(tf_suv_WT_0704_02_15$X17),Total_dist=mean(tf_suv_WT_0704_02_15$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_15$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_15$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '20s',Mn_sp=mean(tf_suv_WT_0704_02_20$X17),Total_dist=mean(tf_suv_WT_0704_02_20$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_20$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_20$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '25s',Mn_sp=mean(tf_suv_WT_0704_02_25$X17),Total_dist=mean(tf_suv_WT_0704_02_25$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_25$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_25$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '30s',Mn_sp=mean(tf_suv_WT_0704_02_30$X17),Total_dist=mean(tf_suv_WT_0704_02_30$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_30$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_30$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '35s',Mn_sp=mean(tf_suv_WT_0704_02_35$X17),Total_dist=mean(tf_suv_WT_0704_02_35$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_35$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_35$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '40s',Mn_sp=mean(tf_suv_WT_0704_02_40$X17),Total_dist=mean(tf_suv_WT_0704_02_40$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_40$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_40$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '45s',Mn_sp=mean(tf_suv_WT_0704_02_45$X17),Total_dist=mean(tf_suv_WT_0704_02_45$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_45$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_45$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '50s',Mn_sp=mean(tf_suv_WT_0704_02_50$X17),Total_dist=mean(tf_suv_WT_0704_02_50$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_50$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_50$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '55s',Mn_sp=mean(tf_suv_WT_0704_02_55$X17),Total_dist=mean(tf_suv_WT_0704_02_55$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_55$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_55$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0704_02', duration = '60s',Mn_sp=mean(tf_suv_WT_0704_02_60$X17),Total_dist=mean(tf_suv_WT_0704_02_60$X23),Cfn_ratio=mean(tf_suv_WT_0704_02_60$X25),Mn_straight_sp=mean(tf_suv_WT_0704_02_60$X26),Line_fwd_prog=mean(tf_suv_WT_0704_02_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0704_02_60$X28)))

rm(tf_suv_WT_0704_02_b5)
rm(tf_suv_WT_0704_02_5)
rm(tf_suv_WT_0704_02_10)
rm(tf_suv_WT_0704_02_15)
rm(tf_suv_WT_0704_02_20)
rm(tf_suv_WT_0704_02_25)
rm(tf_suv_WT_0704_02_30)
rm(tf_suv_WT_0704_02_35)
rm(tf_suv_WT_0704_02_40)
rm(tf_suv_WT_0704_02_45)
rm(tf_suv_WT_0704_02_50)
rm(tf_suv_WT_0704_02_55)
rm(tf_suv_WT_0704_02_60)







tf_suv_WT_0705_00_b5 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_5 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_10 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_15 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_20 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_25 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_30 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_35 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_40 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_45 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_50 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_55 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0705_00_60 <- read_csv("~/Martin behaviour/WT/WT_0705_00/tracking parameters/WT_0705_00_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = 'before',Mn_sp=mean(tf_suv_WT_0705_00_b5$X17),Total_dist=mean(tf_suv_WT_0705_00_b5$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '5s',Mn_sp=mean(tf_suv_WT_0705_00_5$X17),Total_dist=mean(tf_suv_WT_0705_00_5$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_5$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_5$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '10s',Mn_sp=mean(tf_suv_WT_0705_00_10$X17),Total_dist=mean(tf_suv_WT_0705_00_10$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_10$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_10$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '15s',Mn_sp=mean(tf_suv_WT_0705_00_15$X17),Total_dist=mean(tf_suv_WT_0705_00_15$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_15$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_15$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '20s',Mn_sp=mean(tf_suv_WT_0705_00_20$X17),Total_dist=mean(tf_suv_WT_0705_00_20$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_20$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_20$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '25s',Mn_sp=mean(tf_suv_WT_0705_00_25$X17),Total_dist=mean(tf_suv_WT_0705_00_25$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_25$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_25$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '30s',Mn_sp=mean(tf_suv_WT_0705_00_30$X17),Total_dist=mean(tf_suv_WT_0705_00_30$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_30$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_30$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '35s',Mn_sp=mean(tf_suv_WT_0705_00_35$X17),Total_dist=mean(tf_suv_WT_0705_00_35$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_35$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_35$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '40s',Mn_sp=mean(tf_suv_WT_0705_00_40$X17),Total_dist=mean(tf_suv_WT_0705_00_40$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_40$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_40$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '45s',Mn_sp=mean(tf_suv_WT_0705_00_45$X17),Total_dist=mean(tf_suv_WT_0705_00_45$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_45$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_45$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '50s',Mn_sp=mean(tf_suv_WT_0705_00_50$X17),Total_dist=mean(tf_suv_WT_0705_00_50$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_50$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_50$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '55s',Mn_sp=mean(tf_suv_WT_0705_00_55$X17),Total_dist=mean(tf_suv_WT_0705_00_55$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_55$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_55$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0705_00', duration = '60s',Mn_sp=mean(tf_suv_WT_0705_00_60$X17),Total_dist=mean(tf_suv_WT_0705_00_60$X23),Cfn_ratio=mean(tf_suv_WT_0705_00_60$X25),Mn_straight_sp=mean(tf_suv_WT_0705_00_60$X26),Line_fwd_prog=mean(tf_suv_WT_0705_00_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0705_00_60$X28)))

rm(tf_suv_WT_0705_00_b5)
rm(tf_suv_WT_0705_00_5)
rm(tf_suv_WT_0705_00_10)
rm(tf_suv_WT_0705_00_15)
rm(tf_suv_WT_0705_00_20)
rm(tf_suv_WT_0705_00_25)
rm(tf_suv_WT_0705_00_30)
rm(tf_suv_WT_0705_00_35)
rm(tf_suv_WT_0705_00_40)
rm(tf_suv_WT_0705_00_45)
rm(tf_suv_WT_0705_00_50)
rm(tf_suv_WT_0705_00_55)
rm(tf_suv_WT_0705_00_60)












tf_suv_WT_0706_00_b5 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_5 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_10 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_15 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_20 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_25 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_30 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_35 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_40 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_45 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_50 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_55 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_WT_0706_00_60 <- read_csv("~/Martin behaviour/WT/WT_0706_00/tracking parameters/WT_0706_00_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = 'before',Mn_sp=mean(tf_suv_WT_0706_00_b5$X17),Total_dist=mean(tf_suv_WT_0706_00_b5$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_b5$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_b5$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_b5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '5s',Mn_sp=mean(tf_suv_WT_0706_00_5$X17),Total_dist=mean(tf_suv_WT_0706_00_5$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_5$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_5$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_5$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '10s',Mn_sp=mean(tf_suv_WT_0706_00_10$X17),Total_dist=mean(tf_suv_WT_0706_00_10$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_10$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_10$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_10$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '15s',Mn_sp=mean(tf_suv_WT_0706_00_15$X17),Total_dist=mean(tf_suv_WT_0706_00_15$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_15$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_15$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_15$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '20s',Mn_sp=mean(tf_suv_WT_0706_00_20$X17),Total_dist=mean(tf_suv_WT_0706_00_20$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_20$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_20$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_20$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '25s',Mn_sp=mean(tf_suv_WT_0706_00_25$X17),Total_dist=mean(tf_suv_WT_0706_00_25$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_25$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_25$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_25$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '30s',Mn_sp=mean(tf_suv_WT_0706_00_30$X17),Total_dist=mean(tf_suv_WT_0706_00_30$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_30$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_30$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_30$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '35s',Mn_sp=mean(tf_suv_WT_0706_00_35$X17),Total_dist=mean(tf_suv_WT_0706_00_35$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_35$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_35$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_35$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '40s',Mn_sp=mean(tf_suv_WT_0706_00_40$X17),Total_dist=mean(tf_suv_WT_0706_00_40$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_40$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_40$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_40$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '45s',Mn_sp=mean(tf_suv_WT_0706_00_45$X17),Total_dist=mean(tf_suv_WT_0706_00_45$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_45$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_45$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_45$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '50s',Mn_sp=mean(tf_suv_WT_0706_00_50$X17),Total_dist=mean(tf_suv_WT_0706_00_50$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_50$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_50$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_50$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '55s',Mn_sp=mean(tf_suv_WT_0706_00_55$X17),Total_dist=mean(tf_suv_WT_0706_00_55$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_55$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_55$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_55$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'WT', batch = '0706_00', duration = '60s',Mn_sp=mean(tf_suv_WT_0706_00_60$X17),Total_dist=mean(tf_suv_WT_0706_00_60$X23),Cfn_ratio=mean(tf_suv_WT_0706_00_60$X25),Mn_straight_sp=mean(tf_suv_WT_0706_00_60$X26),Line_fwd_prog=mean(tf_suv_WT_0706_00_60$X27),Mn_directional_change_rate=mean(tf_suv_WT_0706_00_60$X28)))

rm(tf_suv_WT_0706_00_b5)
rm(tf_suv_WT_0706_00_5)
rm(tf_suv_WT_0706_00_10)
rm(tf_suv_WT_0706_00_15)
rm(tf_suv_WT_0706_00_20)
rm(tf_suv_WT_0706_00_25)
rm(tf_suv_WT_0706_00_30)
rm(tf_suv_WT_0706_00_35)
rm(tf_suv_WT_0706_00_40)
rm(tf_suv_WT_0706_00_45)
rm(tf_suv_WT_0706_00_50)
rm(tf_suv_WT_0706_00_55)
rm(tf_suv_WT_0706_00_60)




















tf_suv_NOS_0623_00_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_5 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_10 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_15 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_20 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_25 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_30 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_35 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_40 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_45 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_50 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_55 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_00_60 <- read_csv("~/Martin behaviour/NOS/NOS_0623_00/tracking parameters/NOS_0623_00_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = 'before',Mn_sp=mean(tf_suv_NOS_0623_00_b5$X17),Total_dist=mean(tf_suv_NOS_0623_00_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '5s',Mn_sp=mean(tf_suv_NOS_0623_00_5$X17),Total_dist=mean(tf_suv_NOS_0623_00_5$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '10s',Mn_sp=mean(tf_suv_NOS_0623_00_10$X17),Total_dist=mean(tf_suv_NOS_0623_00_10$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '15s',Mn_sp=mean(tf_suv_NOS_0623_00_15$X17),Total_dist=mean(tf_suv_NOS_0623_00_15$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '20s',Mn_sp=mean(tf_suv_NOS_0623_00_20$X17),Total_dist=mean(tf_suv_NOS_0623_00_20$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '25s',Mn_sp=mean(tf_suv_NOS_0623_00_25$X17),Total_dist=mean(tf_suv_NOS_0623_00_25$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '30s',Mn_sp=mean(tf_suv_NOS_0623_00_30$X17),Total_dist=mean(tf_suv_NOS_0623_00_30$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '35s',Mn_sp=mean(tf_suv_NOS_0623_00_35$X17),Total_dist=mean(tf_suv_NOS_0623_00_35$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '40s',Mn_sp=mean(tf_suv_NOS_0623_00_40$X17),Total_dist=mean(tf_suv_NOS_0623_00_40$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '45s',Mn_sp=mean(tf_suv_NOS_0623_00_45$X17),Total_dist=mean(tf_suv_NOS_0623_00_45$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '50s',Mn_sp=mean(tf_suv_NOS_0623_00_50$X17),Total_dist=mean(tf_suv_NOS_0623_00_50$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '55s',Mn_sp=mean(tf_suv_NOS_0623_00_55$X17),Total_dist=mean(tf_suv_NOS_0623_00_55$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_00', duration = '60s',Mn_sp=mean(tf_suv_NOS_0623_00_60$X17),Total_dist=mean(tf_suv_NOS_0623_00_60$X23),Cfn_ratio=mean(tf_suv_NOS_0623_00_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_00_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_00_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_00_60$X28)))

rm(tf_suv_NOS_0623_00_b5)
rm(tf_suv_NOS_0623_00_5)
rm(tf_suv_NOS_0623_00_10)
rm(tf_suv_NOS_0623_00_15)
rm(tf_suv_NOS_0623_00_20)
rm(tf_suv_NOS_0623_00_25)
rm(tf_suv_NOS_0623_00_30)
rm(tf_suv_NOS_0623_00_35)
rm(tf_suv_NOS_0623_00_40)
rm(tf_suv_NOS_0623_00_45)
rm(tf_suv_NOS_0623_00_50)
rm(tf_suv_NOS_0623_00_55)
rm(tf_suv_NOS_0623_00_60)








tf_suv_NOS_0623_02_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_5 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_10 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_15 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_20 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_25 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_30 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_35 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_40 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_45 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_50 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_55 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0623_02_60 <- read_csv("~/Martin behaviour/NOS/NOS_0623_02/tracking parameters/NOS_0623_02_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = 'before',Mn_sp=mean(tf_suv_NOS_0623_02_b5$X17),Total_dist=mean(tf_suv_NOS_0623_02_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '5s',Mn_sp=mean(tf_suv_NOS_0623_02_5$X17),Total_dist=mean(tf_suv_NOS_0623_02_5$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '10s',Mn_sp=mean(tf_suv_NOS_0623_02_10$X17),Total_dist=mean(tf_suv_NOS_0623_02_10$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '15s',Mn_sp=mean(tf_suv_NOS_0623_02_15$X17),Total_dist=mean(tf_suv_NOS_0623_02_15$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '20s',Mn_sp=mean(tf_suv_NOS_0623_02_20$X17),Total_dist=mean(tf_suv_NOS_0623_02_20$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '25s',Mn_sp=mean(tf_suv_NOS_0623_02_25$X17),Total_dist=mean(tf_suv_NOS_0623_02_25$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '30s',Mn_sp=mean(tf_suv_NOS_0623_02_30$X17),Total_dist=mean(tf_suv_NOS_0623_02_30$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '35s',Mn_sp=mean(tf_suv_NOS_0623_02_35$X17),Total_dist=mean(tf_suv_NOS_0623_02_35$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '40s',Mn_sp=mean(tf_suv_NOS_0623_02_40$X17),Total_dist=mean(tf_suv_NOS_0623_02_40$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '45s',Mn_sp=mean(tf_suv_NOS_0623_02_45$X17),Total_dist=mean(tf_suv_NOS_0623_02_45$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '50s',Mn_sp=mean(tf_suv_NOS_0623_02_50$X17),Total_dist=mean(tf_suv_NOS_0623_02_50$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '55s',Mn_sp=mean(tf_suv_NOS_0623_02_55$X17),Total_dist=mean(tf_suv_NOS_0623_02_55$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0623_02', duration = '60s',Mn_sp=mean(tf_suv_NOS_0623_02_60$X17),Total_dist=mean(tf_suv_NOS_0623_02_60$X23),Cfn_ratio=mean(tf_suv_NOS_0623_02_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0623_02_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0623_02_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0623_02_60$X28)))

rm(tf_suv_NOS_0623_02_b5)
rm(tf_suv_NOS_0623_02_5)
rm(tf_suv_NOS_0623_02_10)
rm(tf_suv_NOS_0623_02_15)
rm(tf_suv_NOS_0623_02_20)
rm(tf_suv_NOS_0623_02_25)
rm(tf_suv_NOS_0623_02_30)
rm(tf_suv_NOS_0623_02_35)
rm(tf_suv_NOS_0623_02_40)
rm(tf_suv_NOS_0623_02_45)
rm(tf_suv_NOS_0623_02_50)
rm(tf_suv_NOS_0623_02_55)
rm(tf_suv_NOS_0623_02_60)








tf_suv_NOS_0624_00_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_5 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_10 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_15 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_20 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_25 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_30 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_35 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_40 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_45 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_50 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_55 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_00_60 <- read_csv("~/Martin behaviour/NOS/NOS_0624_00/tracking parameters/NOS_0624_00_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = 'before',Mn_sp=mean(tf_suv_NOS_0624_00_b5$X17),Total_dist=mean(tf_suv_NOS_0624_00_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '5s',Mn_sp=mean(tf_suv_NOS_0624_00_5$X17),Total_dist=mean(tf_suv_NOS_0624_00_5$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '10s',Mn_sp=mean(tf_suv_NOS_0624_00_10$X17),Total_dist=mean(tf_suv_NOS_0624_00_10$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '15s',Mn_sp=mean(tf_suv_NOS_0624_00_15$X17),Total_dist=mean(tf_suv_NOS_0624_00_15$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '20s',Mn_sp=mean(tf_suv_NOS_0624_00_20$X17),Total_dist=mean(tf_suv_NOS_0624_00_20$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '25s',Mn_sp=mean(tf_suv_NOS_0624_00_25$X17),Total_dist=mean(tf_suv_NOS_0624_00_25$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '30s',Mn_sp=mean(tf_suv_NOS_0624_00_30$X17),Total_dist=mean(tf_suv_NOS_0624_00_30$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '35s',Mn_sp=mean(tf_suv_NOS_0624_00_35$X17),Total_dist=mean(tf_suv_NOS_0624_00_35$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '40s',Mn_sp=mean(tf_suv_NOS_0624_00_40$X17),Total_dist=mean(tf_suv_NOS_0624_00_40$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '45s',Mn_sp=mean(tf_suv_NOS_0624_00_45$X17),Total_dist=mean(tf_suv_NOS_0624_00_45$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '50s',Mn_sp=mean(tf_suv_NOS_0624_00_50$X17),Total_dist=mean(tf_suv_NOS_0624_00_50$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '55s',Mn_sp=mean(tf_suv_NOS_0624_00_55$X17),Total_dist=mean(tf_suv_NOS_0624_00_55$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_00', duration = '60s',Mn_sp=mean(tf_suv_NOS_0624_00_60$X17),Total_dist=mean(tf_suv_NOS_0624_00_60$X23),Cfn_ratio=mean(tf_suv_NOS_0624_00_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_00_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_00_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_00_60$X28)))

rm(tf_suv_NOS_0624_00_b5)
rm(tf_suv_NOS_0624_00_5)
rm(tf_suv_NOS_0624_00_10)
rm(tf_suv_NOS_0624_00_15)
rm(tf_suv_NOS_0624_00_20)
rm(tf_suv_NOS_0624_00_25)
rm(tf_suv_NOS_0624_00_30)
rm(tf_suv_NOS_0624_00_35)
rm(tf_suv_NOS_0624_00_40)
rm(tf_suv_NOS_0624_00_45)
rm(tf_suv_NOS_0624_00_50)
rm(tf_suv_NOS_0624_00_55)
rm(tf_suv_NOS_0624_00_60)








tf_suv_NOS_0624_01_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_5 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_10 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_15 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_20 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_25 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_30 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_35 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_40 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_45 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_50 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_55 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0624_01_60 <- read_csv("~/Martin behaviour/NOS/NOS_0624_01/tracking parameters/NOS_0624_01_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = 'before',Mn_sp=mean(tf_suv_NOS_0624_01_b5$X17),Total_dist=mean(tf_suv_NOS_0624_01_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '5s',Mn_sp=mean(tf_suv_NOS_0624_01_5$X17),Total_dist=mean(tf_suv_NOS_0624_01_5$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '10s',Mn_sp=mean(tf_suv_NOS_0624_01_10$X17),Total_dist=mean(tf_suv_NOS_0624_01_10$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '15s',Mn_sp=mean(tf_suv_NOS_0624_01_15$X17),Total_dist=mean(tf_suv_NOS_0624_01_15$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '20s',Mn_sp=mean(tf_suv_NOS_0624_01_20$X17),Total_dist=mean(tf_suv_NOS_0624_01_20$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '25s',Mn_sp=mean(tf_suv_NOS_0624_01_25$X17),Total_dist=mean(tf_suv_NOS_0624_01_25$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '30s',Mn_sp=mean(tf_suv_NOS_0624_01_30$X17),Total_dist=mean(tf_suv_NOS_0624_01_30$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '35s',Mn_sp=mean(tf_suv_NOS_0624_01_35$X17),Total_dist=mean(tf_suv_NOS_0624_01_35$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '40s',Mn_sp=mean(tf_suv_NOS_0624_01_40$X17),Total_dist=mean(tf_suv_NOS_0624_01_40$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '45s',Mn_sp=mean(tf_suv_NOS_0624_01_45$X17),Total_dist=mean(tf_suv_NOS_0624_01_45$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '50s',Mn_sp=mean(tf_suv_NOS_0624_01_50$X17),Total_dist=mean(tf_suv_NOS_0624_01_50$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '55s',Mn_sp=mean(tf_suv_NOS_0624_01_55$X17),Total_dist=mean(tf_suv_NOS_0624_01_55$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0624_01', duration = '60s',Mn_sp=mean(tf_suv_NOS_0624_01_60$X17),Total_dist=mean(tf_suv_NOS_0624_01_60$X23),Cfn_ratio=mean(tf_suv_NOS_0624_01_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0624_01_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0624_01_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0624_01_60$X28)))

rm(tf_suv_NOS_0624_01_b5)
rm(tf_suv_NOS_0624_01_5)
rm(tf_suv_NOS_0624_01_10)
rm(tf_suv_NOS_0624_01_15)
rm(tf_suv_NOS_0624_01_20)
rm(tf_suv_NOS_0624_01_25)
rm(tf_suv_NOS_0624_01_30)
rm(tf_suv_NOS_0624_01_35)
rm(tf_suv_NOS_0624_01_40)
rm(tf_suv_NOS_0624_01_45)
rm(tf_suv_NOS_0624_01_50)
rm(tf_suv_NOS_0624_01_55)
rm(tf_suv_NOS_0624_01_60)








tf_suv_NOS_0627_02_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_5 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_10 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_15 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_20 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_25 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_30 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_35 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_40 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_45 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_50 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_55 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0627_02_60 <- read_csv("~/Martin behaviour/NOS/NOS_0627_02/tracking parameters/NOS_0627_02_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = 'before',Mn_sp=mean(tf_suv_NOS_0627_02_b5$X17),Total_dist=mean(tf_suv_NOS_0627_02_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '5s',Mn_sp=mean(tf_suv_NOS_0627_02_5$X17),Total_dist=mean(tf_suv_NOS_0627_02_5$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '10s',Mn_sp=mean(tf_suv_NOS_0627_02_10$X17),Total_dist=mean(tf_suv_NOS_0627_02_10$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '15s',Mn_sp=mean(tf_suv_NOS_0627_02_15$X17),Total_dist=mean(tf_suv_NOS_0627_02_15$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '20s',Mn_sp=mean(tf_suv_NOS_0627_02_20$X17),Total_dist=mean(tf_suv_NOS_0627_02_20$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '25s',Mn_sp=mean(tf_suv_NOS_0627_02_25$X17),Total_dist=mean(tf_suv_NOS_0627_02_25$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '30s',Mn_sp=mean(tf_suv_NOS_0627_02_30$X17),Total_dist=mean(tf_suv_NOS_0627_02_30$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '35s',Mn_sp=mean(tf_suv_NOS_0627_02_35$X17),Total_dist=mean(tf_suv_NOS_0627_02_35$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '40s',Mn_sp=mean(tf_suv_NOS_0627_02_40$X17),Total_dist=mean(tf_suv_NOS_0627_02_40$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '45s',Mn_sp=mean(tf_suv_NOS_0627_02_45$X17),Total_dist=mean(tf_suv_NOS_0627_02_45$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '50s',Mn_sp=mean(tf_suv_NOS_0627_02_50$X17),Total_dist=mean(tf_suv_NOS_0627_02_50$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '55s',Mn_sp=mean(tf_suv_NOS_0627_02_55$X17),Total_dist=mean(tf_suv_NOS_0627_02_55$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0627_02', duration = '60s',Mn_sp=mean(tf_suv_NOS_0627_02_60$X17),Total_dist=mean(tf_suv_NOS_0627_02_60$X23),Cfn_ratio=mean(tf_suv_NOS_0627_02_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0627_02_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0627_02_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0627_02_60$X28)))

rm(tf_suv_NOS_0627_02_b5)
rm(tf_suv_NOS_0627_02_5)
rm(tf_suv_NOS_0627_02_10)
rm(tf_suv_NOS_0627_02_15)
rm(tf_suv_NOS_0627_02_20)
rm(tf_suv_NOS_0627_02_25)
rm(tf_suv_NOS_0627_02_30)
rm(tf_suv_NOS_0627_02_35)
rm(tf_suv_NOS_0627_02_40)
rm(tf_suv_NOS_0627_02_45)
rm(tf_suv_NOS_0627_02_50)
rm(tf_suv_NOS_0627_02_55)
rm(tf_suv_NOS_0627_02_60)








tf_suv_NOS_0628_00_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_5 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_10 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_15 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_20 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_25 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_30 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_35 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_40 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_45 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_50 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_55 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_00_60 <- read_csv("~/Martin behaviour/NOS/NOS_0628_00/tracking parameters/NOS_0628_00_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = 'before',Mn_sp=mean(tf_suv_NOS_0628_00_b5$X17),Total_dist=mean(tf_suv_NOS_0628_00_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '5s',Mn_sp=mean(tf_suv_NOS_0628_00_5$X17),Total_dist=mean(tf_suv_NOS_0628_00_5$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '10s',Mn_sp=mean(tf_suv_NOS_0628_00_10$X17),Total_dist=mean(tf_suv_NOS_0628_00_10$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '15s',Mn_sp=mean(tf_suv_NOS_0628_00_15$X17),Total_dist=mean(tf_suv_NOS_0628_00_15$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '20s',Mn_sp=mean(tf_suv_NOS_0628_00_20$X17),Total_dist=mean(tf_suv_NOS_0628_00_20$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '25s',Mn_sp=mean(tf_suv_NOS_0628_00_25$X17),Total_dist=mean(tf_suv_NOS_0628_00_25$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '30s',Mn_sp=mean(tf_suv_NOS_0628_00_30$X17),Total_dist=mean(tf_suv_NOS_0628_00_30$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '35s',Mn_sp=mean(tf_suv_NOS_0628_00_35$X17),Total_dist=mean(tf_suv_NOS_0628_00_35$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '40s',Mn_sp=mean(tf_suv_NOS_0628_00_40$X17),Total_dist=mean(tf_suv_NOS_0628_00_40$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '45s',Mn_sp=mean(tf_suv_NOS_0628_00_45$X17),Total_dist=mean(tf_suv_NOS_0628_00_45$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '50s',Mn_sp=mean(tf_suv_NOS_0628_00_50$X17),Total_dist=mean(tf_suv_NOS_0628_00_50$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '55s',Mn_sp=mean(tf_suv_NOS_0628_00_55$X17),Total_dist=mean(tf_suv_NOS_0628_00_55$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_00', duration = '60s',Mn_sp=mean(tf_suv_NOS_0628_00_60$X17),Total_dist=mean(tf_suv_NOS_0628_00_60$X23),Cfn_ratio=mean(tf_suv_NOS_0628_00_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_00_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_00_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_00_60$X28)))

rm(tf_suv_NOS_0628_00_b5)
rm(tf_suv_NOS_0628_00_5)
rm(tf_suv_NOS_0628_00_10)
rm(tf_suv_NOS_0628_00_15)
rm(tf_suv_NOS_0628_00_20)
rm(tf_suv_NOS_0628_00_25)
rm(tf_suv_NOS_0628_00_30)
rm(tf_suv_NOS_0628_00_35)
rm(tf_suv_NOS_0628_00_40)
rm(tf_suv_NOS_0628_00_45)
rm(tf_suv_NOS_0628_00_50)
rm(tf_suv_NOS_0628_00_55)
rm(tf_suv_NOS_0628_00_60)








tf_suv_NOS_0628_01_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_5 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_10 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_15 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_20 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_25 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_30 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_35 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_40 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_45 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_50 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_55 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0628_01_60 <- read_csv("~/Martin behaviour/NOS/NOS_0628_01/tracking parameters/NOS_0628_01_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = 'before',Mn_sp=mean(tf_suv_NOS_0628_01_b5$X17),Total_dist=mean(tf_suv_NOS_0628_01_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '5s',Mn_sp=mean(tf_suv_NOS_0628_01_5$X17),Total_dist=mean(tf_suv_NOS_0628_01_5$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '10s',Mn_sp=mean(tf_suv_NOS_0628_01_10$X17),Total_dist=mean(tf_suv_NOS_0628_01_10$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '15s',Mn_sp=mean(tf_suv_NOS_0628_01_15$X17),Total_dist=mean(tf_suv_NOS_0628_01_15$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '20s',Mn_sp=mean(tf_suv_NOS_0628_01_20$X17),Total_dist=mean(tf_suv_NOS_0628_01_20$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '25s',Mn_sp=mean(tf_suv_NOS_0628_01_25$X17),Total_dist=mean(tf_suv_NOS_0628_01_25$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '30s',Mn_sp=mean(tf_suv_NOS_0628_01_30$X17),Total_dist=mean(tf_suv_NOS_0628_01_30$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '35s',Mn_sp=mean(tf_suv_NOS_0628_01_35$X17),Total_dist=mean(tf_suv_NOS_0628_01_35$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '40s',Mn_sp=mean(tf_suv_NOS_0628_01_40$X17),Total_dist=mean(tf_suv_NOS_0628_01_40$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '45s',Mn_sp=mean(tf_suv_NOS_0628_01_45$X17),Total_dist=mean(tf_suv_NOS_0628_01_45$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '50s',Mn_sp=mean(tf_suv_NOS_0628_01_50$X17),Total_dist=mean(tf_suv_NOS_0628_01_50$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '55s',Mn_sp=mean(tf_suv_NOS_0628_01_55$X17),Total_dist=mean(tf_suv_NOS_0628_01_55$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0628_01', duration = '60s',Mn_sp=mean(tf_suv_NOS_0628_01_60$X17),Total_dist=mean(tf_suv_NOS_0628_01_60$X23),Cfn_ratio=mean(tf_suv_NOS_0628_01_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0628_01_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0628_01_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0628_01_60$X28)))

rm(tf_suv_NOS_0628_01_b5)
rm(tf_suv_NOS_0628_01_5)
rm(tf_suv_NOS_0628_01_10)
rm(tf_suv_NOS_0628_01_15)
rm(tf_suv_NOS_0628_01_20)
rm(tf_suv_NOS_0628_01_25)
rm(tf_suv_NOS_0628_01_30)
rm(tf_suv_NOS_0628_01_35)
rm(tf_suv_NOS_0628_01_40)
rm(tf_suv_NOS_0628_01_45)
rm(tf_suv_NOS_0628_01_50)
rm(tf_suv_NOS_0628_01_55)
rm(tf_suv_NOS_0628_01_60)








tf_suv_NOS_0701_06_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_5 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_10 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_15 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_20 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_25 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_30 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_35 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_40 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_45 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_50 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_55 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_06_60 <- read_csv("~/Martin behaviour/NOS/NOS_0701_06/tracking parameters/NOS_0701_06_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = 'before',Mn_sp=mean(tf_suv_NOS_0701_06_b5$X17),Total_dist=mean(tf_suv_NOS_0701_06_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '5s',Mn_sp=mean(tf_suv_NOS_0701_06_5$X17),Total_dist=mean(tf_suv_NOS_0701_06_5$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '10s',Mn_sp=mean(tf_suv_NOS_0701_06_10$X17),Total_dist=mean(tf_suv_NOS_0701_06_10$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '15s',Mn_sp=mean(tf_suv_NOS_0701_06_15$X17),Total_dist=mean(tf_suv_NOS_0701_06_15$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '20s',Mn_sp=mean(tf_suv_NOS_0701_06_20$X17),Total_dist=mean(tf_suv_NOS_0701_06_20$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '25s',Mn_sp=mean(tf_suv_NOS_0701_06_25$X17),Total_dist=mean(tf_suv_NOS_0701_06_25$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '30s',Mn_sp=mean(tf_suv_NOS_0701_06_30$X17),Total_dist=mean(tf_suv_NOS_0701_06_30$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '35s',Mn_sp=mean(tf_suv_NOS_0701_06_35$X17),Total_dist=mean(tf_suv_NOS_0701_06_35$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '40s',Mn_sp=mean(tf_suv_NOS_0701_06_40$X17),Total_dist=mean(tf_suv_NOS_0701_06_40$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '45s',Mn_sp=mean(tf_suv_NOS_0701_06_45$X17),Total_dist=mean(tf_suv_NOS_0701_06_45$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '50s',Mn_sp=mean(tf_suv_NOS_0701_06_50$X17),Total_dist=mean(tf_suv_NOS_0701_06_50$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '55s',Mn_sp=mean(tf_suv_NOS_0701_06_55$X17),Total_dist=mean(tf_suv_NOS_0701_06_55$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_06', duration = '60s',Mn_sp=mean(tf_suv_NOS_0701_06_60$X17),Total_dist=mean(tf_suv_NOS_0701_06_60$X23),Cfn_ratio=mean(tf_suv_NOS_0701_06_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_06_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_06_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_06_60$X28)))

rm(tf_suv_NOS_0701_06_b5)
rm(tf_suv_NOS_0701_06_5)
rm(tf_suv_NOS_0701_06_10)
rm(tf_suv_NOS_0701_06_15)
rm(tf_suv_NOS_0701_06_20)
rm(tf_suv_NOS_0701_06_25)
rm(tf_suv_NOS_0701_06_30)
rm(tf_suv_NOS_0701_06_35)
rm(tf_suv_NOS_0701_06_40)
rm(tf_suv_NOS_0701_06_45)
rm(tf_suv_NOS_0701_06_50)
rm(tf_suv_NOS_0701_06_55)
rm(tf_suv_NOS_0701_06_60)








tf_suv_NOS_0701_07_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_5 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_10 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_15 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_20 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_25 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_30 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_35 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_40 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_45 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_50 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_55 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0701_07_60 <- read_csv("~/Martin behaviour/NOS/NOS_0701_07/tracking parameters/NOS_0701_07_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = 'before',Mn_sp=mean(tf_suv_NOS_0701_07_b5$X17),Total_dist=mean(tf_suv_NOS_0701_07_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '5s',Mn_sp=mean(tf_suv_NOS_0701_07_5$X17),Total_dist=mean(tf_suv_NOS_0701_07_5$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '10s',Mn_sp=mean(tf_suv_NOS_0701_07_10$X17),Total_dist=mean(tf_suv_NOS_0701_07_10$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '15s',Mn_sp=mean(tf_suv_NOS_0701_07_15$X17),Total_dist=mean(tf_suv_NOS_0701_07_15$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '20s',Mn_sp=mean(tf_suv_NOS_0701_07_20$X17),Total_dist=mean(tf_suv_NOS_0701_07_20$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '25s',Mn_sp=mean(tf_suv_NOS_0701_07_25$X17),Total_dist=mean(tf_suv_NOS_0701_07_25$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '30s',Mn_sp=mean(tf_suv_NOS_0701_07_30$X17),Total_dist=mean(tf_suv_NOS_0701_07_30$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '35s',Mn_sp=mean(tf_suv_NOS_0701_07_35$X17),Total_dist=mean(tf_suv_NOS_0701_07_35$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '40s',Mn_sp=mean(tf_suv_NOS_0701_07_40$X17),Total_dist=mean(tf_suv_NOS_0701_07_40$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '45s',Mn_sp=mean(tf_suv_NOS_0701_07_45$X17),Total_dist=mean(tf_suv_NOS_0701_07_45$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '50s',Mn_sp=mean(tf_suv_NOS_0701_07_50$X17),Total_dist=mean(tf_suv_NOS_0701_07_50$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '55s',Mn_sp=mean(tf_suv_NOS_0701_07_55$X17),Total_dist=mean(tf_suv_NOS_0701_07_55$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0701_07', duration = '60s',Mn_sp=mean(tf_suv_NOS_0701_07_60$X17),Total_dist=mean(tf_suv_NOS_0701_07_60$X23),Cfn_ratio=mean(tf_suv_NOS_0701_07_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0701_07_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0701_07_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0701_07_60$X28)))

rm(tf_suv_NOS_0701_07_b5)
rm(tf_suv_NOS_0701_07_5)
rm(tf_suv_NOS_0701_07_10)
rm(tf_suv_NOS_0701_07_15)
rm(tf_suv_NOS_0701_07_20)
rm(tf_suv_NOS_0701_07_25)
rm(tf_suv_NOS_0701_07_30)
rm(tf_suv_NOS_0701_07_35)
rm(tf_suv_NOS_0701_07_40)
rm(tf_suv_NOS_0701_07_45)
rm(tf_suv_NOS_0701_07_50)
rm(tf_suv_NOS_0701_07_55)
rm(tf_suv_NOS_0701_07_60)








tf_suv_NOS_0703_00_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_5 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_10 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_15 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_20 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_25 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_30 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_35 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_40 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_45 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_50 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_55 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_00_60 <- read_csv("~/Martin behaviour/NOS/NOS_0703_00/tracking parameters/NOS_0703_00_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = 'before',Mn_sp=mean(tf_suv_NOS_0703_00_b5$X17),Total_dist=mean(tf_suv_NOS_0703_00_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '5s',Mn_sp=mean(tf_suv_NOS_0703_00_5$X17),Total_dist=mean(tf_suv_NOS_0703_00_5$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '10s',Mn_sp=mean(tf_suv_NOS_0703_00_10$X17),Total_dist=mean(tf_suv_NOS_0703_00_10$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '15s',Mn_sp=mean(tf_suv_NOS_0703_00_15$X17),Total_dist=mean(tf_suv_NOS_0703_00_15$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '20s',Mn_sp=mean(tf_suv_NOS_0703_00_20$X17),Total_dist=mean(tf_suv_NOS_0703_00_20$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '25s',Mn_sp=mean(tf_suv_NOS_0703_00_25$X17),Total_dist=mean(tf_suv_NOS_0703_00_25$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '30s',Mn_sp=mean(tf_suv_NOS_0703_00_30$X17),Total_dist=mean(tf_suv_NOS_0703_00_30$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '35s',Mn_sp=mean(tf_suv_NOS_0703_00_35$X17),Total_dist=mean(tf_suv_NOS_0703_00_35$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '40s',Mn_sp=mean(tf_suv_NOS_0703_00_40$X17),Total_dist=mean(tf_suv_NOS_0703_00_40$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '45s',Mn_sp=mean(tf_suv_NOS_0703_00_45$X17),Total_dist=mean(tf_suv_NOS_0703_00_45$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '50s',Mn_sp=mean(tf_suv_NOS_0703_00_50$X17),Total_dist=mean(tf_suv_NOS_0703_00_50$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '55s',Mn_sp=mean(tf_suv_NOS_0703_00_55$X17),Total_dist=mean(tf_suv_NOS_0703_00_55$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_00', duration = '60s',Mn_sp=mean(tf_suv_NOS_0703_00_60$X17),Total_dist=mean(tf_suv_NOS_0703_00_60$X23),Cfn_ratio=mean(tf_suv_NOS_0703_00_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_00_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_00_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_00_60$X28)))

rm(tf_suv_NOS_0703_00_b5)
rm(tf_suv_NOS_0703_00_5)
rm(tf_suv_NOS_0703_00_10)
rm(tf_suv_NOS_0703_00_15)
rm(tf_suv_NOS_0703_00_20)
rm(tf_suv_NOS_0703_00_25)
rm(tf_suv_NOS_0703_00_30)
rm(tf_suv_NOS_0703_00_35)
rm(tf_suv_NOS_0703_00_40)
rm(tf_suv_NOS_0703_00_45)
rm(tf_suv_NOS_0703_00_50)
rm(tf_suv_NOS_0703_00_55)
rm(tf_suv_NOS_0703_00_60)








tf_suv_NOS_0703_01_b5 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_before_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_5 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_1-5_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_10 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_6-10_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_15 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_11-15_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_20 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_16-20_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_25 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_21-25_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_30 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_26-30_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_35 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_31-35_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_40 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_36-40_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_45 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_41-45_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_50 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_46-50_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_55 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_51-55_t.csv",col_names = FALSE, skip = 4)
tf_suv_NOS_0703_01_60 <- read_csv("~/Martin behaviour/NOS/NOS_0703_01/tracking parameters/NOS_0703_01_sUV_56-60_t.csv",col_names = FALSE, skip = 4)

tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = 'before',Mn_sp=mean(tf_suv_NOS_0703_01_b5$X17),Total_dist=mean(tf_suv_NOS_0703_01_b5$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_b5$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_b5$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_b5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_b5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '5s',Mn_sp=mean(tf_suv_NOS_0703_01_5$X17),Total_dist=mean(tf_suv_NOS_0703_01_5$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_5$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_5$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_5$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_5$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '10s',Mn_sp=mean(tf_suv_NOS_0703_01_10$X17),Total_dist=mean(tf_suv_NOS_0703_01_10$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_10$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_10$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_10$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_10$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '15s',Mn_sp=mean(tf_suv_NOS_0703_01_15$X17),Total_dist=mean(tf_suv_NOS_0703_01_15$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_15$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_15$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_15$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_15$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '20s',Mn_sp=mean(tf_suv_NOS_0703_01_20$X17),Total_dist=mean(tf_suv_NOS_0703_01_20$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_20$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_20$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_20$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_20$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '25s',Mn_sp=mean(tf_suv_NOS_0703_01_25$X17),Total_dist=mean(tf_suv_NOS_0703_01_25$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_25$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_25$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_25$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_25$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '30s',Mn_sp=mean(tf_suv_NOS_0703_01_30$X17),Total_dist=mean(tf_suv_NOS_0703_01_30$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_30$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_30$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_30$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_30$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '35s',Mn_sp=mean(tf_suv_NOS_0703_01_35$X17),Total_dist=mean(tf_suv_NOS_0703_01_35$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_35$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_35$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_35$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_35$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '40s',Mn_sp=mean(tf_suv_NOS_0703_01_40$X17),Total_dist=mean(tf_suv_NOS_0703_01_40$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_40$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_40$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_40$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_40$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '45s',Mn_sp=mean(tf_suv_NOS_0703_01_45$X17),Total_dist=mean(tf_suv_NOS_0703_01_45$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_45$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_45$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_45$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_45$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '50s',Mn_sp=mean(tf_suv_NOS_0703_01_50$X17),Total_dist=mean(tf_suv_NOS_0703_01_50$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_50$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_50$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_50$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_50$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '55s',Mn_sp=mean(tf_suv_NOS_0703_01_55$X17),Total_dist=mean(tf_suv_NOS_0703_01_55$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_55$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_55$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_55$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_55$X28)))
tf_suv_mean <- rbind(tf_suv_mean, data.frame(genotype = 'NOS', batch = '0703_01', duration = '60s',Mn_sp=mean(tf_suv_NOS_0703_01_60$X17),Total_dist=mean(tf_suv_NOS_0703_01_60$X23),Cfn_ratio=mean(tf_suv_NOS_0703_01_60$X25),Mn_straight_sp=mean(tf_suv_NOS_0703_01_60$X26),Line_fwd_prog=mean(tf_suv_NOS_0703_01_60$X27),Mn_directional_change_rate=mean(tf_suv_NOS_0703_01_60$X28)))

rm(tf_suv_NOS_0703_01_b5)
rm(tf_suv_NOS_0703_01_5)
rm(tf_suv_NOS_0703_01_10)
rm(tf_suv_NOS_0703_01_15)
rm(tf_suv_NOS_0703_01_20)
rm(tf_suv_NOS_0703_01_25)
rm(tf_suv_NOS_0703_01_30)
rm(tf_suv_NOS_0703_01_35)
rm(tf_suv_NOS_0703_01_40)
rm(tf_suv_NOS_0703_01_45)
rm(tf_suv_NOS_0703_01_50)
rm(tf_suv_NOS_0703_01_55)
rm(tf_suv_NOS_0703_01_60)


tf_suv_mean$duration <- 
  factor(tf_suv_mean$duration, 
         levels=c("before", "5s", "10s", "15s", "20s", "25s", "30s", "35s", "40s", "45s", "50s", "55s", "60s"))
tf_suv_mean$genotype <- 
  factor(tf_suv_mean$genotype, 
         levels=c("WT", "NOS"))

ggplot(tf_suv_mean) +
  aes(x = duration, y = Mn_directional_change_rate, fill = genotype) +
  geom_boxplot() +
  scale_fill_hue(direction = 1) +
  theme_minimal()



