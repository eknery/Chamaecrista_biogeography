all_states = unlist(statenames)

non_states = all_states[!all_states %in% names(state_col)]
non_col = rep("black", length(non_states))
names(non_col) = non_states
full_col = c(state_col, non_col)
full_col = full_col[all_states]

### inner node probabilities
inner_node_probs = as.data.frame(relprobs_matrix[(1+n_tips):(n_tips+n_anc),])
colnames(inner_node_probs) = all_states

### export figure
tiff("8_figures/biogeo_plot_extra.tiff",
     units="cm", 
     width= 9, 
     height= 18,
     res=900)
plotTree(
  tree = ladderize(tr),
  type="phylogram",
  fsize=0.10,
  lwd = 0.1
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
