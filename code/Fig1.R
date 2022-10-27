#Code to assemble Fig1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

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
connectome_neuron = nlapply(read.neurons.catmaid("^connectome_neuron$", pid=11),
                 function(x) smooth_neuron(x, sigma=6000))
MC = nlapply(read.neurons.catmaid("^celltype9$", pid=11),
               function(x) smooth_neuron(x, sigma=6000))
prototroch = nlapply(read.neurons.catmaid("^celltype_non_neuronal3$", pid=11),
             function(x) smooth_neuron(x, sigma=6000))

{
plot_background()
clear3d()
#plot neurons
plot3d(cPRC, soma = T, lwd=2, alpha = 0.4, col = "#D55E00")
plot3d(INNOS, soma = T, lwd=2, alpha = 1, col = Okabe_Ito[7])
plot3d(INRGW, soma = T, lwd=2, alpha = 0.4, col = "#56B4E9")
plot3d(Ser_h1, soma = T, lwd=2, alpha = 0.4, col = 'grey40')
plot3d(MC, soma = T, lwd = 2, alpha = 0.4, col = 'grey80')
#add text labels
texts3d(54500,40000,5000, "cPRC", cex = 3, col = "#D55E00")
texts3d(42000,39000,5000, "Ser-h1", cex = 3, col = "grey40")
texts3d(71500,39500,5000, "INNOS", cex = 3, col = Okabe_Ito[7])
texts3d(58000,51000,5000, "INRGW", cex = 3, col = "#56B4E9")
texts3d(74800,47600,5000, "MC", cex = 3, color = "grey40")
#adjust zoom
par3d(zoom=0.25)
#for reference, plot neuropil
plot3d(connectome_neuron, soma = FALSE, lwd = 1, 
       alpha = 0.06, col = 'black')
#adjust clipping
clipplanes3d(-1, 0, 0, 125000)
clipplanes3d(0, -1, 0, 145000)
#make snapshot
rgl.snapshot("pictures/INNOS_Catmaid.png")
close3d()
}

{
plot_background_ventral2()
#play3d(spin3d(axis = c(-30, -20, 0), rpm = 2), duration = 2)  

#plot neurons
plot3d(cPRC, soma=T, lwd=2, alpha=0.7, col="#D55E00")
plot3d(INNOS, soma=T, lwd=2, alpha=1, col=Okabe_Ito[7])
plot3d(INRGW, soma=T, lwd=2, alpha=0.7, col="#56B4E9")
plot3d(Ser_h1, soma=T, lwd=2, alpha=0.7, col='grey20')
plot3d(MC, soma=T, lwd=2, alpha=0.7, col='grey60')
plot3d(prototroch, soma=T, WithLine = FALSE, alpha=0.2, col='grey80')

#adjust zoom
#par3d(zoom=0.46)
#add text label
#texts3d(75000,48000,8000, "apical organ", cex=3)
#change window size
#par3d(windowRect = c(0, 0, 800, 800))
#adjust zoom
#par3d(zoom=0.62)
#for reference, plot neuropil and body outline
plot3d(connectome_neuron, soma=F, lwd=1, alpha=0.07, col='black')
plot3d(outline, WithConnectors = F, WithNodes = F, soma=F, lwd=2,
       rev = FALSE, fixup = F, add=T, forceClipregion = F, alpha=0.05,
       col="#E2E2E2")

#make snapshot
rgl.snapshot("pictures/INNOS_Catmaid_ventr.png")
close3d()
}

