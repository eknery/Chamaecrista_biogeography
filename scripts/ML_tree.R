### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("phangorn")) install.packages("phangorn"); library("phangorn")
if(!require("ape")) install.packages("ape"); library("ape")
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

########################### INFERING ML TREE ###############################

### choose a locus !!!
locus_name = "trnDT"
one_fasta = fasta_list[[locus_name]]

### fit subsitution models
model_fit = modelTest(one_fasta, model = "all")
## pick the best model
best_model = model_fit[model_fit$AICc == min(model_fit$AICc),]
## parameter estimates from best model
best_fit = as.pml(best_model, best_model$Model)

### optimize tree
ml_tree = pml_bb(x = best_fit, 
                 rearrangements="NNI",
                 control = pml.control(trace = 0))
## select output dir
dir_out = "2_cassieae/ML_trees/"
## export tree
write.tree(phy =  ml_tree$tree,
           file = paste0(dir_out,locus_name,".tree")
)

