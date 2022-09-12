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




df_suv_WT_0701_08_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_08_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_08/WT_0701_08_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0701_09_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0701_09_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0701_09/WT_0701_09_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0702_03_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_03_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_03/WT_0702_03_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0702_04_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_04_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_04/WT_0702_04_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0702_05_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0702_05_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0702_05/WT_0702_05_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0703_07_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0703_07_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0703_07/WT_0703_07_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0704_02_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0704_02_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0704_02/WT_0704_02_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0705_00_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0705_00_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0705_00/WT_0705_00_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))


df_suv_WT_0706_00_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_before_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_1-5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_6-10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_11-15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_16-20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_21-25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_26-30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_31-35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_36-40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_41-45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_46-50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_51-55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_0706_00_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/WT_0706_00/WT_0706_00_sUV_vertical_56-60.csv", col_select = c(nor_x, nor_y))



df_suv_WT_b5 <- rbind(df_suv_WT_0701_08_b5, df_suv_WT_0701_09_b5, df_suv_WT_0702_03_b5, df_suv_WT_0702_04_b5,
                      df_suv_WT_0702_05_b5, df_suv_WT_0703_07_b5, df_suv_WT_0704_02_b5, df_suv_WT_0705_00_b5, df_suv_WT_0706_00_b5)
df_suv_WT_5 <- rbind(df_suv_WT_0701_08_5, df_suv_WT_0701_09_5, df_suv_WT_0702_03_5, df_suv_WT_0702_04_5,
                      df_suv_WT_0702_05_5, df_suv_WT_0703_07_5, df_suv_WT_0704_02_5, df_suv_WT_0705_00_5, df_suv_WT_0706_00_5)
df_suv_WT_10 <- rbind(df_suv_WT_0701_08_10, df_suv_WT_0701_09_10, df_suv_WT_0702_03_10, df_suv_WT_0702_04_10,
                     df_suv_WT_0702_05_10, df_suv_WT_0703_07_10, df_suv_WT_0704_02_10, df_suv_WT_0705_00_10, df_suv_WT_0706_00_10)
df_suv_WT_15 <- rbind(df_suv_WT_0701_08_15, df_suv_WT_0701_09_15, df_suv_WT_0702_03_15, df_suv_WT_0702_04_15,
                     df_suv_WT_0702_05_15, df_suv_WT_0703_07_15, df_suv_WT_0704_02_15, df_suv_WT_0705_00_15, df_suv_WT_0706_00_15)
df_suv_WT_20 <- rbind(df_suv_WT_0701_08_20, df_suv_WT_0701_09_20, df_suv_WT_0702_03_20, df_suv_WT_0702_04_20,
                     df_suv_WT_0702_05_20, df_suv_WT_0703_07_20, df_suv_WT_0704_02_20, df_suv_WT_0705_00_20, df_suv_WT_0706_00_20)
df_suv_WT_25 <- rbind(df_suv_WT_0701_08_25, df_suv_WT_0701_09_25, df_suv_WT_0702_03_25, df_suv_WT_0702_04_25,
                     df_suv_WT_0702_05_25, df_suv_WT_0703_07_25, df_suv_WT_0704_02_25, df_suv_WT_0705_00_25, df_suv_WT_0706_00_25)
df_suv_WT_30 <- rbind(df_suv_WT_0701_08_30, df_suv_WT_0701_09_30, df_suv_WT_0702_03_30, df_suv_WT_0702_04_30,
                     df_suv_WT_0702_05_30, df_suv_WT_0703_07_30, df_suv_WT_0704_02_30, df_suv_WT_0705_00_30, df_suv_WT_0706_00_30)
df_suv_WT_35 <- rbind(df_suv_WT_0701_08_35, df_suv_WT_0701_09_35, df_suv_WT_0702_03_35, df_suv_WT_0702_04_35,
                     df_suv_WT_0702_05_35, df_suv_WT_0703_07_35, df_suv_WT_0704_02_35, df_suv_WT_0705_00_35, df_suv_WT_0706_00_35)
df_suv_WT_40 <- rbind(df_suv_WT_0701_08_40, df_suv_WT_0701_09_40, df_suv_WT_0702_03_40, df_suv_WT_0702_04_40,
                      df_suv_WT_0702_05_40, df_suv_WT_0703_07_40, df_suv_WT_0704_02_40, df_suv_WT_0705_00_40, df_suv_WT_0706_00_40)
