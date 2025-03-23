### libraries
library("ape")
library("phytools")
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### load results
load("7_biogeo_results/micro_DEC_2.Rdata")

### results to map
res = res_dec2

### reading range data
geogfn = "6_biogeo_data/micro_biogeo.data"
moref(geogfn)

################################## DATA PROCESSING #############################

### converting phylip format to tipranges
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn= geogfn)

### name of areas
areanames = names(tipranges@df)

### setting maximum number of areas occupied 
max_range_size = max(rowSums(dfnums_to_numeric(tipranges@df)))

### accept null range?
include_null_range = F

### list of codes for each node
states_list_0based_index = rcpp_areas_list_to_states_list(
  areas= areanames, 
  maxareas= max_range_size, 
  include_null_range= include_null_range
)

### extra script to plot
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

####################################### BSM ####################################
clado_events_tables = NULL
ana_events_tables = NULL
lnum = 0
BSM_inputs_fn = "8_BSM/BSM_inputs_file.Rdata"

### save input list - only first time
stochastic_mapping_inputs_list = get_inputs_for_stochastic_mapping(res=res)
save(stochastic_mapping_inputs_list, file=BSM_inputs_fn)

### load input list 
load(BSM_inputs_fn)

### set seed
set.seed(seed=as.numeric(Sys.time()))

### run BSM
BSM_output = runBSM(
    res, 
    stochastic_mapping_inputs_list=stochastic_mapping_inputs_list, 
    maxnum_maps_to_try=100, 
    nummaps_goal=50,
    maxtries_per_branch=40000,
    save_after_every_try=TRUE, 
    savedir= paste0(getwd(),"/8_BSM/"), 
    seedval=12345, 
    wait_before_save=0.01, 
    master_nodenum_toPrint=0
)
RES_clado_events_tables = BSM_output$RES_clado_events_tables
RES_ana_events_tables = BSM_output$RES_ana_events_tables

####################### plotting a single stochastic map #######################

### Load RES_clado_events_tables
load(file="8_BSM/RES_clado_events_tables.Rdata")
### Loads  RES_ana_events_tables
load(file="8_BSM/RES_ana_events_tables.Rdata")

### make BSM table
BSM_output = NULL
BSM_output$RES_clado_events_tables = RES_clado_events_tables
BSM_output$RES_ana_events_tables = RES_ana_events_tables

### Extract BSM output from one simulation
clado_events_table = BSM_output$RES_clado_events_tables[[1]]
ana_events_table = BSM_output$RES_ana_events_tables[[1]]
stratified = T

### Convert the BSM into a modified res object
master_table_cladogenetic_events = clado_events_table
resmod = stochastic_map_states_into_res(
  res=res,
  master_table_cladogenetic_events=master_table_cladogenetic_events, 
  stratified=stratified
)

### color list
colors_list_for_states = get_colors_for_states_list_0based(
  areanames=areanames, 
  states_list_0based=states_list_0based_index,
  max_range_size=max_range_size, 
  plot_null_range=F
)

### plot map
plot_BioGeoBEARS_results(
  results_object=resmod, 
  analysis_titletxt="Stochastic map", 
  addl_params=list("j"), 
  label.offset=0.5, 
  plotwhat="text", 
  cornercoords_loc=scriptdir, 
  root.edge=TRUE, 
  colors_list_for_states=colors_list_for_states, 
  skiptree=FALSE, 
  show.tip.label=TRUE
  )

# Paint on the branch states
paint_stochastic_map_branches(
  res=resmod, 
  master_table_cladogenetic_events=master_table_cladogenetic_events,
  colors_list_for_states=colors_list_for_states, 
  lwd=5, 
  lty=par("lty"), 
  root.edge=TRUE, 
  stratified=stratified
  )

plot_BioGeoBEARS_results(
  results_object=resmod, 
  analysis_titletxt="Stochastic map", 
  addl_params=list("j"), plotwhat="text", 
  cornercoords_loc=scriptdir, 
  root.edge=TRUE, 
  colors_list_for_states=colors_list_for_states,
  skiptree=TRUE, 
  show.tip.label=TRUE
  )

dev.off()

#######################################################
# Summarize stochastic map tables
#######################################################
areanames = names(tipranges@df)
actual_names = areanames
actual_names

# Get the dmat and times (if any)
dmat_times = get_dmat_times_from_res(res=res, numstates=NULL)
dmat_times

# Simulate the source areas
BSMs_w_sourceAreas = simulate_source_areas_ana_clado(res, clado_events_tables, ana_events_tables, areanames)
clado_events_tables = BSMs_w_sourceAreas$clado_events_tables
ana_events_tables = BSMs_w_sourceAreas$ana_events_tables

# Count all anagenetic and cladogenetic events
counts_list = count_ana_clado_events(clado_events_tables, ana_events_tables, areanames, actual_names)

summary_counts_BSMs = counts_list$summary_counts_BSMs
print(conditional_format_table(summary_counts_BSMs))

# Histogram of event counts
hist_event_counts(counts_list, 
                  pdffn=paste0("histograms_of_event_counts.pdf"))

#######################################################
# Print counts to files
#######################################################
tmpnames = names(counts_list)
cat("\n\nWriting tables* of counts to tab-delimited text files:\n(* = Tables have dimension=2 (rows and columns). Cubes (dimension 3) and lists (dimension 1) will not be printed to text files.) \n\n")
for (i in 1:length(tmpnames)){
  cmdtxt = paste0("item = counts_list$", tmpnames[i])
  eval(parse(text=cmdtxt))
  
  # Skip cubes
  if (length(dim(item)) != 2)
  {
    next()
  }
  
  outfn = paste0(tmpnames[i], ".txt")
  if (length(item) == 0)
  {
    cat(outfn, " -- NOT written, *NO* events recorded of this type", sep="")
    cat("\n")
  } else {
    cat(outfn)
    cat("\n")
    write.table(conditional_format_table(item), file=outfn, quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)
  } # END if (length(item) == 0)
} # END for (i in 1:length(tmpnames))
cat("...done.\n")

#######################################################
# Check that ML ancestral state/range probabilities and
# the mean of the BSMs approximately line up
#######################################################
library(MultinomialCI)    # For 95% CIs on BSM counts
check_ML_vs_BSM(res, 
                clado_events_tables, 
                "best_model", 
                tr=NULL, 
                plot_each_node=FALSE, 
                linreg_plot=TRUE, 
                MultinomialCI=TRUE)
