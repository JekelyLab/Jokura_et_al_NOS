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
                function(x) smooth_neuron(x, sigma=2000))
{
plot_background()
plot3d(cPRC, soma=T, lwd=2, alpha=1, col="#D55E00")
plot3d(INNOS, soma=T, lwd=2, alpha=1, col=Okabe_Ito[5])
plot3d(INRGW, soma=T, lwd=2, alpha=1, col="#56B4E9")
plot3d(Ser_h1, soma=T, lwd=4, alpha=1, col='grey80')
texts3d(56000,32000,5000, "cPRC", cex=3)
texts3d(43000,39000,5000, "Ser-h1", cex=3)
texts3d(75000,32000,5000, "INNOS", cex=3,col=Okabe_Ito[5])
texts3d(50000,53000,5000, "INRGW", cex=3,col="#56B4E9")
par3d(zoom=0.32)
clipplanes3d(0, -1, 0.16, 110000)
}
#x-axis clip

rgl.snapshot("pictures/INNOS_Catmaid.png")
close3d()


# get connectivity from CATMAID and plot network --------------------------
{

cell_groups <- list(cPRC, INNOS, INRGW, Ser_h1)
N_cell_groups <- length(cell_groups)

cell_group_attr <- data.frame(
  cell_group_names  = c('cPRC', 'INNOS', 'INRGW', 'Ser_h1'),
  type = c('SN', 'IN', 'IN', 'MN'),
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
degree=degree(Conn_graph, v = V(Conn_graph), mode = c("all"), loops = TRUE, normalized = FALSE)


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
    visGroups(groupname = "IN", shape = "square", 
              opacity=1, color="#56B4E9") %>%
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

# assemble figure ---------------------------------------------------------

#read png convert to image panel

panelA <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_2d_acTub_XXum.png"))
panelB <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_3d_acTub_XXum.png"))
panelC <- ggdraw() + draw_image(readPNG("pictures/INNOS_Catmaid.png"))
panelD <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NOS_actub_55.92um.png"))
panelE <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um.png"))
panelF <- ggdraw() + draw_image(readPNG("pictures/visNetwork_INNOS.png"))

panelC <- ggdraw() + draw_image(rgl)

#combine panels into Figure and save final figure as pdf and png
Fig1 <- plot_grid(panelA,panelB,panelC,panelD,panelE,panelF,
                  ncol=3,
                  rel_widths = c(1, 1, 1, 1, 1, 1),
                  labels=c("A","B","C","D","E","F"),
                  label_size = 18, label_y = 1, label_x = 0,
                  label_fontfamily = "sans", label_fontface = "plain") + 
  theme(plot.margin = unit(c(1, 1, 1, 1, 1, 1), units = "pt"))

Fig1

ggsave("figures/Fig1.pdf", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2400, height = 1800)  

ggsave("figures/Fig1.png", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2400, height = 1800, bg='white')  



