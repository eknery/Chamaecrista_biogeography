
BiocManager::install("ggtree")
library("ggtree")
library("treeio")
library("tidyverse")

# Ler arquivo .nexus do BEAST
beast_tree <- read.beast("mcc_2.tree")

# gerando posterior lim
beast_tree@data$posterior_lim = beast_tree@data$posterior
beast_tree@data$posterior_lim[beast_tree@data$posterior >= 0.95] = "*"
beast_tree@data$posterior_lim[beast_tree@data$posterior < 0.95] = NA

### export pie chart
tiff("figures/phylo_plot.tiff",
     units="cm", 
     width= 8, 
     height= 14,
     res= 900)
ggtree(
  beast_tree,
  ladderize = T,
  right = T,
  linewidth = 0.3,
  aes(x = length)
  ) +
  geom_range(
    range = 'height_0.95_HPD', 
    color = 'blue', 
    alpha = 0.3, 
    size = 0.8
  ) +
  geom_nodelab(
    aes(x=branch, label=posterior_lim),
    vjust=0.1, 
    size=2
  ) +
  geom_tiplab(
    size = 0.5,
    offset = 0.1,
    align = TRUE
  ) +
  scale_x_continuous(
    breaks = seq(-3.84, 56.16, 10) ,
    labels = c("60", "50", "40", "30", "20", "10", "0" )
  ) +
  theme_tree2(bgcolor = "white", fgcolor = "black")
dev.off()

