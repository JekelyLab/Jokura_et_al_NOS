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


df_suv_NOS_0623_00_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_before_1-5.csv")
df_suv_NOS_0623_00_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_1-5.csv")
df_suv_NOS_0623_00_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_6-10.csv")
df_suv_NOS_0623_00_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_11-15.csv")
df_suv_NOS_0623_00_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_16-20.csv")
df_suv_NOS_0623_00_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_21-25.csv")
df_suv_NOS_0623_00_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_26-30.csv")
df_suv_NOS_0623_00_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_31-35.csv")
df_suv_NOS_0623_00_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_36-40.csv")
df_suv_NOS_0623_00_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_41-45.csv")
df_suv_NOS_0623_00_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_46-50.csv")
df_suv_NOS_0623_00_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_51-55.csv")
df_suv_NOS_0623_00_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_00/NOS_0623_00_sUV_vertical_56-60.csv")

df_suv_NOS_0623_02_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_before_1-5.csv")
df_suv_NOS_0623_02_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_1-5.csv")
df_suv_NOS_0623_02_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_6-10.csv")
df_suv_NOS_0623_02_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_11-15.csv")
df_suv_NOS_0623_02_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_16-20.csv")
df_suv_NOS_0623_02_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_21-25.csv")
df_suv_NOS_0623_02_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_26-30.csv")
df_suv_NOS_0623_02_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_31-35.csv")
df_suv_NOS_0623_02_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_36-40.csv")
df_suv_NOS_0623_02_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_41-45.csv")
df_suv_NOS_0623_02_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_46-50.csv")
df_suv_NOS_0623_02_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_51-55.csv")
df_suv_NOS_0623_02_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0623_02/NOS_0623_02_sUV_vertical_56-60.csv")

df_suv_NOS_0624_00_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_before_1-5.csv")
df_suv_NOS_0624_00_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_1-5.csv")
df_suv_NOS_0624_00_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_6-10.csv")
df_suv_NOS_0624_00_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_11-15.csv")
df_suv_NOS_0624_00_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_16-20.csv")
df_suv_NOS_0624_00_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_21-25.csv")
df_suv_NOS_0624_00_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_26-30.csv")
df_suv_NOS_0624_00_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_31-35.csv")
df_suv_NOS_0624_00_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_36-40.csv")
df_suv_NOS_0624_00_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_41-45.csv")
df_suv_NOS_0624_00_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_46-50.csv")
df_suv_NOS_0624_00_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_51-55.csv")
df_suv_NOS_0624_00_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_00/NOS_0624_00_sUV_vertical_56-60.csv")

df_suv_NOS_0624_01_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_before_1-5.csv")
df_suv_NOS_0624_01_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_1-5.csv")
df_suv_NOS_0624_01_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_6-10.csv")
df_suv_NOS_0624_01_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_11-15.csv")
df_suv_NOS_0624_01_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_16-20.csv")
df_suv_NOS_0624_01_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_21-25.csv")
df_suv_NOS_0624_01_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_26-30.csv")
df_suv_NOS_0624_01_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_31-35.csv")
df_suv_NOS_0624_01_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_36-40.csv")
df_suv_NOS_0624_01_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_41-45.csv")
df_suv_NOS_0624_01_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_46-50.csv")
df_suv_NOS_0624_01_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_51-55.csv")
df_suv_NOS_0624_01_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0624_01/NOS_0624_01_sUV_vertical_56-60.csv")

df_suv_NOS_0627_02_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_before_1-5.csv")
df_suv_NOS_0627_02_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_1-5.csv")
df_suv_NOS_0627_02_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_6-10.csv")
df_suv_NOS_0627_02_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_11-15.csv")
df_suv_NOS_0627_02_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_16-20.csv")
df_suv_NOS_0627_02_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_21-25.csv")
df_suv_NOS_0627_02_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_26-30.csv")
df_suv_NOS_0627_02_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_31-35.csv")
df_suv_NOS_0627_02_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_36-40.csv")
df_suv_NOS_0627_02_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_41-45.csv")
df_suv_NOS_0627_02_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_46-50.csv")
df_suv_NOS_0627_02_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_51-55.csv")
df_suv_NOS_0627_02_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0627_02/NOS_0627_02_sUV_vertical_56-60.csv")

