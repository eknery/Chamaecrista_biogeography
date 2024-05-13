### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### input diretory
dir_input = "3_final_sequences/cassieae_concatenation/"
file_names = list.files(dir_input)

### loading data
fasta_list = list()
for(i in 1:length(file_names) ){
  fasta_list[[i]] = read.phyDat(paste0(dir_input, file_names[i]),
                                format = "fasta",
                                type = "DNA"
  )
  names(fasta_list)[i] = str_remove(string = file_names[i], 
                                    pattern = ".fasta")
}

### file names
dir_input = "4_final_trees/zuntinni.tree"
tree = read.tree(file =dir_input)
 
############################### remove tips ###############################

### names to keep
common_names = names(fasta_list[[1]])

### prun tree
pruned_tree = keep.tip(phy = tree, 
                      tip = common_names)
### remove labels
pruned_tree$node.label = NULL

## export
write.tree(phy =  pruned_tree,
           file = "2_cassieae/prunned_zuntinni.tree"
)    


