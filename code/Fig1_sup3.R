#Code to assemble Fig1 figure suppl 3 of the Jokura et al Platynereis NOS paper
#2023 - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")


# load and plot neurons ---------------------------------------------------

cPRC = nlapply(read.neurons.catmaid("^celltype5$", pid=11),
               function(x) smooth_neuron(x, sigma=20))
INNOS = nlapply(read.neurons.catmaid("^celltype7$", pid=11),
                function(x) smooth_neuron(x, sigma=2000))
INRGW = nlapply(read.neurons.catmaid("^celltype6$", pid=11),
                function(x) smooth_neuron(x, sigma=2000))
Ser_h1 = nlapply(read.neurons.catmaid("^celltype8$", pid=11),
                 function(x) smooth_neuron(x, sigma=6000))
NS = nlapply(read.neurons.catmaid("^neurosecretory_plexus$", pid=11),
                            function(x) smooth_neuron(x, sigma=6000))
MC = nlapply(read.neurons.catmaid("^celltype9$", pid=11),
             function(x) smooth_neuron(x, sigma=6000))
prototroch = nlapply(read.neurons.catmaid("^celltype_non_neuronal3$", pid=11),
                     function(x) smooth_neuron(x, sigma=6000))


# extract connectors to be able to plot them by unique colours
INNOS_conn <- connectors(INNOS)
presyn_INNOS <- INNOS_conn[INNOS_conn$prepost == 0, ]
postsyn_INNOS <- INNOS_conn[INNOS_conn$prepost == 1, ]

# we can also subset with the subset shorthand function
cPRC_conn <- connectors(cPRC)
presyn_cPRC <- subset(cPRC_conn, prepost == 0)
postsyn_cPRC <- subset(cPRC_conn, prepost == 1)
INRGW_conn <- connectors(INRGW)
presyn_INRGW <- subset(INRGW_conn, prepost == 0)
postsyn_INRGW <- subset(INRGW_conn, prepost == 1)

plot_background()
clear3d()
# plot only the presyn connectors
#for reference, plot neuropil
plot3d(NS, soma = FALSE, lwd = 1, 
       alpha = 0.06, col = 'black')
plot3d(INNOS[1], WithConnectors = FALSE, soma = T, lwd=4, alpha = 0.7, col = Okabe_Ito[8])
par3d(zoom=0.33)
#adjust clipping
clipplanes3d(0, 1, 0, -30000)
#make snapshot
rgl.snapshot("pictures/INNOS_neuropil_1cell_dr.png")
close3d()


plot_background()
clear3d()
# plot only the presyn connectors
#for reference, plot neuropil
plot3d(NS, soma = FALSE, lwd = 1, 
       alpha = 0.06, col = 'black')
plot3d(cPRC, WithConnectors = FALSE, soma = T, lwd=c(3,2,3,2), alpha = c(0.2,0.3,0.4,0.5), col = Okabe_Ito[8])
plot3d(presyn_cPRC$x, presyn_cPRC$y, presyn_cPRC$z, size = 15, alpha = 1, col = "#E69F00", add = T)
plot3d(postsyn_cPRC$x, postsyn_cPRC$y, postsyn_cPRC$z, size = 15, alpha = 1, col = "#0072B2", add = T)
par3d(zoom=0.33)
#adjust clipping
clipplanes3d(0, 1, 0, -30000)
#make snapshot
rgl.snapshot("pictures/cPRC_synapses.png")
close3d()


plot_background()
clear3d()
# plot only the presyn connectors
#for reference, plot neuropil
plot3d(NS, soma = FALSE, lwd = 1, 
       alpha = 0.06, col = 'black')
plot3d(INRGW, WithConnectors = FALSE, soma = T, lwd=c(3,2,3,2), alpha = c(0.2,0.3,0.4,0.5), col = Okabe_Ito[8])
plot3d(presyn_INRGW$x, presyn_INRGW$y, presyn_INRGW$z, size = 15, alpha = 1, col = "#E69F00", add = T)
plot3d(postsyn_INRGW$x, postsyn_INRGW$y, postsyn_INRGW$z, size = 15, alpha = 1, col = "#0072B2", add = T)
par3d(zoom=0.33)
#adjust clipping
clipplanes3d(0, 1, 0, -30000)
#make snapshot
rgl.snapshot("pictures/INRGW_synapses.png")
close3d()


