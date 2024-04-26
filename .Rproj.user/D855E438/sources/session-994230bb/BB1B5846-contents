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

################################# INGROUP NAMES #############################

### all Chamaecrista names
ingroup_names = c()
for(i in 1:length(fasta_list)){
  bool = grepl(pattern = "C_", x = names(fasta_list[[i]]) ) 
  ingroup_names = c(ingroup_names, names(fasta_list[[i]])[bool])
}
ingroup_names = sort(unique(ingroup_names))

### export Chamaecrista names
saveRDS(ingroup_names, "1_ingroup/ingroup_names.RDS")

### getting species per locus
loci = c()
for(i in 1:length(fasta_list)){
  locus = ingroup_names %in% names(fasta_list[[i]])
  loci = cbind(loci, locus)
  colnames(loci)[i] = names(fasta_list)[i]
}
### into one dataframe
ingroup_loci = cbind(ingroup_names, loci)

### export
write.table(ingroup_loci , "1_ingroup/ingroup_loci.csv",
            row.names = F,
            sep=",",
            quote = F
            )

### transform to tibble
ingroup_loci = as.tibble(ingroup_loci)
### get species with all loci sequenced 
ingroup_common_names = ingroup_loci %>% 
  filter_at(vars(-ingroup_names), all_vars(. == TRUE) ) %>% 
  select(ingroup_names) %>% 
  pull()

### export Chamaecrista names
saveRDS(ingroup_common_names, "1_ingroup/ingroup_common_names.RDS")

################################# SELECT INGROUP  #############################

### keeping only Chamaecrista
my_fasta_list = c()
for(i in 1:length(fasta_list)){
  my_fasta_list[[i]] = fasta_list[[i]][names(fasta_list[[i]]) %in% ingroup_names]
  names(fasta_list)[i] = names(fasta_list)[i]
}

### exporting sequences from ingroup
dir_out = "1_ingroup/ingroup_sequences/"
for(i in 1:length(my_fasta_list)){
  fasta_name = paste0(names(my_fasta_list)[i], ".fasta")
  write.phyDat(x = my_fasta_list[[i]], 
               file = paste0(dir_out,fasta_name), 
               format = "fasta", 
               colsep = "", 
               nbcol =100
               )
}
