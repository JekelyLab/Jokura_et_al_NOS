
#Code to assemble Fig7 of the Jokura et al Platynereis NOS paper
#2023 December - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

folder_path <- "data/20231223_405_stimulation/csv"
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)
remove_common_part <- function(file_path) {
  common_part <- "ROI60_PD1.54_scan471.86ms_pin200.7_"
  file_path <- gsub(common_part, "", file_path)
  return(file_path)
}
combined_df_1 <- map_dfr(csv_files, ~{
  removed_part <- remove_common_part(.x)
  read_csv(.x) %>% mutate(removed_part = removed_part)
})

folder_path <- "data/20231224_405_stimulation/csv"
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)
remove_common_part <- function(file_path) {
  common_part <- "ROI60_PD1.54_scan471.86ms_pin200.7_"
  file_path <- gsub(common_part, "", file_path)
  return(file_path)
}
combined_df_2 <- map_dfr(csv_files, ~{
  removed_part <- remove_common_part(.x)
  read_csv(.x) %>% mutate(removed_part = removed_part)
})

folder_path <- "data/20231230_405_stimulation/csv"
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)
remove_common_part <- function(file_path) {
  common_part <- "ROI60_PD1.54_scan471.86ms_pin200.7_"
  file_path <- gsub(common_part, "", file_path)
  return(file_path)
}
combined_df_3 <- map_dfr(csv_files, ~{
  removed_part <- remove_common_part(.x)
  read_csv(.x) %>% mutate(removed_part = removed_part)
})


combined_df <- rbind(combined_df_1, combined_df_2, combined_df_3)
combined_df <- combined_df %>% 
  separate(removed_part, into = c("data","date","UV","Stim",
                                  "CSV_1","ID","ID_num","power",
                                  "time","position","CSV_2"), sep = "[_/.]")

combined_df <- combined_df %>% 
  rename(frame = ...1, intensity = Mean1)
#combined_df <- combined_df %>% 
#  select(-data, -UV, -Stim, -CSV_1, -CSV_2)

columns_to_remove <- c("data","UV","Stim","CSV_1","CSV_2")
combined_df <- combined_df[, !names(combined_df) %in% columns_to_remove]

# data extraction ---------------------------------------------------------------

each_intensity <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("K"),
         ID_num %in% c(2),
         power %in% c("power3"),
         time %in% c("stimu10sec"),
         position %in% c(2),
         frame >= 125,
         frame <= 248) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )

df_p3_20s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("G"),
         ID_num %in% c(1),
         power %in% c("power3"),
         time %in% c("stimu20sec"),
         position %in% c(1),
         frame >= 150,
         frame <= 250) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
df_p3_20s$base[is.na(df_p3_20s$base)] <- 93.505
each_intensity <- rbind(each_intensity, df_p3_20s)

df_p3_30s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("H"),
         ID_num %in% c(2),
         power %in% c("power3"),
         time %in% c("stimu30sec"),
         position %in% c(2),
         frame >= 130,
         frame <= 330) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
df_p3_30s$base[is.na(df_p3_30s$base)] <- 95.509
each_intensity <- rbind(each_intensity, df_p3_30s)

df_p3_40s <- combined_df %>%
  filter(date %in% c(20231230),
         ID %in% c("A"),
         ID_num %in% c(1),
         power %in% c("power3"),
         time %in% c("stimu40sec"),
         position %in% c(2),
         frame >= 129,
         frame <= 350) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p3_40s)

df_p3_50s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("J"),
         ID_num %in% c(2),
         power %in% c("power3"),
         time %in% c("stimu50sec"),
         position %in% c(2),
         frame >= 120,
         frame <= 450) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p3_50s)

df_p6_10s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("D"),
         ID_num %in% c(2),
         power %in% c("power6"),
         time %in% c("stimu10sec"),
         position %in% c(1),
         frame >= 100,
         frame <= 350) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p6_10s)

df_p6_20s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("C"),
         ID_num %in% c(1),
         power %in% c("power6"),
         time %in% c("stimu20sec"),
         position %in% c(1),
         frame >= 135,
         frame <= 215) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
df_p6_20s$base[is.na(df_p6_20s$base)] <- 67.624
each_intensity <- rbind(each_intensity, df_p6_20s)

df_p6_30s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("D"),
         ID_num %in% c(1),
         power %in% c("power6"),
         time %in% c("stimu30sec"),
         position %in% c(1),
         frame >= 120,
         frame <= 250) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p6_30s)

df_p6_40s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("G"),
         ID_num %in% c(2),
         power %in% c("power6"),
         time %in% c("stimu40sec"),
         position %in% c(1),
         frame >= 140,
         frame <= 300) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
df_p6_40s$base[is.na(df_p6_40s$base)] <- 99.546
each_intensity <- rbind(each_intensity, df_p6_40s)

df_p6_50s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("B"),
         ID_num %in% c(2),
         power %in% c("power6"),
         time %in% c("stimu50sec"),
         position %in% c(2),
         frame >= 150,
         frame <= 400) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
df_p6_50s$base[is.na(df_p6_50s$base)] <- 83.092
each_intensity <- rbind(each_intensity, df_p6_50s)