df_suv_NOS_0628_00_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_before_1-5.csv")
df_suv_NOS_0628_00_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_1-5.csv")
df_suv_NOS_0628_00_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_6-10.csv")
df_suv_NOS_0628_00_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_11-15.csv")
df_suv_NOS_0628_00_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_16-20.csv")
df_suv_NOS_0628_00_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_21-25.csv")
df_suv_NOS_0628_00_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_26-30.csv")
df_suv_NOS_0628_00_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_31-35.csv")
df_suv_NOS_0628_00_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_36-40.csv")
df_suv_NOS_0628_00_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_41-45.csv")
df_suv_NOS_0628_00_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_46-50.csv")
df_suv_NOS_0628_00_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_51-55.csv")
df_suv_NOS_0628_00_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_00/NOS_0628_00_sUV_vertical_56-60.csv")

df_suv_NOS_0628_01_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_before_1-5.csv")
df_suv_NOS_0628_01_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_1-5.csv")
df_suv_NOS_0628_01_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_6-10.csv")
df_suv_NOS_0628_01_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_11-15.csv")
df_suv_NOS_0628_01_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_16-20.csv")
df_suv_NOS_0628_01_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_21-25.csv")
df_suv_NOS_0628_01_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_26-30.csv")
df_suv_NOS_0628_01_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_31-35.csv")
df_suv_NOS_0628_01_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_36-40.csv")
df_suv_NOS_0628_01_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_41-45.csv")
df_suv_NOS_0628_01_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_46-50.csv")
df_suv_NOS_0628_01_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_51-55.csv")
df_suv_NOS_0628_01_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0628_01/NOS_0628_01_sUV_vertical_56-60.csv")

df_suv_NOS_0701_06_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_before_1-5.csv")
df_suv_NOS_0701_06_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_1-5.csv")
df_suv_NOS_0701_06_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_6-10.csv")
df_suv_NOS_0701_06_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_11-15.csv")
df_suv_NOS_0701_06_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_16-20.csv")
df_suv_NOS_0701_06_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_21-25.csv")
df_suv_NOS_0701_06_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_26-30.csv")
df_suv_NOS_0701_06_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_31-35.csv")
df_suv_NOS_0701_06_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_36-40.csv")
df_suv_NOS_0701_06_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_41-45.csv")
df_suv_NOS_0701_06_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_46-50.csv")
df_suv_NOS_0701_06_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_51-55.csv")
df_suv_NOS_0701_06_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_06/NOS_0701_06_sUV_vertical_56-60.csv")

df_suv_NOS_0701_07_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_before_1-5.csv")
df_suv_NOS_0701_07_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_1-5.csv")
df_suv_NOS_0701_07_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_6-10.csv")
df_suv_NOS_0701_07_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_11-15.csv")
df_suv_NOS_0701_07_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_16-20.csv")
df_suv_NOS_0701_07_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_21-25.csv")
df_suv_NOS_0701_07_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_26-30.csv")
df_suv_NOS_0701_07_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_31-35.csv")
df_suv_NOS_0701_07_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_36-40.csv")
df_suv_NOS_0701_07_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_41-45.csv")
df_suv_NOS_0701_07_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_46-50.csv")
df_suv_NOS_0701_07_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_51-55.csv")
df_suv_NOS_0701_07_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0701_07/NOS_0701_07_sUV_vertical_56-60.csv")