# get connectivity from CATMAID and plot network --------------------------
{

cell_groups <- list(cPRC, INNOS, INRGW, Ser_h1, MC, prototroch)
N_cell_groups <- length(cell_groups)

cell_group_attr <- data.frame(
  cell_group_names  = c('cPRC', 'INNOS', 'INRGW', 'Ser_h1', 'MC', 'prototroch'),
  type = c('SN', 'INNOS', 'INRGW', 'MN', 'MN', 'effector'),
  level = c('1',  '2', '2', '3', '3', '4')
)

#iterate through cell group neuron lists and get connectivity for all against all
{
#define empty synapse list with the right dimensions
synapse_list <- vector("list", N_cell_groups*N_cell_groups)
for (i in 1:N_cell_groups) {
    for (j in 1:N_cell_groups){
      #get connectors between two cell groups
      presyn_skids <- attr(cell_groups[i][[1]],"df")$skid
      postsyn_skids <- attr(cell_groups[j][[1]],"df")$skid
      connectivity <- catmaid_get_connectors_between(pre=presyn_skids, 
                                                     post=postsyn_skids, pid=11)
      #check the number of synapses from group1 -> group2
      N_synapses <-  dim(connectivity)[1]
      #change "NULL" to 0
      if(is.null(N_synapses)){N_synapses = 0}
      print ((i*N_cell_groups-N_cell_groups)+j)
      print (N_synapses)
      #add value to synapse list
      synapse_list [[(i*N_cell_groups-N_cell_groups)+j]] <- N_synapses
    }
  }
}

#convert synapse list into a matrix of appropriate dimensions
synapse_matrix = matrix(unlist(synapse_list), byrow=TRUE, nrow=N_cell_groups)
rownames(synapse_matrix) <- cell_group_attr$cell_group_names
colnames(synapse_matrix) <- cell_group_attr$cell_group_names
synapse_matrix


# graph conversion --------------------------------------------------------

#edge weight filtering on the matrix to remove weak edges
synapse_matrix[synapse_matrix < 0] <- 0
max(synapse_matrix)

#with the make_graph function of igraph we turn it into a graph (input is the list of edge pairs)
Conn_graph <- graph_from_adjacency_matrix(
  synapse_matrix,
  mode = c("directed"),
  weighted = TRUE,
  diag = TRUE
)

#calculate node weighted degree
weighted_degree=strength(Conn_graph, v = V(Conn_graph), mode = c("all"), 
              loops = TRUE)


# use visNetwork to plot the network --------------------------------------

## convert to VisNetwork-list
Conn_graph.visn <- toVisNetworkData(Conn_graph)
## copy column "weight" to new column "value" in list "edges"
Conn_graph.visn$edges$value <- sqrt(Conn_graph.visn$edges$weight)
#Conn_graph.visn$nodes$value = weighted_degree
Conn_graph.visn$nodes$group <- cell_group_attr$type
Conn_graph.visn$nodes$value <- c()
#hierarchical layout
#level	: Number. Default to undefined. When using the hierarchical layout, the level determines where the node is going to be positioned.
Conn_graph.visn$nodes$level <- cell_group_attr$level
#hierarchical layout
{
visNet <- visNetwork(Conn_graph.visn$nodes,
                     Conn_graph.visn$edges) %>% 
    visHierarchicalLayout(levelSeparation=240, 
                          direction='LR',
                          nodeSpacing = 1) %>%
    visPhysics(hierarchicalRepulsion = list(nodeDistance = 200)) %>%
    visEdges(smooth = list(type = 'curvedCW', roundness=0),
             scaling=list(min=4, max=12),
             color = list(inherit=TRUE, opacity=0.8),
             arrows = list(to = list(enabled = TRUE, 
                                     scaleFactor = 1.2, type = 'arrow'))) %>%
    visNodes(borderWidth=0.3, 
             color = list(background=Conn_graph.visn$nodes$color, border='black'),
             opacity=0.9,
             shape='dot', 
             font=list(color='black', size=44),
             scaling = list(label=list(enabled=TRUE, min=50, max=65)),
             level= Conn_graph.visn$nodes$level) %>%
    visOptions(width = 1000, height = 800,
               highlightNearest = list(enabled=TRUE, degree=1, 
                                       algorithm='hierarchical',
                                       labelOnly=FALSE)) %>%
    visInteraction(dragNodes = TRUE, dragView = TRUE,
                   zoomView = TRUE, hover=TRUE,
                   multiselect=TRUE) %>%
    visGroups(groupname = "INRGW", shape = "box", 
              opacity=1, color="#56B4E9") %>%
    visGroups(groupname = "INNOS", shape = "box", 
              opacity=1, color=Okabe_Ito[7]) %>%
    visGroups(groupname = "SN", shape = "circle", 
              opacity=1, color="#D55E00") %>%
    visGroups(groupname = "MN", shape = "circle", 
              opacity=1, color="#cccccc")  %>%
    visGroups(groupname = "effector", shape = "square", 
              opacity=1, color="#cccccc")  %>%
    addFontAwesome()
visNet
}


# save network diagram as html --------------------------------------------

saveNetwork(visNet, "pictures/visNetwork_INNOS.html")
webshot2::webshot(url="pictures/visNetwork_INNOS.html",
                  file="pictures/visNetwork_INNOS.png",
                  cliprect = c(120, 150, 900, 560), zoom=1)

}


