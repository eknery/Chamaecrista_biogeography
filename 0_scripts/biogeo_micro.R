### libraries
library("ape")
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### phylogenetic tree location
trfn = "5_posterior/mcc.tree"
tr = read.tree(file = trfn)

### reading range data
geogfn = "6_biogeo_data/micro_biogeo.data"
moref(geogfn)
### converting phylip format to tipranges
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn= geogfn)
tipranges

### setting maximum number of areas occupied for reconstructions
max_range_size = max(rowSums(dfnums_to_numeric(tipranges@df)))

###  biogeobears scripts
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

### my function 
fast_plot = function(res){
  plot_BioGeoBEARS_results(results_object= res, 
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
}


############################# MODEL 0 ###################################

### Initialize DEC model
dec0 = define_BioGeoBEARS_run()

### inputting tree into DEC
dec0$trfn = trfn

### location of the geography text file
dec0$geogfn = geogfn

### Input the maximum range size
dec0$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
dec0$min_branchlength = 0.001    

# set to FALSE for e.g. DEC* model, DEC*+J, etc.
dec0$include_null_range = FALSE    

### default settings to get ancestral states
dec0$return_condlikes_table = TRUE
dec0$calc_TTL_loglike_from_condlikes_table = TRUE
dec0$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
dec0$num_cores_to_use = 1

### fitting DEC !
res_dec0 = bears_optim_run(dec0)

### plot
fast_plot(res = res_dec0)

### save fitted model
save(res_dec0, file="7_biogeo_results/micro_DEC_0.Rdata")

############################# MODEL 1 #################################

### https://groups.google.com/g/biogeobears/c/XXaJqmI232o

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model1_times.txt"
areas_allowed_fn = "6_biogeo_data/model1_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model1_dispersal_multi.txt"

### Initialize DEC model
dec1 = define_BioGeoBEARS_run()

### inputting tree into DEC
dec1$trfn = trfn

### location of the geography text file
dec1$geogfn = geogfn

### Input the maximum range size
dec1$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
dec1$min_branchlength = 0.001    

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
dec1$include_null_range = FALSE

### input time strata and dispersal matrices
dec1$timesfn = timesfn 
dec1$areas_allowed_fn = areas_allowed_fn
dec1$dispersal_multipliers_fn = dispersal_multipliers_fn

### loads the dispersal multiplier matrix
dec1 = readfiles_BioGeoBEARS_run(dec1)

### Divide the tree up by time periods
dec1 = section_the_tree(inputs=dec1, 
                        make_master_table=TRUE, 
                        plot_pieces=FALSE, 
                        fossils_older_than=0.001,
                        cut_fossils=FALSE)

### Decribe stratified table:
dec1$master_table

### default settings to get ancestral states
dec1$return_condlikes_table = TRUE
dec1$calc_TTL_loglike_from_condlikes_table = TRUE
dec1$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
dec1$num_cores_to_use = 1

### fitting DEC !
res_dec1 = bears_optim_run(dec1)

### plot
fast_plot(res = res_dec1)

### save fitted model
save(res_dec1, file="7_biogeo_results/micro_DEC_1.Rdata")

############################# MODEL 2 #################################

### https://groups.google.com/g/biogeobears/c/XXaJqmI232o

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model1_times.txt"
areas_allowed_fn = "6_biogeo_data/model2_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model2_dispersal_multi.txt"

### Initialize DEC model
dec2 = define_BioGeoBEARS_run()

### inputting tree into DEC
dec2$trfn = trfn

### location of the geography text file
dec2$geogfn = geogfn

### Input the maximum range size
dec2$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
dec2$min_branchlength = 0.001    

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
dec2$include_null_range = FALSE

### input time strata and dispersal matrices
dec2$timesfn = timesfn 
dec2$areas_allowed_fn = areas_allowed_fn
dec2$dispersal_multipliers_fn = dispersal_multipliers_fn

### loads the dispersal multiplier matrix
dec2 = readfiles_BioGeoBEARS_run(dec2)

### Divide the tree up by time periods
dec2 = section_the_tree(inputs=dec2, 
                        make_master_table=TRUE, 
                        plot_pieces=FALSE, 
                        fossils_older_than=0.001,
                        cut_fossils=FALSE)

### Decribe stratified table:
dec2$master_table

### default settings to get ancestral states
dec2$return_condlikes_table = TRUE
dec2$calc_TTL_loglike_from_condlikes_table = TRUE
dec2$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
dec2$num_cores_to_use = 1

### fitting DEC !
res_dec2 = bears_optim_run(dec2)

### save fitted model
save(res_dec2, file="7_biogeo_results/micro_DEC_2.Rdata")

### plotting
res_plot = plot_BioGeoBEARS_results(results_object= res_dec0, 
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
