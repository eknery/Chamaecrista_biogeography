### libraries
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### get RData files with models
rdata_names = list.files(
  path = paste0(getwd(),"/7_biogeo_results"),
  pattern = ".Rdata"
)

### load all models
for(i in 1:length(rdata_names)){
  load(paste0(getwd(),"/7_biogeo_results/", rdata_names[i]))
}

############################### COMPARE MODELS ###############################

### objects with models
objs = objects(pattern = "res_")

### fit and estimates from models
model_vals = list()
for(i in 1:length(objs)){
  model_vals[[i]] = extract_params_from_BioGeoBEARS_results_object(
    results_object= eval(parse(text=objs[i])), 
    returnwhat= "table", 
    addl_params= c("j"), 
    paramsstr_digits= 4
  )
}

### table with model info
model_table = setNames(
  data.frame(
    matrix(unlist(model_vals), nrow=length(model_vals), byrow=TRUE)
    ),
  colnames(model_vals[[1]])
)
rownames(model_table) = objs

### AIC
model_table$aic = calc_AIC_vals(
  LnL_vals = model_table$LnL,
  nparam_vals = model_table$numparams
)

### AIC weights
model_table = AkaikeWeights_on_summary_table(
    model_table,
   colname_to_use ="aic", 
   add_to_table = T
)

round(model_table$aic_wt, 3)
