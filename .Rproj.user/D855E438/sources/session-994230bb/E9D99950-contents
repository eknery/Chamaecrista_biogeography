### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### input diretory
dir_input = "0_raw_sequences/"
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

############################## SELECT CASSIEAE ################################

### cassieae pattern names
patterns = c("Batesia",
             "Melanoxylon",
             "Recordoxylon",
             "Vouacapoua", 
             "C_",
             "Cassia", 
             "Senna"
             )

### all species names
all_names = c() 
for(i in 1:length(fasta_list)){
  all_names = c(all_names, names(fasta_list[[i]]))
  
}  
all_names = unique(all_names)

### select cassieae names
cass_names = c()
for(i in 1:length(patterns)){
  bool = grepl(pattern = patterns[i], all_names)
  cass_names = c(cass_names, all_names[bool])
}
cass_names = unique(cass_names)

### keeping only cassieae
my_fasta_list = fasta_list
for(i in 1:length(fasta_list)){
  my_fasta_list[[i]] = fasta_list[[i]][names(fasta_list[[i]]) %in% cass_names]
  names(fasta_list)[i] = names(fasta_list)[i]
}

### exporting sequences from ingroup
dir_out = "3_cassieae/sequences/"
for(i in 1:length(my_fasta_list)){
  fasta_name = paste0(names(my_fasta_list)[i], ".fasta")
  write.phyDat(x = my_fasta_list[[i]], 
               file = paste0(dir_out,fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
  )
}