df_suv_NOS_0703_00_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_before_1-5.csv")
df_suv_NOS_0703_00_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_1-5.csv")
df_suv_NOS_0703_00_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_6-10.csv")
df_suv_NOS_0703_00_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_11-15.csv")
df_suv_NOS_0703_00_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_16-20.csv")
df_suv_NOS_0703_00_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_21-25.csv")
df_suv_NOS_0703_00_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_26-30.csv")
df_suv_NOS_0703_00_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_31-35.csv")
df_suv_NOS_0703_00_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_36-40.csv")
df_suv_NOS_0703_00_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_41-45.csv")
df_suv_NOS_0703_00_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_46-50.csv")
df_suv_NOS_0703_00_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_51-55.csv")
df_suv_NOS_0703_00_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_00/NOS_0703_00_sUV_vertical_56-60.csv")

df_suv_NOS_0703_01_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_before_1-5.csv")
df_suv_NOS_0703_01_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_1-5.csv")
df_suv_NOS_0703_01_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_6-10.csv")
df_suv_NOS_0703_01_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_11-15.csv")
df_suv_NOS_0703_01_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_16-20.csv")
df_suv_NOS_0703_01_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_21-25.csv")
df_suv_NOS_0703_01_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_26-30.csv")
df_suv_NOS_0703_01_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_31-35.csv")
df_suv_NOS_0703_01_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_36-40.csv")
df_suv_NOS_0703_01_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_41-45.csv")
df_suv_NOS_0703_01_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_46-50.csv")
df_suv_NOS_0703_01_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_51-55.csv")
df_suv_NOS_0703_01_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_56-60.csv")

df_suv_NOS_b5 <- rbind(df_suv_NOS_0623_00_b5, df_suv_NOS_0623_02_b5, df_suv_NOS_0624_00_b5, df_suv_NOS_0624_01_b5,
                      df_suv_NOS_0627_02_b5, df_suv_NOS_0628_00_b5, df_suv_NOS_0628_01_b5, df_suv_NOS_0701_06_b5, df_suv_NOS_0701_07_b5,
                      df_suv_NOS_0703_00_b5, df_suv_NOS_0703_01_b5)
df_suv_NOS_5 <- rbind(df_suv_NOS_0623_00_5, df_suv_NOS_0623_02_5, df_suv_NOS_0624_00_5, df_suv_NOS_0624_01_5,
                     df_suv_NOS_0627_02_5, df_suv_NOS_0628_00_5, df_suv_NOS_0628_01_5, df_suv_NOS_0701_06_5, df_suv_NOS_0701_07_5,
                     df_suv_NOS_0703_00_5, df_suv_NOS_0703_01_5)
df_suv_NOS_10 <- rbind(df_suv_NOS_0623_00_10, df_suv_NOS_0623_02_10, df_suv_NOS_0624_00_10, df_suv_NOS_0624_01_10,
                      df_suv_NOS_0627_02_10, df_suv_NOS_0628_00_10, df_suv_NOS_0628_01_10, df_suv_NOS_0701_06_10, df_suv_NOS_0701_07_10,
                      df_suv_NOS_0703_00_10, df_suv_NOS_0703_01_10)
df_suv_NOS_15 <- rbind(df_suv_NOS_0623_00_15, df_suv_NOS_0623_02_15, df_suv_NOS_0624_00_15, df_suv_NOS_0624_01_15,
                      df_suv_NOS_0627_02_15, df_suv_NOS_0628_00_15, df_suv_NOS_0628_01_15, df_suv_NOS_0701_06_15, df_suv_NOS_0701_07_15,
                      df_suv_NOS_0703_00_15, df_suv_NOS_0703_01_15)
df_suv_NOS_20 <- rbind(df_suv_NOS_0623_00_20, df_suv_NOS_0623_02_20, df_suv_NOS_0624_00_20, df_suv_NOS_0624_01_20,
                      df_suv_NOS_0627_02_20, df_suv_NOS_0628_00_20, df_suv_NOS_0628_01_20, df_suv_NOS_0701_06_20, df_suv_NOS_0701_07_20,
                      df_suv_NOS_0703_00_20, df_suv_NOS_0703_01_20)
