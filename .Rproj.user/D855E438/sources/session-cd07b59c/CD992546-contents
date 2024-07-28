### libraries
library("ape")
library("phytools")
library("rexpokit")
library("cladoRcpp")
library("BioGeoBEARS")

### load results
load("7_biogeo_results/micro_DEC_2.Rdata")

### phylogenetic tree location
trfn = "5_posterior/mcc_chamaecrista.tree"
tr = read.tree(file = trfn)

### reading range data
geogfn = "6_biogeo_data/micro_biogeo.data"
moref(geogfn)
### converting phylip format to tipranges
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn= geogfn)

### creating binary spp x areas
states_bin = tipranges@df

### creating numeric matrix
states_num = c()
for(i in 1:ncol(states_bin)){
  one_col = as.numeric(states_bin[,i])
  one_col[one_col == 1] = i
  states_num = cbind(states_num, one_col)
}
### naming
row.names(states_num) = row.names(states_bin)
colnames(states_num) = colnames(states_bin)

color_vec = c(
  "gray90",
  "darkgreen",
  "darkorange",
  "darkgoldenrod",
  "brown",
  "darkblue",
  "darkmagenta",
  "deeppink",
  "black"
)

phylo.heatmap(tr,
              X=states_num, 
              fsize=c(0.3,0.75,0.5), 
              colors=color_vec, 
              split= c(0.9,0.1),
              standardize=F)

## node marginal ML
relprobs_matrix = res$ML_marginal_prob_each_state_at_branch_top_AT_node
## node states
state_labels=c("A", "B", "C", "D", "E", "F", "G", "H")
node_states = get_ML_states_from_relprobs(relprobs= relprobs_matrix, 
                                          statenames= state_labels, 
                                          returnwhat = "states", 
                                          if_ties = "takefirst")
