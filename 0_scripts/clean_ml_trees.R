### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")
if(!require("ips")) install.packages("ips"); library("ips")

### file names
dir_input = "4_ml_trees/"
tree_name = "ml_iq_consensus.tree"

tree = read.tree(file = paste0(dir_input, tree_name))
plot(tree, cex=0.5)

ctree = collapseUnsupportedEdges(phy = tree,
                        value = "node.label", 
                        cutoff = 75)
plot(ctree, cex =0.5)

ctree$edge.length = NULL
ctree$node.label = NULL


dir_out = "4_ml_trees/colapsed_trees/"
write.tree(phy =  ctree,
           file = paste0(dir_out,tree_name)
           )
           