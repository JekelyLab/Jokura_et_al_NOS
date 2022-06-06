rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memrory and report the memory usage.
Sys.setenv('R_MAX_VSIZE'=800000000)


# load nat and all associated packages, incl catmaid
{
  library(magick)
  library(cowplot)
  library(png)
  library(tidyverse)
  library(leiden)
  library(RColorBrewer)
  library(igraph)
  library(networkD3)
  library(visNetwork)
  library(webshot2)
  library(patchwork)
  library(rgexf)
  library(tidygraph)
  library(scales)
}



#save session info and Rstudio version info for reproducibility
writeLines(capture.output(sessionInfo()), "code/sessionInfo.txt")
writeLines(capture.output(rstudioapi::versionInfo()), "code/versionInfo.txt")


#From Color Universal Design (CUD): https://jfly.uni-koeln.de/color/
Okabe_Ito <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", 
               "#CC79A7", "#000000")
########################## SHOW as multiple PIE Charts ###################
pie(rep(1,8), col=Okabe_Ito, Okabe_Ito, main='Okabe Ito')
blues <- brewer.pal(9, 'Blues')
bluepurple <- brewer.pal(9, 'BuPu')
oranges <- brewer.pal(9, 'YlOrRd')

