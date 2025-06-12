### libraries
library("ape")
library("rexpokit")
library("cladoRcpp")
library("snow")
library("BioGeoBEARS")

### phylogenetic tree location
trfn = "5_posterior/mcc.tree"
tr = read.tree(file = trfn)

### reading range data
geogfn = "6_biogeo_data/biogeo.data"
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


##################################### DEC 1 ####################################

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

### default settings to get ancestral states
dec1$return_condlikes_table = TRUE
dec1$calc_TTL_loglike_from_condlikes_table = TRUE
dec1$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
dec1$num_cores_to_use = 6

### fitting DEC !
res_dec1 = bears_optim_run(dec1)

### plot
fast_plot(res = res_dec1)

### save fitted model
save(res_dec1, file="7_biogeo_results/DEC_1.Rdata")

################################### DEC 2 ######################################

### https://groups.google.com/g/biogeobears/c/XXaJqmI232o

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model_times.txt"
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
                        fossils_older_than=0.5,
                        cut_fossils=FALSE)

### Decribe stratified table:
dec2$master_table

### default settings to get ancestral states
dec2$return_condlikes_table = TRUE
dec2$calc_TTL_loglike_from_condlikes_table = TRUE
dec2$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
dec2$num_cores_to_use = 6

### fitting DEC !
res_dec2 = bears_optim_run(dec2)

### plot
fast_plot(res = res_dec2)

### save fitted model
save(res_dec2, file="7_biogeo_results/DEC_2.Rdata")

################################## DEC 3 #####################################

### https://groups.google.com/g/biogeobears/c/XXaJqmI232o

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model_times.txt"
areas_allowed_fn = "6_biogeo_data/model3_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model3_dispersal_multi.txt"

### Initialize DEC model
dec3 = define_BioGeoBEARS_run()

### inputting tree
dec3$trfn = trfn

### location of the geography text file
dec3$geogfn = geogfn

### Input the maximum range size
dec3$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
dec3$min_branchlength = 0.001    

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
dec3$include_null_range = FALSE

### input time strata and dispersal matrices
dec3$timesfn = timesfn 
dec3$areas_allowed_fn = areas_allowed_fn
dec3$dispersal_multipliers_fn = dispersal_multipliers_fn

### loads the dispersal multiplier matrix
dec3 = readfiles_BioGeoBEARS_run(dec3)

### Divide the tree up by time periods
dec3 = section_the_tree(inputs=dec3, 
                        make_master_table=TRUE, 
                        plot_pieces=FALSE, 
                        fossils_older_than=0.5,
                        cut_fossils=FALSE)

### Decribe stratified table:
dec3$master_table

### default settings to get ancestral states
dec3$return_condlikes_table = TRUE
dec3$calc_TTL_loglike_from_condlikes_table = TRUE
dec3$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
dec3$num_cores_to_use = 6

### fitting DEC !
res_dec3 = bears_optim_run(dec3)

### plot
fast_plot(res = res_dec3)

### save fitted model
save(res_dec3, file="7_biogeo_results/DEC_3.Rdata")

################################# DIVALIKE 1 ####################################

### initialize DIVALIKE
div1 = define_BioGeoBEARS_run()

### inputting tree
div1$trfn = trfn

### location of the geography text file
div1$geogfn = geogfn

### Input the maximum range size
div1$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
div1$min_branchlength = 0.001   

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
div1$include_null_range = TRUE    

### Set up DIVALIKE model
## Remove subset-sympatry
div1$BioGeoBEARS_model_object@params_table["s","type"] = "fixed"
div1$BioGeoBEARS_model_object@params_table["s","init"] = 0.0
div1$BioGeoBEARS_model_object@params_table["s","est"] = 0.0
div1$BioGeoBEARS_model_object@params_table["ysv","type"] = "2-j"
div1$BioGeoBEARS_model_object@params_table["ys","type"] = "ysv*1/2"
div1$BioGeoBEARS_model_object@params_table["y","type"] = "ysv*1/2"
div1$BioGeoBEARS_model_object@params_table["v","type"] = "ysv*1/2"

## Allow classic, widespread vicariance; all events equiprobable
div1$BioGeoBEARS_model_object@params_table["mx01v","type"] = "fixed"
div1$BioGeoBEARS_model_object@params_table["mx01v","init"] = 0.5
div1$BioGeoBEARS_model_object@params_table["mx01v","est"] = 0.5

