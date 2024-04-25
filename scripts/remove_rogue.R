### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### input diretory
dir_input = "3_cassieae/sequences/"
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

### input diretory
dir_input = "3_cassieae/rogue_results/"
file_names = list.files(dir_input)

### rogue list
rogue_table_list = list()
for(i in 1:length(file_names) ){
  rogue_table_list[[i]] = read.table(paste0(dir_input, file_names[i]),
                                     header =T
                                     )
  names(rogue_table_list)[i] = str_remove(string = file_names[i], 
                                    pattern = ".txt")
}

############################### REMOVING ROGUE SEQUENCES ########################

### removing rogue sequences per locus 
my_fasta_list = c()
for(locus_name in names(fasta_list)){
  taxon_names = rogue_table_list[[locus_name]]$taxon
  rogue_names = taxon_names[rogue_table_list[[locus_name]]$rawImprovement >= 0.90]
  my_fasta_list[[locus_name]] = fasta_list[[locus_name]][!names(fasta_list[[locus_name]]) %in% rogue_names]
}

### exporting sequences from ingroup
dir_out = "3_cassieae/sequences_rogueless/"
for(i in 1:length(my_fasta_list)){
  fasta_name = paste0(names(my_fasta_list)[i], ".fasta")
  write.phyDat(x = my_fasta_list[[i]], 
               file = paste0(dir_out,fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
  )
}

