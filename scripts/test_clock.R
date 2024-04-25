### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")
if(!require("treedater")) install.packages("treedater"); library("treedater")

### file names
dir_input = "3_cassieae/ML_trees/"
file_names = list.files(dir_input)

### loading data
tree_list = list()
for(i in 1:length(file_names) ){
  tree_name = file_names[i]
  tree_list[[i]] = read.tree(file = paste0(dir_input, tree_name))
  names(tree_list)[i] =  str_remove(string = tree_name, 
                                    pattern = ".tree")
}

################################## TESTING CLOCK ###########################

### choose a locus !!!
locus_name = "trnLF"
one_tree = tree_list[[locus_name]]
plot(one_tree)

### sample distance from root to tip:
#sts = setNames( ape::node.depth.edgelength( one_tree )[1:ape::Ntip(one_tree)], one_tree$tip.label)

sts = rnorm(n = Ntip(one_tree), mean = 50e6, sd = 10)
names(sts) =  one_tree$tip.label

### modify edge length to represent evolutionary distance with rate 1e-3:
one_tree$edge.length = one_tree$edge.length 

### clock test
rc_test = relaxedClockTest( one_tree, 
                            sts= sts, 
                            s= 1000,  
                            omega0= 0.0001, 
                            nreps= 100)

plot(rc_test$strict_treedater)
plot(rc_test$relaxed_treedater)


