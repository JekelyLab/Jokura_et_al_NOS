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


#1.Import the data
#2d
files_WT_2d <- list.files(
  path = "C:/Users/klamd/Documents/Martin behaviour/sUV_Tracking_2d/WT_2d",
  pattern = "*.csv", 
  full.names = TRUE
)
df_WT_2d <- sapply(files_WT_2d, read_csv, simplify = FALSE)%>% 
  bind_rows()

files_NOS_2d <- list.files(
  path = "C:/Users/klamd/Documents/Martin behaviour/sUV_Tracking_2d/NOS_2d",
  pattern = "*.csv", 
  full.names = TRUE
)
df_NOS_2d <- sapply(files_NOS_2d, read_csv, simplify = FALSE)%>% 
  bind_rows()

#3d
files_WT_3d <- list.files(
  path = "C:/Users/klamd/Documents/Martin behaviour/sUV_Tracking_3d/WT_3d",
  pattern = "*.csv", 
  full.names = TRUE
)
df_WT_3d <- sapply(files_WT_3d, read_csv, simplify = FALSE)%>% 
  bind_rows()

files_NOS_3d <- list.files(
  path = "C:/Users/klamd/Documents/Martin behaviour/sUV_Tracking_3d/NOS_3d",
  pattern = "*.csv", 
  full.names = TRUE
)
df_NOS_3d <- sapply(files_NOS_3d, read_csv, simplify = FALSE)%>% 
  bind_rows()



#2.Convert x- and y-coordinate values to values from the origin.
#2d WT
t <- 600
p <- nrow(df_WT_2d)/t