df_p9_10s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("D"),
         ID_num %in% c(1),
         power %in% c("power9"),
         time %in% c("stimu10sec"),
         position %in% c(1),
         frame >= 125,
         frame <= 250) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p9_10s)

df_p9_20s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("J"),
         ID_num %in% c(2),
         power %in% c("power9"),
         time %in% c("stimu20sec"),
         position %in% c(1),
         frame >= 140,
         frame <= 220) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
df_p9_20s$base[is.na(df_p9_20s$base)] <- 112.505
each_intensity <- rbind(each_intensity, df_p9_20s)

df_p9_30s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("I"),
         ID_num %in% c(2),
         power %in% c("power9"),
         time %in% c("stimu30sec"),
         position %in% c(1),
         frame >= 125,
         frame <= 250) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p9_30s)

df_p9_40s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("K"),
         ID_num %in% c(1),
         power %in% c("power9"),
         time %in% c("stimu40sec"),
         position %in% c(2),
         frame >= 100,
         frame <= 300) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p9_40s)

df_p9_50s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("K"),
         ID_num %in% c(1),
         power %in% c("power9"),
         time %in% c("stimu50sec"),
         position %in% c(4),
         frame >= 120,
         frame <= 400) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p9_50s)

df_p12_10s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("E"),
         ID_num %in% c(1),
         power %in% c("power12"),
         time %in% c("stimu10sec"),
         position %in% c(2),
         frame >= 120,
         frame <= 195) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p12_10s)

df_p12_20s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("G"),
         ID_num %in% c(3),
         power %in% c("power12"),
         time %in% c("stimu20sec"),
         position %in% c(1),
         frame >= 120,
         frame <= 220) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p12_20s)

df_p12_30s <- combined_df %>%
  filter(date %in% c(20231223),
         ID %in% c("L"),
         ID_num %in% c(1),
         power %in% c("power12"),
         time %in% c("stimu30sec"),
         position %in% c(2),
         frame >= 130,
         frame <= 190) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p12_30s)

df_p12_40s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("L"),
         ID_num %in% c(2),
         power %in% c("power12"),
         time %in% c("stimu40sec"),
         position %in% c(1),
         frame >= 120,
         frame <= 250) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p12_40s)

df_p12_50s <- combined_df %>%
  filter(date %in% c(20231224),
         ID %in% c("M"),
         ID_num %in% c(2),
         power %in% c("power12"),
         time %in% c("stimu50sec"),
         position %in% c(1),
         frame >= 120,
         frame <= 200) %>% 
  summarise(
    power = first(power),
    time = first(time),
    base = ifelse(any(frame == 130), first(intensity[frame == 130]), NA),
    min_intensity = min(intensity),
    max_intensity = max(intensity)
  )
each_intensity <- rbind(each_intensity, df_p12_50s)

# data normalization---------------------------------------------------------

each_intensity <- each_intensity %>% 
  mutate(from_base = max_intensity - base)

each_intensity <- each_intensity %>% 
  mutate(normalized = from_base / base)

# plot the Magnitude real cPRC---------------------------------------------

each_intensity$power = factor(each_intensity$power, 
                              levels=c("power3", "power6", "power9", "power12"))

each_intensity$time = factor(each_intensity$time, 
                             levels=c("stimu10sec", "stimu20sec", "stimu30sec", "stimu40sec", "stimu50sec"))

each_intensity %>% 
  ggplot() + 
  aes(x = power, y = time, size = normalized, fill = normalized) +
  geom_point(shape = 21, color = "black") +
  scale_size(range = c(6, 21)) +
  scale_fill_gradient2(low = "dodgerblue4", mid = "white", high = "firebrick4", midpoint = 0.75) +  
  labs(x = "laser power [%]", y = "duration [sec]", fill = expression(Delta * F/F[0])) +
  scale_x_discrete(labels = c("power3" = "25", "power6" = "50", "power9" = "75", "power12" = "100")) +
  scale_y_discrete(labels = c("stimu10sec" = "10", "stimu20sec" = "20", "stimu30sec" = "30", "stimu40sec" = "40", "stimu50sec" = "50")) +
  theme_minimal() +
  guides(size = "none")

# save to source data-------------------------------------------------------

each_intensity %>%
  write_csv("source_data/Figure7_source_data1.csv")

# save plot ---------------------------------------------------------------

ggsave("pictures/Magnitude_real_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1300, height = 1200, bg='white')  


# assemble figure ---------------------------------------------------------

panel_model <- ggdraw() + draw_image(readPNG("pictures/Magnitude_model_cPRC.png"))
panel_real <- ggdraw() + draw_image(readPNG("pictures/Magnitude_real_cPRC.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes

layout <- "
A#B
"

Fig7 <- panel_model + panel_real +
  patchwork::plot_layout(design = layout, 
                         widths = c(1, 0.05, 0.8)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 20, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig7.png", limitsize = FALSE, 
       units = c("px"), Fig7, width = 3750, height = 1500, bg='white')  


ggsave("Manuscript/figures/Fig7.pdf", limitsize = FALSE, 
       units = c("px"), Fig7, width = 3750, height = 1500) 






