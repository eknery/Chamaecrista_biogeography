### libraries
library("ape")
library("phytools")
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### load results
load("7_biogeo_results/micro_DEC_2.Rdata")

### phylogenetic tree location
trfn = "5_posterior/mcc.tree"
tr = read.tree(file = trfn)

### number of extant and ancestral branches
n_tips = Ntip(tr)
n_anc = tr$Nnode

### reading range data
geogfn = "6_biogeo_data/micro_biogeo.data"
moref(geogfn)
### converting phylip format to tipranges
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn= geogfn)

############################ PROCESSING EXTANT LINEAGES ########################

### creating binary spp x areas
states_bin = tipranges@df

### creating numeric matrix from binaries
states_num = c()
for(i in 1:ncol(states_bin)){
  one_col = as.numeric(states_bin[,i])
  one_col[one_col == 1] = i
  states_num = cbind(states_num, one_col)
}
### naming
row.names(states_num) = row.names(states_bin)
colnames(states_num) = colnames(states_bin)

########################### PROCESSING ANCESTRAL LINEAGES ######################

### name of areas
areanames = names(tipranges@df)
areanames

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

### states for each node
statenames = areas_list_to_states_list_new(
  areas= areanames, 
  maxareas= max_range_size, include_null_range= include_null_range,
  split_ABC=FALSE
)

### relative probability of each states for each node
relprobs_matrix = res_dec2$ML_marginal_prob_each_state_at_branch_top_AT_node

### get maximum probibility values
ml_probs = get_ML_probs(relprobs_matrix)

### get states with maximum probability values 
ml_states = get_ML_states_from_relprobs(
  relprobs_matrix, 
  statenames, 
  returnwhat="states", 
  if_ties="takefirst"
)

### only ancestral states
anc_states = ml_states[(n_tips+1):(n_tips+n_anc)]

################################### PLOT RESULTS ###############################

source("scripts/function_mix_color.R")

### colors for each area
area_col = c(
  "A" = "forestgreen",
  "B" = "pink",
  "C" = "lightgoldenrod",
  "D" = "darkred",
  "E" = "lightgreen", 
  "F" = "lightblue",
  "G" = "darkblue",
  "H" = "mediumpurple",
  "I" = "gray20"
)

### color list
col_list = list()
for(i in 1:length(area_col) ){
  col_vec = c("white",area_col[i])
  names(col_vec) = c("0", "1")
  col_list[[i]] = col_vec
}
names(col_list) = names(area_col)

### create colors for reconstructed ancestral states
uni_states = sort(unique(anc_states) )
state_col = c()
for(one_state in uni_states){
  # break code
  string= unlist(strsplit(one_state, split = ""))
  # get first color
  one_col = area_col[[string[1]]]
  if(length(string) > 1 ){
    for(i in 2:length(string)){
      # get next color
      next_col = area_col[[string[i]]]
      # mix colors
      one_col = mix_color(col1 = one_col, 
                          col2 = next_col)
    }
  }
  # add new color
  state_col = c(state_col, one_col)
}
names(state_col) = uni_states

### organize into vector
anc_state_col = c()
for(anc in anc_states){
  anc_state_col = c(anc_state_col, state_col[anc])
}

### colors for non-reconstructed states
all_states = unlist(statenames)
non_states = all_states[!all_states %in% names(state_col)]
non_col = rep("black", length(non_states))
names(non_col) = non_states
full_col = c(state_col, non_col)
full_col = full_col[all_states]

### inner node probabilities
inner_node_probs = as.data.frame(relprobs_matrix[(1+n_tips):(n_tips+n_anc),])
colnames(inner_node_probs) = all_states

### legend vectors
comb_area_col = state_col[!names(state_col)%in%names(area_col)]
leg_1 = area_col
leg_2 = comb_area_col[sort(names(comb_area_col))[1:9] ]
leg_3 = comb_area_col[sort(names(comb_area_col))[10:17] ]

### export pie chart
tiff("9_figures/biogeo_plot_pie.tiff",
     units="cm", 
     width= 9, 
     height= 18,
     res=900)
plotTree.datamatrix(
  tree = tr,
  X= states_bin,
  fsize= 0.15,
  header = F, 
  colors = col_list, 
  space = 0, 
  xexp = 1.12,
  yexp = 0.98
)
nodelabels(
  node= (1+n_tips):(n_tips+n_anc), 
  pie = inner_node_probs,
  piecol = full_col, 
  cex= 0.5
)
add.simmap.legend(
  colors= leg_1,
  fsize= 0.8,
  shape="square",
  prompt=FALSE,
  x=0,
  y=100
)
add.simmap.legend(
  colors= leg_2,
  fsize= 0.8,
  shape="square",
  prompt=FALSE,
  x=10,
  y=100
)
add.simmap.legend(
  colors= leg_3,
  fsize= 0.8,
  shape="square",
  prompt=FALSE,
  x=30,
  y=100
)
dev.off()

### export square
tiff("9_figures/biogeo_plot_square.tiff",
     units="cm", 
     width= 9, 
     height= 18,
     res=900)
  plotTree.datamatrix(
    tree = tr,
    X= states_bin,
    fsize= 0.15,
    header = F, 
    colors = col_list, 
    space = 0, 
    xexp = 1.12,
    yexp = 0.98
  )
  nodelabels(
    pch = 22, 
    cex= 0.6,
    col = "black",
    bg = anc_state_col
  )
  add.simmap.legend(
    colors= leg_1,
    fsize= 0.8,
    shape="square",
    prompt=FALSE,
    x=0,
    y=100
    )
  add.simmap.legend(
    colors= leg_2,
    fsize= 0.8,
    shape="square",
    prompt=FALSE,
    x=10,
    y=100
  )
  add.simmap.legend(
    colors= leg_3,
    fsize= 0.8,
    shape="square",
    prompt=FALSE,
    x=30,
    y=100
  )
  axisPhylo(
    pos= -0.1, 
    font=3, 
    cex.axis=0.5
)
dev.off()