# assemble figure ---------------------------------------------------------
<<<<<<< HEAD

=======
INNOS_dr <- readPNG("pictures/INNOS_neuropil_1cell_dr.png")
>>>>>>> c5e38ca103a436bef4fee9a4aa15b559bbd1f8f6
INNOS_split <- readPNG("pictures/INNOS_axon_dendrite_split.png")

cPRC_img <- readPNG("pictures/cPRC_synapses.png")
INRGW_img <- readPNG("pictures/INRGW_synapses.png")

#read png convert to image panel
arrow <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.8, y2 = 0.9)

<<<<<<< HEAD
panel_INNOS_split <- ggdraw() + 
  draw_image(INNOS_split) +
  draw_label("INNOS", x = 0.3, y = 0.99, size = 10) +
  draw_label("dendrite", x = 0.8, y = 0.45, size = 10, color='grey40') +
  draw_label("axon", x = 0.75, y = 0.22, size = 10, color='grey20') +
  draw_label("*", x = 0.52, y = 0.28, color='black',size = 18,fontface='plain') +
=======
panel_INNOS_dr <- ggdraw() + 
  draw_image(INNOS_dr) +
  draw_label("INNOS_dr", x = 0.5, y = 0.9, size = 10) +
  draw_label("NS plexus", x = 0.5, y = 0.55, size = 8) +
>>>>>>> c5e38ca103a436bef4fee9a4aa15b559bbd1f8f6
  draw_label("D", x = 0.95, y = 0.93, size = 6) +
  draw_label("V", x = 0.95, y = 0.77, size = 6) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow, 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "black", size = 0.2)

<<<<<<< HEAD
panel_INRGW <- ggdraw() + 
  draw_image(INRGW_img) +
  draw_label("*", x = 0.5, y = 0.29, color='black',size = 18,fontface='plain') +
  draw_label("INRGW", x = 0.3, y = 0.99, size = 10) +
  draw_label("NS plexus", x = 0.485, y = 0.59, size = 8) +
  draw_label("outgoing", x = 0.9, y = 0.45, size = 10, color='#E69F00') +
  draw_label("incoming", x = 0.89, y = 0.5, size = 10, color='#0072B2') +
  draw_label("*", x = 0.5, y = 0.29, color='black',size = 18,fontface='plain')
=======
panel_INNOS_split <- ggdraw() + 
  draw_image(INNOS_split) +
  draw_label("INNOS", x = 0.3, y = 0.99, size = 10) +
  draw_label("dendrite", x = 0.8, y = 0.45, size = 10, color='grey40') +
  draw_label("axon", x = 0.75, y = 0.22, size = 10, color='grey20') +
  draw_label("*", x = 0.52, y = 0.28, color='black',size = 18,fontface='plain') 

panel_INRGW <- ggdraw() + 
  draw_image(INRGW_img) +
  draw_label("*", x = 0.5, y = 0.29, color='black',size = 18,fontface='plain') +
  draw_label("outgoing", x = 0.9, y = 0.45, size = 10, color='#E69F00') +
  draw_label("incoming", x = 0.89, y = 0.5, size = 10, color='#0072B2') +
  draw_label("INRGW", x = 0.3, y = 0.99, size = 10)
>>>>>>> c5e38ca103a436bef4fee9a4aa15b559bbd1f8f6

panel_cPRC <- ggdraw() + 
  draw_image(cPRC_img) +
  draw_label("cPRC", x = 0.4, y = 0.99, size = 10) +
  draw_label("*", x = 0.5, y = 0.29, color='black',size = 18,fontface='plain')



layout <- "
A#B#C#D
"

Fig1_sup3 <- panel_INNOS_dr + panel_INNOS_split + panel_INRGW + panel_cPRC + 
  patchwork::plot_layout(design = layout, 
                         widths = c(1, 0.02, 1, 0.02, 1, 0.02, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain', color='black')) #or 'bold', 'italic'


ggsave("Manuscript/figures/Fig1_sup3.png", limitsize = FALSE, 
       units = c("px"), Fig1_sup3, width = 3200, height = 800, bg='white')  


ggsave("Manuscript/figures/Fig1_sup3.pdf", limitsize = FALSE, 
       units = c("px"), Fig1_sup3, width = 3200, height = 800) 
