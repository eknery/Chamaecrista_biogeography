### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### input diretory
dir_input = "2_cassieae/sequences_rogueless/"
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
############################### Including missing species #####################

### all spp names
all_names = c()
for(i in 1:length(fasta_list)){
  all_names = c(all_names, names(fasta_list[[i]]))
}
all_names = sort(unique(all_names))

### including all spp in all loci
my_fasta_list = fasta_list
for(i in 1:length(fasta_list)){
  one_locus = fasta_list[[i]]
  n_patterns = length(one_locus[[1]])
  for(name in all_names){
    boll = name %in% names(one_locus)
    if(boll == FALSE){
      one_locus[[name]] = as.integer(rep(18, n_patterns))
    }
  }
  my_fasta_list[[i]] = one_locus
}

### ordering
for(i in 1:length(my_fasta_list)){
  my_fasta_list[[i]] = my_fasta_list[[i]][all_names]
}

### exporting sequences 
dir_out = "3_final_sequences/concatenation/"
for(i in 1:length(my_fasta_list)){
  fasta_name = paste0(names(my_fasta_list)[i], ".fasta")
  write.phyDat(x = my_fasta_list[[i]], 
               file = paste0(dir_out,fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
  )
}






