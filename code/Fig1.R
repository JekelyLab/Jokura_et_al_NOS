#Code to assemble Fig1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")


# load and plot neurons ---------------------------------------------------

cPRC = nlapply(read.neurons.catmaid("^celltype5$", pid=11),
                    function(x) smooth_neuron(x, sigma=2000))
INNOS = nlapply(read.neurons.catmaid("^celltype7$", pid=11),
               function(x) smooth_neuron(x, sigma=2000))
INRGW = nlapply(read.neurons.catmaid("^celltype6$", pid=11),
               function(x) smooth_neuron(x, sigma=2000))
Ser_h1 = nlapply(read.neurons.catmaid("^celltype8$", pid=11),
                function(x) smooth_neuron(x, sigma=6000))
connectome_neuron = nlapply(read.neurons.catmaid("^connectome_neuron$", pid=11),
                 function(x) smooth_neuron(x, sigma=6000))

{
plot_background()
#plot neurons
plot3d(cPRC, soma=T, lwd=3, alpha=0.5, col="#D55E00")
plot3d(INNOS, soma=T, lwd=4, alpha=1, col=Okabe_Ito[7])
plot3d(INRGW, soma=T, lwd=2, alpha=0.7, col="#56B4E9")
plot3d(Ser_h1, soma=T, lwd=4, alpha=0.5, col='grey80')
#add text labels
texts3d(56000,32000,5000, "cPRC", cex=3)
texts3d(43000,39000,5000, "Ser-h1", cex=3)
texts3d(75000,32000,5000, "INNOS", cex=3,col=Okabe_Ito[7])
texts3d(50000,53000,5000, "INRGW", cex=3,col="#56B4E9")
#adjust zoom
par3d(zoom=0.32)
#adjust clipping
clipplanes3d(0, -1, 0.16, 110000)
#for reference, plot neuropil
plot3d(connectome_neuron, soma=F, lwd=1, alpha=0.08, col='black')
#make snapshot
rgl.snapshot("pictures/INNOS_Catmaid.png")
close3d()
}

{
plot_background_ventral()
#plot neurons
plot3d(cPRC, soma=T, lwd=3, alpha=0.5, col="#D55E00")
plot3d(INNOS, soma=T, lwd=4, alpha=1, col=Okabe_Ito[7])
plot3d(INRGW, soma=T, lwd=2, alpha=0.7, col="#56B4E9")
plot3d(Ser_h1, soma=T, lwd=4, alpha=0.5, col='grey80')
#adjust zoom
par3d(zoom=0.46)
#add text label
texts3d(75000,48000,8000, "apical organ", cex=3)
#change window size
par3d(windowRect = c(0, 0, 800, 800))
#adjust zoom
par3d(zoom=0.62)
#for reference, plot neuropil and body outline
plot3d(connectome_neuron, soma=F, lwd=1, alpha=0.07, col='black')
plot3d(outline, WithConnectors = F, WithNodes = F, soma=F, lwd=2,
       rev = FALSE, fixup = F, add=T, forceClipregion = F, alpha=0.02,
       col="#E2E2E2") 
#make snapshot
rgl.snapshot("pictures/INNOS_Catmaid_ventr.png")
close3d()
}