### check
check_BioGeoBEARS_run(div1)

### default settings to get ancestral states
div1$return_condlikes_table = TRUE
div1$calc_TTL_loglike_from_condlikes_table = TRUE
div1$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
div1$num_cores_to_use = 6

### fitting DIVA !
res_div1 = bears_optim_run(div1)

### plot
fast_plot(res = res_div1)

### save fitted model
save(res_div1, file="7_biogeo_results/DIVA_1.Rdata")

################################# DIVALIKE 2 ###################################

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model_times.txt"
areas_allowed_fn = "6_biogeo_data/model2_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model2_dispersal_multi.txt"

### initialize DIVALIKE
div2 = define_BioGeoBEARS_run()

### inputting tree
div2$trfn = trfn

### location of the geography text file
div2$geogfn = geogfn

### Input the maximum range size
div2$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
div2$min_branchlength = 0.001   

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
div2$include_null_range = TRUE    

### Set up DIVALIKE model
## Remove subset-sympatry
div2$BioGeoBEARS_model_object@params_table["s","type"] = "fixed"
div2$BioGeoBEARS_model_object@params_table["s","init"] = 0.0
div2$BioGeoBEARS_model_object@params_table["s","est"] = 0.0
div2$BioGeoBEARS_model_object@params_table["ysv","type"] = "2-j"
div2$BioGeoBEARS_model_object@params_table["ys","type"] = "ysv*1/2"
div2$BioGeoBEARS_model_object@params_table["y","type"] = "ysv*1/2"
div2$BioGeoBEARS_model_object@params_table["v","type"] = "ysv*1/2"

## Allow classic, widespread vicariance; all events equiprobable
div2$BioGeoBEARS_model_object@params_table["mx01v","type"] = "fixed"
div2$BioGeoBEARS_model_object@params_table["mx01v","init"] = 0.5
div2$BioGeoBEARS_model_object@params_table["mx01v","est"] = 0.5

### input time strata and dispersal matrices
div2$timesfn = timesfn 
div2$areas_allowed_fn = areas_allowed_fn
div2$dispersal_multipliers_fn = dispersal_multipliers_fn

### loads the dispersal multiplier matrix
div2 = readfiles_BioGeoBEARS_run(div2)

### Divide the tree up by time periods
div2 = section_the_tree(inputs=div2, 
                        make_master_table=TRUE, 
                        plot_pieces=FALSE, 
                        fossils_older_than=0.5,
                        cut_fossils=FALSE)

### Decribe stratified table:
div2$master_table

### check
check_BioGeoBEARS_run(div2)

### default settings to get ancestral states
div2$return_condlikes_table = TRUE
div2$calc_TTL_loglike_from_condlikes_table = TRUE
div2$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
div2$num_cores_to_use = 6

### fitting DIVA !
res_div2 = bears_optim_run(div2)

### plot
fast_plot(res = res_div2)

### save fitted model
save(res_div2, file="7_biogeo_results/DIVA_2.Rdata")

################################# DIVALIKE 3 ###################################

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model_times.txt"
areas_allowed_fn = "6_biogeo_data/model3_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model3_dispersal_multi.txt"

### initialize DIVALIKE
div3 = define_BioGeoBEARS_run()

### inputting tree
div3$trfn = trfn

### location of the geography text file
div3$geogfn = geogfn

### Input the maximum range size
div3$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
div3$min_branchlength = 0.001   

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
div3$include_null_range = TRUE    

### Set up DIVALIKE model
## Remove subset-sympatry
div3$BioGeoBEARS_model_object@params_table["s","type"] = "fixed"
div3$BioGeoBEARS_model_object@params_table["s","init"] = 0.0
div3$BioGeoBEARS_model_object@params_table["s","est"] = 0.0
div3$BioGeoBEARS_model_object@params_table["ysv","type"] = "2-j"
div3$BioGeoBEARS_model_object@params_table["ys","type"] = "ysv*1/2"
div3$BioGeoBEARS_model_object@params_table["y","type"] = "ysv*1/2"
div3$BioGeoBEARS_model_object@params_table["v","type"] = "ysv*1/2"

