### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### file names
file_names = list.files("0_data/")

### loading data
fasta_list = list()
for(i in 1:length(file_names) ){
  fasta_list[[i]] = read.phyDat(paste0("0_data/", file_names[i]),
                                format = "fasta",
                                type = "DNA"
                                )
  names(fasta_list)[i] = str_remove(string = file_names[i], 
                                    pattern = ".fasta")
}

################################# INGROUP DATA #############################

### all chamaecrista names
c_names = c()
for(i in 1:length(fasta_list)){
  bool = grepl(pattern = "C_", x = names(fasta_list[[i]]) ) 
  c_names = c(c_names, names(fasta_list[[i]])[bool])
}
c_names = unique(c_names)

### keeping only Chamaecrista
my_fasta_list = c()
for(i in 1:length(fasta_list)){
  my_fasta_list[[i]] = fasta_list[[i]][names(fasta_list[[i]]) %in% c_names]
  names(fasta_list)[i] = names(fasta_list)[i]
}


### exporting fasta

## for concatenation
dir_name = "1_ingroup_sequences/for_concatenation/"
for(i in 1:length(my_fasta_list)){
  fasta_name = paste0(names(my_fasta_list)[i], ".fasta")
  write.phyDat(x = my_fasta_list[[i]], 
               file = paste0(dir_name,fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
               )
}

## for coalescence
dir_name = "1_ingroup_sequences/for_coalescence/"
for(i in 1:length(my_fasta_list) ){
  marker_name = names(my_fasta_list)[i]
  one_marker = my_fasta_list[[i]]
  names(one_marker) = paste(names(my_fasta_list[[i]]), marker_name, sep="_")
  fasta_name = paste0(names(my_fasta_list)[i], ".fasta")
  write.phyDat(x = one_marker, 
               file = paste0(dir_name,fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
  )
}

############################ BOOTSTRAP TREES ####################################

set.seed(42)
boots_mp_trees = bootstrap.phyDat(my_fasta_list[[1]], 
                                  FUN = pratchet, 
                                  bs = 100)


