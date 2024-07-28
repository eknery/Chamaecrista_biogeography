### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### input
dir_input = "5_posterior/"
in_tree = "mcc.tree"

### input tree
tree = read.tree(file = paste0(dir_input, in_tree))

### tips to keep
keep_names = tree$tip.label[grepl("C_", tree$tip.label)]

### prun tree
ktree = keep.tip(phy = tree, 
         tip = keep_names)

### output
dir_out = "5_posterior/"
out_tree = "mcc_chamaecrista.tree"
  
### export
write.tree(phy =  ktree,
           file = paste0(dir_out, out_tree)
)