df_suv_WT_45 <- rbind(df_suv_WT_0701_08_45, df_suv_WT_0701_09_45, df_suv_WT_0702_03_45, df_suv_WT_0702_04_45,
                      df_suv_WT_0702_05_45, df_suv_WT_0703_07_45, df_suv_WT_0704_02_45, df_suv_WT_0705_00_45, df_suv_WT_0706_00_45)
df_suv_WT_50 <- rbind(df_suv_WT_0701_08_50, df_suv_WT_0701_09_50, df_suv_WT_0702_03_50, df_suv_WT_0702_04_50,
                      df_suv_WT_0702_05_50, df_suv_WT_0703_07_50, df_suv_WT_0704_02_50, df_suv_WT_0705_00_50, df_suv_WT_0706_00_50)
df_suv_WT_55 <- rbind(df_suv_WT_0701_08_55, df_suv_WT_0701_09_55, df_suv_WT_0702_03_55, df_suv_WT_0702_04_55,
                      df_suv_WT_0702_05_55, df_suv_WT_0703_07_55, df_suv_WT_0704_02_55, df_suv_WT_0705_00_55, df_suv_WT_0706_00_55)
df_suv_WT_60 <- rbind(df_suv_WT_0701_08_60, df_suv_WT_0701_09_60, df_suv_WT_0702_03_60, df_suv_WT_0702_04_60,
                      df_suv_WT_0702_05_60, df_suv_WT_0703_07_60, df_suv_WT_0704_02_60, df_suv_WT_0705_00_60, df_suv_WT_0706_00_60)



#write.csv(df_suv_WT_b5, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_b5.csv")
#write.csv(df_suv_WT_5, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_5.csv")
#write.csv(df_suv_WT_10, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_10.csv")
#write.csv(df_suv_WT_15, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_15.csv")
#write.csv(df_suv_WT_20, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_20.csv")
#write.csv(df_suv_WT_25, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_25.csv")
#write.csv(df_suv_WT_30, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_30.csv")
#write.csv(df_suv_WT_35, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_35.csv")
#write.csv(df_suv_WT_40, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_40.csv")
#write.csv(df_suv_WT_45, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_45.csv")
#write.csv(df_suv_WT_50, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_50.csv")
#write.csv(df_suv_WT_55, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_55.csv")
#write.csv(df_suv_WT_60, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_60.csv")


rm(list = ls(all.names = TRUE))

df_suv_WT_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_b5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_5.csv", col_select = c(nor_x, nor_y))
df_suv_WT_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_10.csv", col_select = c(nor_x, nor_y))
df_suv_WT_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_15.csv", col_select = c(nor_x, nor_y))
df_suv_WT_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_20.csv", col_select = c(nor_x, nor_y))
df_suv_WT_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_25.csv", col_select = c(nor_x, nor_y))
df_suv_WT_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_30.csv", col_select = c(nor_x, nor_y))
df_suv_WT_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_35.csv", col_select = c(nor_x, nor_y))
df_suv_WT_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_40.csv", col_select = c(nor_x, nor_y))
df_suv_WT_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_45.csv", col_select = c(nor_x, nor_y))
df_suv_WT_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_50.csv", col_select = c(nor_x, nor_y))
df_suv_WT_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_55.csv", col_select = c(nor_x, nor_y))
df_suv_WT_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_60.csv", col_select = c(nor_x, nor_y))




df_suv_WT_nega_b5 <- df_suv_WT_b5 %>% filter(nor_y < 0)
df_suv_WT_nega_5 <- df_suv_WT_5 %>% filter(nor_y < 0)
df_suv_WT_nega_10 <- df_suv_WT_10 %>% filter(nor_y < 0)
df_suv_WT_nega_15 <- df_suv_WT_15 %>% filter(nor_y < 0)
df_suv_WT_nega_20 <- df_suv_WT_20 %>% filter(nor_y < 0)
df_suv_WT_nega_25 <- df_suv_WT_25 %>% filter(nor_y < 0)
df_suv_WT_nega_30 <- df_suv_WT_30 %>% filter(nor_y < 0)
df_suv_WT_nega_35 <- df_suv_WT_35 %>% filter(nor_y < 0)
df_suv_WT_nega_40 <- df_suv_WT_40 %>% filter(nor_y < 0)
df_suv_WT_nega_45 <- df_suv_WT_45 %>% filter(nor_y < 0)
df_suv_WT_nega_50 <- df_suv_WT_50 %>% filter(nor_y < 0)
df_suv_WT_nega_55 <- df_suv_WT_55 %>% filter(nor_y < 0)
df_suv_WT_nega_60 <- df_suv_WT_60 %>% filter(nor_y < 0)


