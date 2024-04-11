### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
if(!require("seqinr")) install.packages("seqinr"); library("seqinr")

### file names
dir_input = "1_ingroup/ingroup_sequences/"
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

### species with all loci sequenced 
ingroup_common_names = readRDS("1_ingroup/ingroup_common_names.RDS")

################################ MODEL TEST #############################
all_best_models = list()

for(i in 2:length(fasta_list)){
  ## locus name
  locus_name = names(fasta_list)[i]
  ## fit all models
  model_fit = modelTest(fasta_list[[i]], model = "all")
  ## pick the best
  best_model = model_fit[model_fit$AICc == min(model_fit$AICc),]
  ## add best model
  all_best_models[[i]] = best_model
  names(all_best_models)[i] = locus_name
  ## table name
  table_name= paste0(locus_name,".csv")
  ## export
  write.table(model_fit, 
              paste0("4_model_test_results/", table_name),
              row.names = F,
              sep=",",
              quote = F
  )
}

saveRDS(all_best_models, "4_model_test_results/all_best_models.RDS")