# get connectivity from CATMAID and plot network --------------------------
{

cell_groups <- list(cPRC, INNOS, INRGW, Ser_h1)
N_cell_groups <- length(cell_groups)

cell_group_attr <- data.frame(
  cell_group_names  = c('cPRC', 'INNOS', 'INRGW', 'Ser_h1'),
  type = c('SN', 'INNOS', 'INRGW', 'MN'),
  level = c('1',  '2', '2', '3')
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
synapse_matrix[synapse_matrix < 5] <- 0
max(synapse_matrix)

#with the make_graph function of igraph we turn it into a graph (input is the list of edge pairs)
Conn_graph <- graph_from_adjacency_matrix(
  synapse_matrix,
  mode = c("directed"),
  weighted = TRUE,
  diag = TRUE
)

#calculate node weighted degree
degree=degree(Conn_graph, v = V(Conn_graph), mode = c("all"), 
              loops = TRUE, normalized = FALSE)


# use visNetwork to plot the network --------------------------------------

## convert to VisNetwork-list
Conn_graph.visn <- toVisNetworkData(Conn_graph)
## copy column "weight" to new column "value" in list "edges"
Conn_graph.visn$edges$value <- Conn_graph.visn$edges$weight
Conn_graph.visn$nodes$value = degree
Conn_graph.visn$nodes$group <- cell_group_attr$type

#hierarchical layout
#level	: Number. Default to undefined. When using the hierarchical layout, the level determines where the node is going to be positioned.
Conn_graph.visn$nodes$level <- cell_group_attr$level
#hierarchical layout
{
  visNet <- visNetwork(Conn_graph.visn$nodes,Conn_graph.visn$edges) %>% 
    visHierarchicalLayout(levelSeparation=200, 
                          direction='UD',
                          sortMethod='hubsize',
                          shakeTowards='roots') %>%
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
             scaling = list(label=list(enabled=TRUE, min=40, max=44)),
             level= Conn_graph.visn$nodes$level) %>%
    visOptions(highlightNearest = list(enabled=TRUE, degree=1, algorithm='hierarchical',labelOnly=FALSE)) %>%
    visInteraction(dragNodes = TRUE, dragView = TRUE,
                   zoomView = TRUE, hover=TRUE,
                   multiselect=TRUE) %>%
    visGroups(groupname = "INRGW", shape = "square", 
              opacity=1, color="#56B4E9") %>%
    visGroups(groupname = "INNOS", shape = "square", 
              opacity=1, color=Okabe_Ito[7]) %>%
    visGroups(groupname = "SN", shape = "circle", 
              opacity=1, color="#D55E00") %>%
    visGroups(groupname = "MN", shape = "circle", 
              opacity=1, color="#cccccc")  %>%
    addFontAwesome()
  visNet
}


# save network diagram as html --------------------------------------------

saveNetwork(visNet, "pictures/visNetwork_INNOS.html")
webshot2::webshot(url="pictures/visNetwork_INNOS.html",
                  file="pictures/visNetwork_INNOS.png",
                  cliprect = c(260,40,500, 500), zoom=5)

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

#read png convert to image panel
panel_SEM <- ggdraw() + 
  draw_image(readPNG("pictures/Platynereis_SEM_3d_inv_280um.png")) +
  draw_line(x = c(0.1, 0.2785), y = c(0.07, 0.07), color = "black", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.2, y = 0.1, size = 10) +
  draw_label("dorsal view", x = 0.2, y = 0.99, size = 10)

panel_NOS2d <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_2d_acTub_XXum.png"))
panel_NOS3d <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_3d_acTub_XXum_crop.png")) +
  draw_label("NOSp::palmy-3xH-TdTomato", x = 0.45, y = 0.99, size = 10) +
  draw_label("INNOS", x = 0.55, y = 0.75, color='#CC79A7', size = 12, fontface='bold') +
  draw_label("cPRC", x = 0.3, y = 0.85, color='white',size = 12,fontface='bold') +
  draw_label("*", x = 0.55, y = 0.32, color='white',size = 18,fontface='bold')
panel_INNOS_ant <- ggdraw() + draw_image(readPNG("pictures/INNOS_Catmaid.png")) +
  draw_label("anterior view", x = 0.3, y = 0.99, size = 10)  +
  draw_label("*", x = 0.51, y = 0.205, color='black',size = 18,fontface='bold')
panel_INNOS_ant
panel_INNOS_ventr <- ggdraw() + draw_image(readPNG("pictures/INNOS_Catmaid_ventr.png")) +
  draw_label("ventral view", x = 0.25, y = 0.99, size = 10)
panel_NOS_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NOS_actub_55.92um.png")) +
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("INNOS", x = 0.55, y = 0.67, color='#CC79A7', size = 12, fontface='bold') +
  draw_label("cPRC", x = 0.3, y = 0.85, color='white',size = 12, fontface='bold')  +
  draw_line(x = c(0.05, 0.407), y = c(0.07, 0.07), color = "black", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.1, size = 10)
panel_NOS_RY_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um.png"))
panel_Network <- ggdraw() + draw_image(readPNG("pictures/visNetwork_INNOS.png")) +
  draw_label("synaptic connectome", x = 0.4, y = 0.99, size = 10)

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
#####
D#E#F
"

Fig1 <- panel_SEM + 
  panel_NOS_HCR + panel_NOS3d + panel_INNOS_ventr + panel_INNOS_ant + panel_Network +
  patchwork::plot_layout(design = layout, heights = c(1,0.02,1), widths = c(1,0.02,1,0.02,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
      face='plain', color='black')) #or 'bold', 'italic'

ggsave("figures/Fig1.png", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2350, height = 1700, bg='white')  

ggsave("figures/Fig1.pdf", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2350, height = 1700)  



