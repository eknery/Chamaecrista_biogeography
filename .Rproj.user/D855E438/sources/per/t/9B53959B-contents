### libraries
library("ape")
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### phylogenetic tree location
trfn = "5_posterior/mcc_chamaecrista.tree"
tr = read.tree(file = trfn)

### reading range data
geog_fn = ("6_biogeo_data/micro_biogeo.data")
moref(geog_fn)
### converting phylip format to tipranges
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn=geog_fn)
tipranges

### setting maximum number of areas occupied for reconstructions
max_range_size = max(rowSums(dfnums_to_numeric(tipranges@df)))

############################# MODEL 0 ###################################

### Initialize DEC model
dec0 = define_BioGeoBEARS_run()

### location of the geography text file
dec0$geogfn = geog_fn

### Input the maximum range size
dec0$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
dec0$min_branchlength = 0.01    

# set to FALSE for e.g. DEC* model, DEC*+J, etc.
dec0$include_null_range = FALSE    

### computing options
dec0$num_cores_to_use = 1

### default settings to get ancestral states
dec0$return_condlikes_table = TRUE
dec0$calc_TTL_loglike_from_condlikes_table = TRUE
dec0$calc_ancprobs = TRUE    # get ancestral states from optim run

### inputting tree into DEC
dec0$trfn = trfn

### fitting DEC !
res_dec0 = bears_optim_run(dec0)

### save fitted model
save(res_dec0, file="7_biogeo_results/micro_DEC_0.Rdata")