# crop images --------------------------------------
{
img <- image_read("pictures/NOS-promotor_3d_acTub_XXum.png")
print(img)
newimg <- image_crop(img,geometry = "370x370+170+150")
print(newimg)
image_write(newimg, path = "pictures/NOS-promotor_3d_acTub_XXum_crop.png", format = "png")
}

# assemble figure ---------------------------------------------------------
SEM <- readPNG("pictures/Platynereis_SEM_3d_inv_280um-1.png")
#read png convert to image panel
arrow <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.8, y2 = 0.9)
panel_SEM <- ggdraw() + 
  draw_image(SEM) +
  draw_line(x = c(0.1, 0.2785), y = c(0.07, 0.07), color = "black", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.19, y = 0.11, size = 9) +
  draw_label("dosal view", x = 0.3, y = 0.99, size = 10) +
  draw_label("A", x = 0.95, y = 0.93, size = 6) +
  draw_label("P", x = 0.95, y = 0.77, size = 6) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow, 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "black", size = 0.2)

panel_INNOS_ventr <- ggdraw() + draw_image(readPNG("pictures/INNOS_Catmaid_ventr_2.png")) +
  draw_label("ventral view", x = 0.3, y = 0.99, size = 10) +
  draw_label("apical organ", x = 0.72, y = 0.92, color="black", size = 6, fontface='plain')

panel_INNOS_ant <- ggdraw() + draw_image(readPNG("pictures/INNOS_Catmaid.png")) +
  draw_label("anterior view", x = 0.35, y = 0.99, size = 10) +
#  draw_label("cPRC", x = 0.26, y = 0.77, color='#D55E00', size = 6, fontface='plain') +
#  draw_label("INNOS", x = 0.55, y = 0.75, color=Okabe_Ito[7], size = 6, fontface='plain') +
#  draw_label("INRGW", x = 0.3, y = 0.62, color='#56B4E9', size = 6, fontface='plain') +
#  draw_label("Ser-h1", x = 0.1, y = 0.8, color='grey40', size = 6, fontface='plain') +
#  draw_label("MC", x = 0.6, y = 0.65, color='grey60', size = 6, fontface='plain') +
  draw_label("*", x = 0.585, y = 0.29, color='black',size = 18,fontface='plain') +
  draw_label("D", x = 0.95, y = 0.93, size = 6) +
  draw_label("V", x = 0.95, y = 0.78, size = 6) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow, 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "black", size = 0.2)

panel_Network <- ggdraw() + draw_image(readPNG("pictures/visNetwork_INNOS_2.png")) +
  draw_label("synaptic connectome", x = 0.45, y = 0.99, size = 10)


arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.75, y2 = 0.85)
panel_NOS3d_ventr_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR_72_DV_NOS_90um.png")) +
  draw_label("in situ HCR", x = 0.3, y = 0.99, size = 10) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 11, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.9, color="cyan", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.26), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.15, y = 0.11, color = "white", size = 8) +
  draw_label("A", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("P", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2) +
  draw_label("eyespots", x = 0.55, y = 0.68, size = 6, color = "white") +
  draw_line(x = c(0.3, 0.45), y = c(0.63, 0.67), color = "white", size = 0.2) +
  draw_line(x = c(0.77, 0.66), y = c(0.65, 0.67), color = "white", size = 0.2) +
  draw_label("adult eyes", x = 0.55, y = 0.34, size = 6, color = "white") +
  draw_line(x = c(0.26, 0.44), y = c(0.43, 0.35), color = "white", size = 0.2) +
  draw_line(x = c(0.77, 0.65), y = c(0.43, 0.35), color = "white", size = 0.2)


panel_NOS3d_ant_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR_72_AP_NOS_92.02um.png")) +
  draw_label("in situ HCR", x = 0.3, y = 0.99, size = 10) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 11, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.9, color="cyan", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.221), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label("D", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_image(readPNG("pictures/HCR_48_DV_NOS_15.68um_insert.png"), 
             scale = 0.35, x = 1, hjust = 1, halign = 1, valign = 0.12) +
  draw_label("V", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2) +
  draw_label("adult eyes", x = 0.55, y = 0.78, size = 6, color = "white") +
  draw_line(x = c(0.3, 0.45), y = c(0.73, 0.77), color = "white", size = 0.2) +
  draw_line(x = c(0.77, 0.66), y = c(0.75, 0.77), color = "white", size = 0.2) +
  draw_label("eyespots", x = 0.55, y = 0.54, size = 6, color = "white") +
  draw_line(x = c(0.26, 0.44), y = c(0.63, 0.55), color = "white", size = 0.2) +
  draw_line(x = c(0.77, 0.65), y = c(0.63, 0.55), color = "white", size = 0.2) +
  draw_label("INNOS_dr", x = 0.76, y = 0.35, size = 5, color = "white") +
  draw_label("INNOS_vr", x = 0.9, y = 0.11, size = 5, color = "white")


panel_NOS2d_ant_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NOS_actub_55.92um.png")) +
  draw_label("in situ HCR", x = 0.3, y = 0.99, size = 10) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 11, fontface="italic") +
  draw_label("acTub", x = 0.36, y = 0.9, color="green", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.4), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label("cPRC", x = 0.55, y = 0.8, size = 7, color = "white") +
  draw_line(x = c(0.28, 0.47), y = c(0.76, 0.8), color = "white", size = 0.3) +
  draw_line(x = c(0.74, 0.63), y = c(0.78, 0.8), color = "white", size = 0.3)


panel_NOS3d <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_3d_acTub_XXum_crop.png")) +
  draw_label("transgene + IHC", x = 0.38, y = 0.99, size = 10) +
  draw_label("*", x = 0.55, y = 0.32, color='white',size = 18,fontface="plain") +
  draw_label("NOSp::palmi-3xHA", x = 0.34, y = 0.9, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.8, y = 0.9, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.4), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label("cPRC", x = 0.55, y = 0.82, size = 7, color = "white") +
  draw_line(x = c(0.33, 0.47), y = c(0.79, 0.82), color = "white", size = 0.3) +
  draw_line(x = c(0.79, 0.63), y = c(0.79, 0.82), color = "white", size = 0.3)


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C#D
#######
E#F#G#H
"

Fig1 <- panel_SEM + panel_INNOS_ventr + panel_INNOS_ant + panel_Network +  
  panel_NOS3d_ventr_HCR + panel_NOS3d_ant_HCR + panel_NOS2d_ant_HCR + panel_NOS3d + 
  patchwork::plot_layout(design = layout, 
                         heights = c(1,0.02,1), 
                         widths = c(1,0.02,1,0.02,1,0.02,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
      face='plain', color='black')) #or 'bold', 'italic'

ggsave("figures/Fig1.pdf", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2400, height = 1350)  

ggsave("figures/Fig1.png", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2400, height = 1350, bg='white')  




