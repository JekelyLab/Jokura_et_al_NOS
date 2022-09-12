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

df_suvb5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_before_1-5.csv", skip = 3)
df_suv5 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_1-5.csv", skip = 3)
df_suv10 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_6-10.csv", skip = 3)
df_suv15 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_11-15.csv", skip = 3)
df_suv20 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_16-20.csv", skip = 3)
df_suv25 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_21-25.csv", skip = 3)
df_suv30 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_26-30.csv", skip = 3)
df_suv35 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_31-35.csv", skip = 3)
df_suv40 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_36-40.csv", skip = 3)
df_suv45 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_41-45.csv", skip = 3)
df_suv50 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_46-50.csv", skip = 3)
df_suv55 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_51-55.csv", skip = 3)
df_suv60 <- read_csv("C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/raw data/NOS_0703_01_sUV_56-60.csv", skip = 3)










#Convert x- and y-coordinates to coordinates from the origin.
#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suvb5 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suvb5[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
    for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
    }
  df_frame <- data.frame(fra_num)
}

df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)

#dot_plot <- ggplot(df_nor) +
#  aes(x = nor_x, y = nor_y, colour = fra_num) +
#  geom_point(shape = "circle", size = 0.5) +
#  scale_color_gradient() +
#  theme_minimal() +
#  theme(legend.position = "none")+
#  xlim(-t/1.5, t/1.5) +
#  ylim(-t/1.5, t/1.5)

#ggsave("NOS_0703_01_sUV_26-30.png", plot = dot_plot, device = png, 
#       path = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/",
#        width = 2048, height = 2048, units = "px", dpi = 300, bg = "white")

df_vertical_b5 <- filter(df_nor, fra_num == "75")

#write.csv(df_vertical_b5, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_before_1-5.csv")












#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv5 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv5[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_5 <- filter(df_nor, fra_num == "75")
#write.csv(df_vertical_5, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_1-5.csv")






#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv10 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv10[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_10 <- filter(df_nor, fra_num == "75")
#write.csv(df_vertical_10, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_6-10.csv")










#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv15 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv15[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_15 <- filter(df_nor, fra_num == "75")
#write.csv(df_vertical_15, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_11-15.csv")






#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv20 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv20[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_20 <- filter(df_nor, fra_num == "75")
#write.csv(df_vertical_20, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_16-20.csv")






#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv25 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv25[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_25 <- filter(df_nor, fra_num == "75")
#write.csv(df_vertical_25, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_21-25.csv")








#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv30 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv30[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_30 <- filter(df_nor, fra_num == "75")
#write.csv(df_vertical_30, 
#          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_26-30.csv")














#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv35 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv35[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_35 <- filter(df_nor, fra_num == "75")
write.csv(df_vertical_35, 
          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_31-35.csv")



















#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv40 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv40[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_40 <- filter(df_nor, fra_num == "75")
write.csv(df_vertical_40, 
          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_36-40.csv")













#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv45 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv45[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_45 <- filter(df_nor, fra_num == "75")
write.csv(df_vertical_45, 
          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_41-45.csv")















#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv50 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv50[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_50 <- filter(df_nor, fra_num == "75")
write.csv(df_vertical_50, 
          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_46-50.csv")




















#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv55 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv55[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_55 <- filter(df_nor, fra_num == "75")
write.csv(df_vertical_55, 
          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_51-55.csv")














#1.Only the x- and y-coordinates are extracted.
df_1 <- df_suv60 %>% 
  select(ID = '...3', x = '(pixel)...5', frame = '(frame)')
dfY <- df_suv60[, '(pixel)...6']*-1
names(dfY)[1] <- "y"
df2 <- cbind(df_1, dfY)

#2.Convert x- and y-coordinate values to values from the origin.
df3 <- df2 %>% arrange(ID, frame)
t <- 75
p <- nrow(df3)/t
nor_x <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    x <- df3[j, "x"]-df3[a, "x"]
    nor_x <- c(nor_x, c(x))
  }
  df_nor_x <- data.frame(nor_x)
}

nor_y <- c()
for(i in 1:p){
  a <- t*i-(t-1)
  b <- t*i
  for (j in a:b){
    y <- df3[j, "y"]-df3[a, "y"]
    nor_y <- c(nor_y, c(y))
  }
  df_nor_y <- data.frame(nor_y)
}

fra_num <- c()
for(i in 1:p){
  for (j in 1:t){
    fra_num <- c(fra_num, c(j))
  }
  df_frame <- data.frame(fra_num)
}
df_nor <- cbind(ID = df_1$ID, df_nor_x, df_nor_y, df_frame)
df_vertical_60 <- filter(df_nor, fra_num == "75")
write.csv(df_vertical_60, 
          file = "C:/Users/klamd/Documents/Martin behaviour/NOS/NOS_0703_01/NOS_0703_01_sUV_vertical_56-60.csv")