histo_suv_WT_b5 <- ggplot(df_suv_WT_nega_b5) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_5 <- ggplot(df_suv_WT_nega_5) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_10 <- ggplot(df_suv_WT_nega_10) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_15 <- ggplot(df_suv_WT_nega_15) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_20 <- ggplot(df_suv_WT_nega_20) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_25 <- ggplot(df_suv_WT_nega_25) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_30 <- ggplot(df_suv_WT_nega_30) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_35 <- ggplot(df_suv_WT_nega_35) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_40 <- ggplot(df_suv_WT_nega_40) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_45 <- ggplot(df_suv_WT_nega_45) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_50 <- ggplot(df_suv_WT_nega_50) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_55 <- ggplot(df_suv_WT_nega_55) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()
histo_suv_WT_60 <- ggplot(df_suv_WT_nega_60) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-50, 0)) +
  theme_minimal()

histo_suv_WT_b5
histo_suv_WT_5
histo_suv_WT_10
histo_suv_WT_15
histo_suv_WT_20
histo_suv_WT_25
histo_suv_WT_30
histo_suv_WT_35
histo_suv_WT_40
histo_suv_WT_45
histo_suv_WT_50
histo_suv_WT_55
histo_suv_WT_60




df_suv_WT_nega_b5 <- df_suv_WT_nega_b5 %>% mutate(duration = "before")
df_suv_WT_nega_5 <- df_suv_WT_nega_5 %>% mutate(duration = "5s")
df_suv_WT_nega_10 <- df_suv_WT_nega_10 %>% mutate(duration = "10s")
df_suv_WT_nega_15 <- df_suv_WT_nega_15 %>% mutate(duration = "15s")
df_suv_WT_nega_20 <- df_suv_WT_nega_20 %>% mutate(duration = "20s")
df_suv_WT_nega_25 <- df_suv_WT_nega_25 %>% mutate(duration = "25s")
df_suv_WT_nega_30 <- df_suv_WT_nega_30 %>% mutate(duration = "30s")
df_suv_WT_nega_35 <- df_suv_WT_nega_35 %>% mutate(duration = "35s")
df_suv_WT_nega_40 <- df_suv_WT_nega_40 %>% mutate(duration = "40s")
df_suv_WT_nega_45 <- df_suv_WT_nega_45 %>% mutate(duration = "45s")
df_suv_WT_nega_50 <- df_suv_WT_nega_50 %>% mutate(duration = "50s")
df_suv_WT_nega_55 <- df_suv_WT_nega_55 %>% mutate(duration = "55s")
df_suv_WT_nega_60 <- df_suv_WT_nega_60 %>% mutate(duration = "60s")





df_suv_WT_nega <- rbind(df_suv_WT_nega_b5,df_suv_WT_nega_5,df_suv_WT_nega_10,df_suv_WT_nega_15, 
                        df_suv_WT_nega_20,df_suv_WT_nega_25,df_suv_WT_nega_30,
                        df_suv_WT_nega_35,df_suv_WT_nega_40,df_suv_WT_nega_45,
                        df_suv_WT_nega_50,df_suv_WT_nega_55,df_suv_WT_nega_60)

df_suv_WT_nega <- df_suv_WT_nega %>% mutate(genotype = "WT")

df_suv_WT_nega <- select(df_suv_WT_nega, genotype, duration, nor_x, nor_y)

#write.csv(df_suv_WT_nega, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_negative.csv")

df_suv_WT_nega_mean <- cbind(WT_b5 = mean(df_suv_WT_nega_b5$nor_y),
                             WT_5 = mean(df_suv_WT_nega_5$nor_y),
                             WT_10 = mean(df_suv_WT_nega_10$nor_y),
                             WT_15 = mean(df_suv_WT_nega_15$nor_y),
                             WT_20 = mean(df_suv_WT_nega_20$nor_y),
                             WT_25 = mean(df_suv_WT_nega_25$nor_y),
                             WT_30 = mean(df_suv_WT_nega_30$nor_y),
                             WT_35 = mean(df_suv_WT_nega_35$nor_y),
                             WT_40 = mean(df_suv_WT_nega_40$nor_y),
                             WT_45 = mean(df_suv_WT_nega_45$nor_y),
                             WT_50 = mean(df_suv_WT_nega_50$nor_y),
                             WT_55 = mean(df_suv_WT_nega_55$nor_y),
                             WT_60 = mean(df_suv_WT_nega_60$nor_y))

#write.csv(df_suv_WT_nega_mean, "C:/Users/klamd/Documents/Martin behaviour/WT/sUV_WT_negative_mean.csv")


