### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### input diretory
dir_input = "1_initial_sequences/"
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

############################## PREPARE TO STARBEAST #########################

dir_out = "3_final_sequences/chamaecrista_STARBEAST/"
for(i in 1:length(fasta_list) ){
  locus_name = names(fasta_list)[i]
  one_marker = fasta_list[[i]]
  names(one_marker) = paste(names(fasta_list[[i]]), locus_name, sep="_")
  fasta_name = paste0(names(fasta_list)[i], ".fasta")
  write.phyDat(x = one_marker, 
               file = paste0(dir_out, fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
  )
}

