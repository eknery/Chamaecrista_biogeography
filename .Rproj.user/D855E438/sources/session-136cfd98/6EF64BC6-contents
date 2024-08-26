### load libraries
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")

### input data
sp_code = read.table("sp_code.csv",sep = ",", h=T)

############################## Converting ##############################
sp = sp_code$sp
all_codes = sp_code$code
all_bins = c()

n_areas = 9

for(code in all_codes){
  ## initial bin
  bin = rep(0, n_areas)
  ## sum
  if( grepl("A", code) ){ bin[1] = 1}
  if( grepl("B", code) ){ bin[2] = 1}
  if( grepl("C", code) ){ bin[3] = 1}
  if( grepl("D", code) ){ bin[4] = 1}
  if( grepl("E", code) ){ bin[5] = 1}
  if( grepl("F", code) ){ bin[6] = 1}
  if( grepl("G", code) ){ bin[7] = 1}
  if( grepl("H", code) ){ bin[8] = 1}
  if( grepl("I", code) ){ bin[9] = 1}
  if( grepl("J", code) ){ bin[10] = 1}
  ## add final bin
  bin_char = paste(bin, collapse = "")
  all_bins = c(all_bins, bin_char)
}

### species binaries
sp_bin = as.data.frame(cbind(sp, all_bins) )

### export
write.table(sp_bin, "sp_bin.data", sep= " ", row.names = F, quote = F)
