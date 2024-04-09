### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")

### file names
dir_input = "1_ingroup_sequences/for_concatenation/"
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

############################ BOOTSTRAP TREES ####################################

dir_out = "2_bootstrap_trees/MP_trees/"
for(i in 1:length(fasta_list) ){
  ## tree name
  tree_name = paste0(names(fasta_file)[i], ".tree")
  ## bootstrap MP trees
  set.seed(42)
  boots_mp_trees = bootstrap.phyDat(my_fasta_list[[i]], 
                                    FUN = pratchet, 
                                    bs = 100)
  ## export
  write.tree(phy =  boots_mp_trees,
             file = paste0(dir_out, tree_name)
             )
  
}