df_suv_NOS_25 <- rbind(df_suv_NOS_0623_00_25, df_suv_NOS_0623_02_25, df_suv_NOS_0624_00_25, df_suv_NOS_0624_01_25,
                      df_suv_NOS_0627_02_25, df_suv_NOS_0628_00_25, df_suv_NOS_0628_01_25, df_suv_NOS_0701_06_25, df_suv_NOS_0701_07_25,
                      df_suv_NOS_0703_00_25, df_suv_NOS_0703_01_25)
df_suv_NOS_30 <- rbind(df_suv_NOS_0623_00_30, df_suv_NOS_0623_02_30, df_suv_NOS_0624_00_30, df_suv_NOS_0624_01_30,
                      df_suv_NOS_0627_02_30, df_suv_NOS_0628_00_30, df_suv_NOS_0628_01_30, df_suv_NOS_0701_06_30, df_suv_NOS_0701_07_30,
                      df_suv_NOS_0703_00_30, df_suv_NOS_0703_01_30)
df_suv_NOS_35 <- rbind(df_suv_NOS_0623_00_35, df_suv_NOS_0623_02_35, df_suv_NOS_0624_00_35, df_suv_NOS_0624_01_35,
                      df_suv_NOS_0627_02_35, df_suv_NOS_0628_00_35, df_suv_NOS_0628_01_35, df_suv_NOS_0701_06_35, df_suv_NOS_0701_07_35,
                      df_suv_NOS_0703_00_35, df_suv_NOS_0703_01_35)
df_suv_NOS_40 <- rbind(df_suv_NOS_0623_00_40, df_suv_NOS_0623_02_40, df_suv_NOS_0624_00_40, df_suv_NOS_0624_01_40,
                       df_suv_NOS_0627_02_40, df_suv_NOS_0628_00_40, df_suv_NOS_0628_01_40, df_suv_NOS_0701_06_40, df_suv_NOS_0701_07_40,
                       df_suv_NOS_0703_00_40, df_suv_NOS_0703_01_40)
df_suv_NOS_45 <- rbind(df_suv_NOS_0623_00_45, df_suv_NOS_0623_02_45, df_suv_NOS_0624_00_45, df_suv_NOS_0624_01_45,
                       df_suv_NOS_0627_02_45, df_suv_NOS_0628_00_45, df_suv_NOS_0628_01_45, df_suv_NOS_0701_06_45, df_suv_NOS_0701_07_45,
                       df_suv_NOS_0703_00_45, df_suv_NOS_0703_01_45)
df_suv_NOS_50 <- rbind(df_suv_NOS_0623_00_50, df_suv_NOS_0623_02_50, df_suv_NOS_0624_00_50, df_suv_NOS_0624_01_50,
                       df_suv_NOS_0627_02_50, df_suv_NOS_0628_00_50, df_suv_NOS_0628_01_50, df_suv_NOS_0701_06_50, df_suv_NOS_0701_07_50,
                       df_suv_NOS_0703_00_50, df_suv_NOS_0703_01_50)
df_suv_NOS_55 <- rbind(df_suv_NOS_0623_00_55, df_suv_NOS_0623_02_55, df_suv_NOS_0624_00_55, df_suv_NOS_0624_01_55,
                       df_suv_NOS_0627_02_55, df_suv_NOS_0628_00_55, df_suv_NOS_0628_01_55, df_suv_NOS_0701_06_55, df_suv_NOS_0701_07_55,
                       df_suv_NOS_0703_00_55, df_suv_NOS_0703_01_55)
