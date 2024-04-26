### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### file names
dir_input = "2_cassieae/MP_trees_rogueless/"
file_names = list.files(dir_input)

### loading data
tree_list = list()
for(i in 1:length(file_names) ){
  tree_name = file_names[i]
  tree_list[[i]] = read.tree(file = paste0(dir_input, tree_name))
  names(tree_list)[i] =  str_remove(string = tree_name, 
                                    pattern = ".tree")
}

############################### CLEAN TREES ############################

### select output dir
dir_out = "2_cassieae/MP_trees_rogueless_clean/"
### remove node info
tree_list_rag = tree_list
for(i in 1:length(tree_list) ){ #
  tree_name = paste0(names(tree_list)[i] , ".tree")
  for(j in 1:length(tree_list[[i]])){
    ## force dichotomy
    tree_list_rag[[i]][[j]] = multi2di(tree_list_rag[[i]][[j]])
    ## remove node info
    tree_list_rag[[i]][[j]]$node.label = NULL
  }
  ## export
  write.tree(phy =  tree_list_rag[[i]],
             file = paste0(dir_out,tree_name)
  )
}