## Allow classic, widespread vicariance; all events equiprobable
div3$BioGeoBEARS_model_object@params_table["mx01v","type"] = "fixed"
div3$BioGeoBEARS_model_object@params_table["mx01v","init"] = 0.5
div3$BioGeoBEARS_model_object@params_table["mx01v","est"] = 0.5

### input time strata and dispersal matrices
div3$timesfn = timesfn 
div3$areas_allowed_fn = areas_allowed_fn
div3$dispersal_multipliers_fn = dispersal_multipliers_fn

### loads the dispersal multiplier matrix
div3 = readfiles_BioGeoBEARS_run(div3)

### Divide the tree up by time periods
div3 = section_the_tree(inputs=div3, 
                        make_master_table=TRUE, 
                        plot_pieces=FALSE, 
                        fossils_older_than=0.5,
                        cut_fossils=FALSE)

### Decribe stratified table:
div3$master_table

### check
check_BioGeoBEARS_run(div3)

### default settings to get ancestral states
div3$return_condlikes_table = TRUE
div3$calc_TTL_loglike_from_condlikes_table = TRUE
div3$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
div3$num_cores_to_use = 5

### fitting DIVA !
res_div3 = bears_optim_run(div3)

### plot
fast_plot(res = res_div3)

### save fitted model
save(res_div3, file="7_biogeo_results/DIVA_3.Rdata")

################################### BAYAREALIKE 1 ###############################

### initialize DIVALIKE
bay1 = define_BioGeoBEARS_run()

### inputting tree
bay1$trfn = trfn

### location of the geography text file
bay1$geogfn = geogfn

### Input the maximum range size
bay1$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
bay1$min_branchlength = 0.001   

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
bay1$include_null_range = TRUE  

#### Set up BAYAREALIKE model
## No subset sympatry
bay1$BioGeoBEARS_model_object@params_table["s","type"] = "fixed"
bay1$BioGeoBEARS_model_object@params_table["s","init"] = 0.0
bay1$BioGeoBEARS_model_object@params_table["s","est"] = 0.0

## No vicariance
bay1$BioGeoBEARS_model_object@params_table["v","type"] = "fixed"
bay1$BioGeoBEARS_model_object@params_table["v","init"] = 0.0
bay1$BioGeoBEARS_model_object@params_table["v","est"] = 0.0

## Adjust linkage between parameters
bay1$BioGeoBEARS_model_object@params_table["ysv","type"] = "1-j"
bay1$BioGeoBEARS_model_object@params_table["ys","type"] = "ysv*1/1"
bay1$BioGeoBEARS_model_object@params_table["y","type"] = "1-j"

## Only sympatric/range-copying (y) events allowed
bay1$BioGeoBEARS_model_object@params_table["mx01y","type"] = "fixed"
bay1$BioGeoBEARS_model_object@params_table["mx01y","init"] = 0.9999
bay1$BioGeoBEARS_model_object@params_table["mx01y","est"] = 0.9999

### check
check_BioGeoBEARS_run(bay1)

### default settings to get ancestral states
bay1$return_condlikes_table = TRUE
bay1$calc_TTL_loglike_from_condlikes_table = TRUE
bay1$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
bay1$num_cores_to_use = 5

### fitting DIVA !
res_bay1 = bears_optim_run(bay1)

### plot
fast_plot(res = res_bay1)

### save fitted model
save(res_bay1, file="7_biogeo_results/BAYAREA_1.Rdata")

################################### BAYAREALIKE 2 ###############################

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model_times.txt"
areas_allowed_fn = "6_biogeo_data/model2_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model2_dispersal_multi.txt"

### initialize DIVALIKE
bay2 = define_BioGeoBEARS_run()

### inputting tree
bay2$trfn = trfn

### location of the geography text file
bay1$geogfn = geogfn

### Input the maximum range size
bay1$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
bay1$min_branchlength = 0.001   

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
bay1$include_null_range = TRUE  

#### Set up BAYAREALIKE model
## No subset sympatry
bay1$BioGeoBEARS_model_object@params_table["s","type"] = "fixed"
bay1$BioGeoBEARS_model_object@params_table["s","init"] = 0.0
bay1$BioGeoBEARS_model_object@params_table["s","est"] = 0.0

## No vicariance
bay1$BioGeoBEARS_model_object@params_table["v","type"] = "fixed"
bay1$BioGeoBEARS_model_object@params_table["v","init"] = 0.0
bay1$BioGeoBEARS_model_object@params_table["v","est"] = 0.0