df_suv_NOS_60 <- rbind(df_suv_NOS_0623_00_60, df_suv_NOS_0623_02_60, df_suv_NOS_0624_00_60, df_suv_NOS_0624_01_60,
                       df_suv_NOS_0627_02_60, df_suv_NOS_0628_00_60, df_suv_NOS_0628_01_60, df_suv_NOS_0701_06_60, df_suv_NOS_0701_07_60,
                       df_suv_NOS_0703_00_60, df_suv_NOS_0703_01_60)





#write.csv(df_suv_NOS_b5, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_b5.csv")
#write.csv(df_suv_NOS_5, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_5.csv")
#write.csv(df_suv_NOS_10, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_10.csv")
#write.csv(df_suv_NOS_15, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_15.csv")
#write.csv(df_suv_NOS_20, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_20.csv")
#write.csv(df_suv_NOS_25, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_25.csv")
#write.csv(df_suv_NOS_30, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_30.csv")
#write.csv(df_suv_NOS_35, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_35.csv")
#write.csv(df_suv_NOS_40, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_40.csv")
#write.csv(df_suv_NOS_45, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_45.csv")
#write.csv(df_suv_NOS_50, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_50.csv")
#write.csv(df_suv_NOS_55, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_55.csv")
#write.csv(df_suv_NOS_60, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_60.csv")









rm(list = ls(all.names = TRUE))

df_suv_NOS_b5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_b5.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_5.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_10.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_15.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_20.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_25.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_30.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_35.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_40.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_45.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_50.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_55.csv", col_select = c(nor_x, nor_y))
df_suv_NOS_60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_60.csv", col_select = c(nor_x, nor_y))



df_suv_NOS_nega_b5 <- df_suv_NOS_b5 %>% filter(nor_y < 0)
df_suv_NOS_nega_5 <- df_suv_NOS_5 %>% filter(nor_y < 0)
df_suv_NOS_nega_10 <- df_suv_NOS_10 %>% filter(nor_y < 0)
df_suv_NOS_nega_15 <- df_suv_NOS_15 %>% filter(nor_y < 0)
df_suv_NOS_nega_20 <- df_suv_NOS_20 %>% filter(nor_y < 0)
df_suv_NOS_nega_25 <- df_suv_NOS_25 %>% filter(nor_y < 0)
df_suv_NOS_nega_30 <- df_suv_NOS_30 %>% filter(nor_y < 0)
df_suv_NOS_nega_35 <- df_suv_NOS_35 %>% filter(nor_y < 0)
df_suv_NOS_nega_40 <- df_suv_NOS_40 %>% filter(nor_y < 0)
df_suv_NOS_nega_45 <- df_suv_NOS_45 %>% filter(nor_y < 0)
df_suv_NOS_nega_50 <- df_suv_NOS_50 %>% filter(nor_y < 0)
df_suv_NOS_nega_55 <- df_suv_NOS_55 %>% filter(nor_y < 0)
df_suv_NOS_nega_60 <- df_suv_NOS_60 %>% filter(nor_y < 0)



histo_suv_NOS_b5 <- ggplot(df_suv_NOS_nega_b5) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_5 <- ggplot(df_suv_NOS_nega_5) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_10 <- ggplot(df_suv_NOS_nega_10) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_15 <- ggplot(df_suv_NOS_nega_15) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_20 <- ggplot(df_suv_NOS_nega_20) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_25 <- ggplot(df_suv_NOS_nega_25) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_30 <- ggplot(df_suv_NOS_nega_30) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_35 <- ggplot(df_suv_NOS_nega_35) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_40 <- ggplot(df_suv_NOS_nega_40) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_45 <- ggplot(df_suv_NOS_nega_45) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_50 <- ggplot(df_suv_NOS_nega_50) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_55 <- ggplot(df_suv_NOS_nega_55) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()
histo_suv_NOS_60 <- ggplot(df_suv_NOS_nega_60) +
  aes(x = nor_y) +
  geom_histogram(bins = 50L, fill = "#112446") +
  scale_x_continuous(limits = c(-40, 0)) +
  theme_minimal()