raw_x <- df_WT_2d$X
df_temp <- data.frame(Raw_x = raw_x)
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df_temp[j, "Raw_x"]-df_temp[a, "Raw_x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

raw_y <- df_WT_2d$Y
df_temp <- data.frame(Raw_y = raw_y)
nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df_temp[j, "Raw_y"]-df_temp[a, "Raw_y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}
df_nor_y$nor_y <- df_nor_y$nor_y*-1

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}

df_WT_2d_nor <- cbind(df_WT_2d, df_nor_x, df_nor_y, df_frame)



#2.Convert x- and y-coordinate values to values from the origin.
#2d NOS
t <- 600
p <- nrow(df_NOS_2d)/t

raw_x <- df_NOS_2d$X
df_temp <- data.frame(Raw_x = raw_x)
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df_temp[j, "Raw_x"]-df_temp[a, "Raw_x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

raw_y <- df_NOS_2d$Y
df_temp <- data.frame(Raw_y = raw_y)
nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df_temp[j, "Raw_y"]-df_temp[a, "Raw_y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}
df_nor_y$nor_y <- df_nor_y$nor_y*-1

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}

df_NOS_2d_nor <- cbind(df_NOS_2d, df_nor_x, df_nor_y, df_frame)




#2.Convert x- and y-coordinate values to values from the origin.
#3d WT
t <- 600
p <- nrow(df_WT_3d)/t

raw_x <- df_WT_3d$X
df_temp <- data.frame(Raw_x = raw_x)
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df_temp[j, "Raw_x"]-df_temp[a, "Raw_x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

raw_y <- df_WT_3d$Y
df_temp <- data.frame(Raw_y = raw_y)
nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df_temp[j, "Raw_y"]-df_temp[a, "Raw_y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}
df_nor_y$nor_y <- df_nor_y$nor_y*-1

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}

df_WT_3d_nor <- cbind(df_WT_3d, df_nor_x, df_nor_y, df_frame)



#2.Convert x- and y-coordinate values to values from the origin.
#3d NOS
t <- 600
p <- nrow(df_NOS_3d)/t

raw_x <- df_NOS_3d$X
df_temp <- data.frame(Raw_x = raw_x)
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df_temp[j, "Raw_x"]-df_temp[a, "Raw_x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

raw_y <- df_NOS_3d$Y
df_temp <- data.frame(Raw_y = raw_y)
nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df_temp[j, "Raw_y"]-df_temp[a, "Raw_y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}
df_nor_y$nor_y <- df_nor_y$nor_y*-1

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}

df_NOS_3d_nor <- cbind(df_NOS_3d, df_nor_x, df_nor_y, df_frame)



#3. Calculate their distances
#2d
dist_WT_2d <- data.frame()
p <- nrow(df_WT_2d_nor)
for (j in 1:p){
  b <- sqrt((df_WT_2d_nor[j+1,"X"] - df_WT_2d_nor[j,"X"])^2 + (df_WT_2d_nor[j+1,"Y"] - df_WT_2d_nor[j,"Y"])^2)
  dist_WT_2d <- rbind(dist_WT_2d, b)
}
colnames(dist_WT_2d) <- c("distance")
df_WT_2d_nor <- cbind(df_WT_2d_nor, dist_WT_2d)

dist_NOS_2d <- data.frame()
p <- nrow(df_NOS_2d_nor)
for (i in 1:p){
  d <- sqrt((df_NOS_2d_nor[i+1,"X"] - df_NOS_2d_nor[i,"X"])^2 + (df_NOS_2d_nor[i+1,"Y"] - df_NOS_2d_nor[i,"Y"])^2)
  dist_NOS_2d <- rbind(dist_NOS_2d, d)
}
colnames(dist_NOS_2d) <- c("distance")
df_NOS_2d_nor <- cbind(df_NOS_2d_nor, dist_NOS_2d)

df_2d_nor <- rbind(df_WT_2d_nor, df_NOS_2d_nor)

df_NOS_allele_2d_nor <- split(df_NOS_2d_nor, df_NOS_2d_nor$Genotype)
df_NOS11x11_2d_nor <- df_NOS_allele_2d_nor$NOS11x11
df_NOS23x23_2d_nor <- df_NOS_allele_2d_nor$NOS23x23
df_NOS11x23_2d_nor <- df_NOS_allele_2d_nor$NOS11x23




#3. Calculate their distances
#3d
dist_WT_3d <- data.frame()
p <- nrow(df_WT_3d_nor)
for (j in 1:p){
  b <- sqrt((df_WT_3d_nor[j+1,"X"] - df_WT_3d_nor[j,"X"])^2 + (df_WT_3d_nor[j+1,"Y"] - df_WT_3d_nor[j,"Y"])^2)
  dist_WT_3d <- rbind(dist_WT_3d, b)
}
colnames(dist_WT_3d) <- c("distance")
df_WT_3d_nor <- cbind(df_WT_3d_nor, dist_WT_3d)

dist_NOS_3d <- data.frame()
p <- nrow(df_NOS_3d_nor)
for (i in 1:p){
  d <- sqrt((df_NOS_3d_nor[i+1,"X"] - df_NOS_3d_nor[i,"X"])^2 + (df_NOS_3d_nor[i+1,"Y"] - df_NOS_3d_nor[i,"Y"])^2)
  dist_NOS_3d <- rbind(dist_NOS_3d, d)
}
colnames(dist_NOS_3d) <- c("distance")
df_NOS_3d_nor <- cbind(df_NOS_3d_nor, dist_NOS_3d)

df_3d_nor <- rbind(df_WT_3d_nor, df_NOS_3d_nor)

df_NOS_allele_3d_nor <- split(df_NOS_3d_nor, df_NOS_3d_nor$Genotype)
df_NOS11x11_3d_nor <- df_NOS_allele_3d_nor$NOS11x11
df_NOS23x23_3d_nor <- df_NOS_allele_3d_nor$NOS23x23
df_NOS11x23_3d_nor <- df_NOS_allele_3d_nor$NOS11x23


#write.csv(df_2d_nor, "C:/Users/klamd/Documents/R/Jokura_et_al_NOS/data/221011_sUV_tracking/sUV_tracking_2d.csv")
#write.csv(df_3d_nor, "C:/Users/klamd/Documents/R/Jokura_et_al_NOS/data/221011_sUV_tracking/sUV_tracking_3d.csv")



#4. Calculate mean vertical position & travel distance
df_mean_base <- read_csv("~/Martin behaviour/df_mean_base.csv")
df_WT_2d_mean <- data.frame(Genotype = df_mean_base$Genotype_WT,
                            Frame = df_mean_base$Frame,
                            Condition = df_mean_base$Condition,
                            Mean_x = tapply(df_WT_2d_nor$nor_x, df_WT_2d_nor$fra_num, mean),
                            Mean_y = tapply(df_WT_2d_nor$nor_y, df_WT_2d_nor$fra_num, mean),
                            Mean_distance = tapply(df_WT_2d_nor$distance, df_WT_2d_nor$fra_num, mean),
                            number = tapply(df_WT_2d_nor$distance, df_WT_2d_nor$fra_num, length))
df_NOS11x11_2d_mean <- data.frame(Genotype = df_mean_base$Genotype_NOS11x11,
                            Frame = df_mean_base$Frame,
                            Condition = df_mean_base$Condition,
                            Mean_x = tapply(df_NOS11x11_2d_nor$nor_x, df_NOS11x11_2d_nor$fra_num, mean),
                            Mean_y = tapply(df_NOS11x11_2d_nor$nor_y, df_NOS11x11_2d_nor$fra_num, mean),
                            Mean_distance = tapply(df_NOS11x11_2d_nor$distance, df_NOS11x11_2d_nor$fra_num, mean),
                            number = tapply(df_NOS11x11_2d_nor$distance, df_NOS11x11_2d_nor$fra_num, length))
df_NOS23x23_2d_mean <- data.frame(Genotype = df_mean_base$Genotype_NOS23x23,
                            Frame = df_mean_base$Frame,
                            Condition = df_mean_base$Condition,
                            Mean_x = tapply(df_NOS23x23_2d_nor$nor_x, df_NOS23x23_2d_nor$fra_num, mean),
                            Mean_y = tapply(df_NOS23x23_2d_nor$nor_y, df_NOS23x23_2d_nor$fra_num, mean),
                            Mean_distance = tapply(df_NOS23x23_2d_nor$distance, df_NOS23x23_2d_nor$fra_num, mean),
                            number = tapply(df_NOS23x23_2d_nor$distance, df_NOS23x23_2d_nor$fra_num, length))
df_NOS11x23_2d_mean <- data.frame(Genotype = df_mean_base$Genotype_NOS11x23,
                            Frame = df_mean_base$Frame,
                            Condition = df_mean_base$Condition,
                            Mean_x = tapply(df_NOS11x23_2d_nor$nor_x, df_NOS11x23_2d_nor$fra_num, mean),
                            Mean_y = tapply(df_NOS11x23_2d_nor$nor_y, df_NOS11x23_2d_nor$fra_num, mean),
                            Mean_distance = tapply(df_NOS11x23_2d_nor$distance, df_NOS11x23_2d_nor$fra_num, mean),
                            number = tapply(df_NOS11x23_2d_nor$distance, df_NOS11x23_2d_nor$fra_num, length))
df_WT_3d_mean <- data.frame(Genotype = df_mean_base$Genotype_WT,
                            Frame = df_mean_base$Frame,
                            Condition = df_mean_base$Condition,
                            Mean_x = tapply(df_WT_3d_nor$nor_x, df_WT_3d_nor$fra_num, mean),
                            Mean_y = tapply(df_WT_3d_nor$nor_y, df_WT_3d_nor$fra_num, mean),
                            Mean_distance = tapply(df_WT_3d_nor$distance, df_WT_3d_nor$fra_num, mean),
                            number = tapply(df_WT_3d_nor$distance, df_WT_3d_nor$fra_num, length))
df_NOS11x11_3d_mean <- data.frame(Genotype = df_mean_base$Genotype_NOS11x11,
                                  Frame = df_mean_base$Frame,
                                  Condition = df_mean_base$Condition,
                                  Mean_x = tapply(df_NOS11x11_3d_nor$nor_x, df_NOS11x11_3d_nor$fra_num, mean),
                                  Mean_y = tapply(df_NOS11x11_3d_nor$nor_y, df_NOS11x11_3d_nor$fra_num, mean),
                                  Mean_distance = tapply(df_NOS11x11_3d_nor$distance, df_NOS11x11_3d_nor$fra_num, mean),
                                  number = tapply(df_NOS11x11_3d_nor$distance, df_NOS11x11_3d_nor$fra_num, length))
df_NOS23x23_3d_mean <- data.frame(Genotype = df_mean_base$Genotype_NOS23x23,
                                  Frame = df_mean_base$Frame,
                                  Condition = df_mean_base$Condition,
                                  Mean_x = tapply(df_NOS23x23_3d_nor$nor_x, df_NOS23x23_3d_nor$fra_num, mean),
                                  Mean_y = tapply(df_NOS23x23_3d_nor$nor_y, df_NOS23x23_3d_nor$fra_num, mean),
                                  Mean_distance = tapply(df_NOS23x23_3d_nor$distance, df_NOS23x23_3d_nor$fra_num, mean),
                                  number = tapply(df_NOS23x23_3d_nor$distance, df_NOS23x23_3d_nor$fra_num, length))
df_NOS11x23_3d_mean <- data.frame(Genotype = df_mean_base$Genotype_NOS11x23,
                                  Frame = df_mean_base$Frame,
                                  Condition = df_mean_base$Condition,
                                  Mean_x = tapply(df_NOS11x23_3d_nor$nor_x, df_NOS11x23_3d_nor$fra_num, mean),
                                  Mean_y = tapply(df_NOS11x23_3d_nor$nor_y, df_NOS11x23_3d_nor$fra_num, mean),
                                  Mean_distance = tapply(df_NOS11x23_3d_nor$distance, df_NOS11x23_3d_nor$fra_num, mean),
                                  number = tapply(df_NOS11x23_3d_nor$distance, df_NOS11x23_3d_nor$fra_num, length))

df_2d_mean <- rbind(df_WT_2d_mean, df_NOS11x11_2d_mean, df_NOS23x23_2d_mean, df_NOS11x23_2d_mean)
df_3d_mean <- rbind(df_WT_3d_mean, df_NOS11x11_3d_mean, df_NOS23x23_3d_mean, df_NOS11x23_3d_mean)




# plot Tracking ---------------------------------------------------------------------

df_2d_nor$Genotype = factor(df_2d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))
df_3d_nor$Genotype = factor(df_3d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))

ggplot(df_2d_nor) +
  aes(
    x = nor_x,
    y = nor_y,
    colour = fra_num,
    shape = Condition
  ) +
  geom_point(size = 0.5) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  theme_minimal() +
  coord_fixed()+
  facet_grid(vars(), vars(Genotype))


ggplot(df_3d_nor) +
  aes(
    x = nor_x,
    y = nor_y,
    colour = fra_num,
    shape = Condition
  ) +
  geom_point(size = 0.5) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  theme_minimal() +
  coord_fixed()+
  facet_grid(vars(), vars(Genotype))


# plot the tracking mean vertical position-----------------------------------------------------
ggplot(df_2d_nor) +
  annotate("rect", xmin=151, xmax=600, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = fra_num, y = nor_y, colour = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
  scale_color_manual(
    values = c(WT = "#FF009E", 
               NOS11x11 = "#0042FF",
               NOS23x23 = "#0094FF",
               NOS11x23 = "#00CBFF")) +
  theme_minimal()

ggplot(df_3d_nor) +
  annotate("rect", xmin=151, xmax=600, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = fra_num, y = nor_y, colour = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
  scale_color_manual(
    values = c(WT = "#FF009E", 
               NOS11x11 = "#0042FF",
               NOS23x23 = "#0094FF",
               NOS11x23 = "#00CBFF")) +
  theme_minimal()



# plot the tracking mean distance (speed) data-----------------------------------------------------
df_2d_nor %>%
  filter(fra_num >= 0L & fra_num <= 599L) %>%
  ggplot() +
  annotate("rect", xmin=151, xmax=600, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = fra_num, y = distance, colour = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.9) +
  scale_color_manual(
    values = c(WT = "#FF009E", 
               NOS11x11 = "#0042FF",
               NOS23x23 = "#0094FF",
               NOS11x23 = "#00CBFF")) +
  theme_minimal()


df_3d_nor %>%
  filter(fra_num >= 0L & fra_num <= 599L) %>%
  ggplot() +
  annotate("rect", xmin=151, xmax=600, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = fra_num, y = distance, colour = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.9) +
  scale_color_manual(
    values = c(WT = "#FF009E", 
               NOS11x11 = "#0042FF",
               NOS23x23 = "#0094FF",
               NOS11x23 = "#00CBFF")) +
  theme_minimal()
