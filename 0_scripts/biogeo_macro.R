source("0_scripts/install_biogeobears.R")

### libraries
library("ape")
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### phylogenetic tree location
trfn = "5_posterior/mcc.tree"
tr = read.tree(file = trfn)

### reading range data
geog_fn = ("6_biogeo_data/macro_biogeo.data")
moref(geog_fn)

### converting phylip format to tipranges
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn=geog_fn)
tipranges

### setting maximum number of areas occupied for reconstructions
max_range_size = max(rowSums(dfnums_to_numeric(tipranges@df)))

############################# SETTING MODEL ###################################

### Initialize DEC model
dec = define_BioGeoBEARS_run()

# location of the geography text file
dec$geogfn = geog_fn

### Input the maximum range size
dec$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
dec$min_branchlength = 0.001    

# set to FALSE for e.g. DEC* model, DEC*+J, etc.
dec$include_null_range = FALSE    

### computing options
dec$num_cores_to_use = 1

### default settings to get ancestral states
dec$return_condlikes_table = TRUE
dec$calc_TTL_loglike_from_condlikes_table = TRUE
dec$calc_ancprobs = TRUE    # get ancestral states from optim run

### inputting tree into DEC
dec$trfn = trfn

### fitting DEC !
res_dec = bears_optim_run(dec)

### save fitted model
save(res_dec, file="7_biogeo_results/macro_DEC_default.Rdata")

###  biogeobears scripts
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

res_plot = plot_BioGeoBEARS_results(results_object= res_dec, 
                         addl_params=list("j"),
                         plotwhat="text", 
                         label.offset=0.7, 
                         tipcex=0.15, 
                         statecex=0.4, 
                         titlecex=0.8, 
                         plotsplits= F, 
                         cornercoords_loc= scriptdir, 
                         include_null_range= F, 
                         tr=tr, 
                         tipranges=tipranges,
                         plotlegend = F)
