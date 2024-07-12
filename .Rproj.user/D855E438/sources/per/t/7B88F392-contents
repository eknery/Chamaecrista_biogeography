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

calc_AIC_vals(LnL_vals = c(lnl0, lnl1,lnl2),
              nparam_vals = c(2,2,2)
              )
