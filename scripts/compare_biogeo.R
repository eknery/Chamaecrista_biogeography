### libraries
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

source("0_scripts/function_calculate_aicc.R")

load("7_biogeo_results/micro_DEC_0.RData")
load("7_biogeo_results/micro_DEC_1.RData")
load("7_biogeo_results/micro_DEC_2.RData")

####################### COMPARE MODELS ###############################

### empty tables to hold the statistical results
restable = NULL
teststable = NULL

### likelihood
lnl0 = get_LnL_from_BioGeoBEARS_results_object(res_dec0)
lnl1 = get_LnL_from_BioGeoBEARS_results_object(res_dec1)
lnl2 = get_LnL_from_BioGeoBEARS_results_object(res_dec2)
LnL_vals = c(lnl0, lnl1,lnl2)

### parameter values
param0 = extract_params_from_BioGeoBEARS_results_object(
  results_object= res_dec0, 
  returnwhat= "table", 
  addl_params= c("j"), 
  paramsstr_digits= 4
)

param1 = extract_params_from_BioGeoBEARS_results_object(
  results_object= res_dec1, 
  returnwhat= "table", 
  addl_params= c("j"), 
  paramsstr_digits= 4
)

param2 = extract_params_from_BioGeoBEARS_results_object(
  results_object= res_dec2, 
  returnwhat= "table", 
  addl_params= c("j"), 
  paramsstr_digits= 4
)

### collect parameter values
n_param_vals = c(param0$numparams,param1$numparams,param2$numparams)

### calculate AIC
aic = calc_AIC_vals(
  LnL_vals = LnL_vals,
  nparam_vals = n_param_vals
)

### in a single table
model_table =as.data.frame(cbind(LnL_vals, n_param_vals, aic))

### akaike weights
AkaikeWeights_on_summary_table(model_table,
                               colname_to_use ="aic", 
                               add_to_table = F)
