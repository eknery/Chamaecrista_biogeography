### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")
if(!require("treedater")) install.packages("treedater"); library("treedater")

### file names
dir_input = "2_cassieae/ML_trees/"
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
locus_name = "ETS"
one_tree = tree_list[[locus_name]]
plot(one_tree, cex =0.5)

### sample distance from root to tip:
sts = rnorm(n = Ntip(one_tree), mean = 54e6, sd = 10)
names(sts) =  one_tree$tip.label

### clock test
rc_test = relaxedClockTest( one_tree, 
                            sts= sts, 
                            s= 1000,  
                            omega0= 0.0001, 
                            nreps= 100)

plot(rc_test$strict_treedater, cex= 0.5)
plot(rc_test$relaxed_treedater)