## Adjust linkage between parameters
bay1$BioGeoBEARS_model_object@params_table["ysv","type"] = "1-j"
bay1$BioGeoBEARS_model_object@params_table["ys","type"] = "ysv*1/1"
bay1$BioGeoBEARS_model_object@params_table["y","type"] = "1-j"

## Only sympatric/range-copying (y) events allowed
bay1$BioGeoBEARS_model_object@params_table["mx01y","type"] = "fixed"
bay1$BioGeoBEARS_model_object@params_table["mx01y","init"] = 0.9999
bay1$BioGeoBEARS_model_object@params_table["mx01y","est"] = 0.9999

### check
check_BioGeoBEARS_run(bay1)

### default settings to get ancestral states
bay1$return_condlikes_table = TRUE
bay1$calc_TTL_loglike_from_condlikes_table = TRUE
bay1$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
bay1$num_cores_to_use = 5

### fitting DIVA !
res_bay1 = bears_optim_run(bay1)

### plot
fast_plot(res = res_bay1)

### save fitted model
save(res_bay1, file="7_biogeo_results/BAYAREA_1.Rdata")

################################### BAYAREALIKE 3 ###############################

### time strata and dispersal matrices
timesfn = "6_biogeo_data/model_times.txt"
areas_allowed_fn = "6_biogeo_data/model3_areas_allowed.txt"
dispersal_multipliers_fn = "6_biogeo_data/model3_dispersal_multi.txt"

### initialize DIVALIKE
bay3 = define_BioGeoBEARS_run()

### inputting tree
bay3$trfn = trfn

### location of the geography text file
bay3$geogfn = geogfn

### Input the maximum range size
bay3$max_range_size = max_range_size

### Min to treat tip as a direct ancestor (no speciation event)
bay3$min_branchlength = 0.001   

### set to FALSE for e.g. DEC* model, DEC*+J, etc.
bay3$include_null_range = TRUE  

#### Set up BAYAREALIKE model
## No subset sympatry
bay3$BioGeoBEARS_model_object@params_table["s","type"] = "fixed"
bay3$BioGeoBEARS_model_object@params_table["s","init"] = 0.0
bay3$BioGeoBEARS_model_object@params_table["s","est"] = 0.0

## No vicariance
bay3$BioGeoBEARS_model_object@params_table["v","type"] = "fixed"
bay3$BioGeoBEARS_model_object@params_table["v","init"] = 0.0
bay3$BioGeoBEARS_model_object@params_table["v","est"] = 0.0

## Adjust linkage between parameters
bay3$BioGeoBEARS_model_object@params_table["ysv","type"] = "1-j"
bay3$BioGeoBEARS_model_object@params_table["ys","type"] = "ysv*1/1"
bay3$BioGeoBEARS_model_object@params_table["y","type"] = "1-j"

## Only sympatric/range-copying (y) events allowed
bay3$BioGeoBEARS_model_object@params_table["mx01y","type"] = "fixed"
bay3$BioGeoBEARS_model_object@params_table["mx01y","init"] = 0.9999
bay3$BioGeoBEARS_model_object@params_table["mx01y","est"] = 0.9999

### input time strata and dispersal matrices
bay3$timesfn = timesfn 
bay3$areas_allowed_fn = areas_allowed_fn
bay3$dispersal_multipliers_fn = dispersal_multipliers_fn

### loads the dispersal multiplier matrix
bay3 = readfiles_BioGeoBEARS_run(bay3)

### Divide the tree up by time periods
bay3 = section_the_tree(inputs=bay3, 
                        make_master_table=TRUE, 
                        plot_pieces=FALSE, 
                        fossils_older_than=0.5,
                        cut_fossils=FALSE)

### Decribe stratified table:
bay3$master_table

### check
check_BioGeoBEARS_run(bay3)

### default settings to get ancestral states
bay3$return_condlikes_table = TRUE
bay3$calc_TTL_loglike_from_condlikes_table = TRUE
bay3$calc_ancprobs = TRUE    # get ancestral states from optim run

### computing options
bay3$num_cores_to_use = 5

### fitting DIVA !
res_bay3 = bears_optim_run(bay3)

### plot
fast_plot(res = res_bay3)

### save fitted model
save(res_bay3, file="7_biogeo_results/BAYAREA_3.Rdata")
