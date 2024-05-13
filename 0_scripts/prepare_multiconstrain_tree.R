### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### file names
dir_input = "4_final_trees/matK/"

### loading tree
tree = read.tree(file = paste0(dir_input, "mcc.nwk"))

### remove branch length
tree$edge.length = NULL

### add marker name
tree$tip.label = paste(tree$tip.label, "matK", sep="_")

### select output dir
dir_out = "4_final_trees/matK/"

### export
write.tree(phy =  tree,
           file = paste0(dir_out,"mcc_clean.nwk")
           )