histo_suv_NOS_b5
histo_suv_NOS_5
histo_suv_NOS_10
histo_suv_NOS_15
histo_suv_NOS_20
histo_suv_NOS_25
histo_suv_NOS_30
histo_suv_NOS_35
histo_suv_NOS_40
histo_suv_NOS_45
histo_suv_NOS_50
histo_suv_NOS_55
histo_suv_NOS_60

df_suv_NOS_nega_b5 <- df_suv_NOS_nega_b5 %>% mutate(duration = "before")
df_suv_NOS_nega_5 <- df_suv_NOS_nega_5 %>% mutate(duration = "5s")
df_suv_NOS_nega_10 <- df_suv_NOS_nega_10 %>% mutate(duration = "10s")
df_suv_NOS_nega_15 <- df_suv_NOS_nega_15 %>% mutate(duration = "15s")
df_suv_NOS_nega_20 <- df_suv_NOS_nega_20 %>% mutate(duration = "20s")
df_suv_NOS_nega_25 <- df_suv_NOS_nega_25 %>% mutate(duration = "25s")
df_suv_NOS_nega_30 <- df_suv_NOS_nega_30 %>% mutate(duration = "30s")
df_suv_NOS_nega_35 <- df_suv_NOS_nega_35 %>% mutate(duration = "35s")
df_suv_NOS_nega_40 <- df_suv_NOS_nega_40 %>% mutate(duration = "40s")
df_suv_NOS_nega_45 <- df_suv_NOS_nega_45 %>% mutate(duration = "45s")
df_suv_NOS_nega_50 <- df_suv_NOS_nega_50 %>% mutate(duration = "50s")
df_suv_NOS_nega_55 <- df_suv_NOS_nega_55 %>% mutate(duration = "55s")
df_suv_NOS_nega_60 <- df_suv_NOS_nega_60 %>% mutate(duration = "60s")


df_suv_NOS_nega <- rbind(df_suv_NOS_nega_b5,df_suv_NOS_nega_5,df_suv_NOS_nega_10,df_suv_NOS_nega_15, 
                        df_suv_NOS_nega_20,df_suv_NOS_nega_25,df_suv_NOS_nega_30,
                        df_suv_NOS_nega_35,df_suv_NOS_nega_40,df_suv_NOS_nega_45,
                        df_suv_NOS_nega_50,df_suv_NOS_nega_55,df_suv_NOS_nega_60)

df_suv_NOS_nega <- df_suv_NOS_nega %>% mutate(genotype = "NOS")

df_suv_NOS_nega <- select(df_suv_NOS_nega, genotype, duration, nor_x, nor_y)

#write.csv(df_suv_NOS_nega, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_negative.csv")


df_suv_NOS_nega_mean <- cbind(NOS_b5 = mean(df_suv_NOS_nega_b5$nor_y),
                             NOS_5 = mean(df_suv_NOS_nega_5$nor_y),
                             NOS_10 = mean(df_suv_NOS_nega_10$nor_y),
                             NOS_15 = mean(df_suv_NOS_nega_15$nor_y),
                             NOS_20 = mean(df_suv_NOS_nega_20$nor_y),
                             NOS_25 = mean(df_suv_NOS_nega_25$nor_y),
                             NOS_30 = mean(df_suv_NOS_nega_30$nor_y),
                             NOS_35 = mean(df_suv_NOS_nega_35$nor_y),
                             NOS_40 = mean(df_suv_NOS_nega_40$nor_y),
                             NOS_45 = mean(df_suv_NOS_nega_45$nor_y),
                             NOS_50 = mean(df_suv_NOS_nega_50$nor_y),
                             NOS_55 = mean(df_suv_NOS_nega_55$nor_y),
                             NOS_60 = mean(df_suv_NOS_nega_60$nor_y))

#write.csv(df_suv_NOS_nega_mean, "C:/Users/klamd/Documents/Martin behaviour/NOS/sUV_NOS_negative_mean.csv")



