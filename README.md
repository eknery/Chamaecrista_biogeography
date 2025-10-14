# Historical biogeography of neotropical Chamaecrista

### Description:
This repository has the data and code used in the article **From rainforests to open-vegetation: The biogeographic history of Chamaecrista (Leguminosae) in the Neotropics**.
The directories and their content are as follows: 

0. raw_sequences: 
    1. Fasta files with the non-aligned DNA sequences of five loci sequenced from *Chamaecrista* species and allies;

1. aligned_sequences: 
    1. Fasta files with the aligned DNA sequences of five loci sequenced from *Chamaecrista* species and allies;
    
2. sequence_evaluation: 
    1. `best_sub_models.csv` The best-fitting substitution models for five loci sequenced from *Chamaecrista*` species and allies
    2. `ml_trees` Folder with the bootstrap maximum-likelihood (ML) trees inferred for five loci sequenced from *Chamaecrista* species and allies;
    3. `pcoa_ml_trees.tiff` The principal coordinate analysis (PCoA) comparing the topology of the bootstrap ML trees;

3. final_sequences:
    1. `concatenation.fasta` The concatenated DNA sequences of five loci sequenced from *Chamaecrista` species and allies;
    2. Fasta files with the aligned DNA sequences of five loci sequenced from *Chamaecrista* species and allies, with blank lines added for non-sequenced species;
    
4. iqtree:
    1. `ml_iq.tree` The ML tree inferred for the concatenated DNA sequences;
    2. `ml_iq_90.tree` The ML tree inferred for the concatenated DNA sequences, but only with the high-support nodes (bootstrap values > 90%);

5. posterior:
    1. `mcc.tree` The Maximum Clade Credibility (MCC) tree inferred for five loci sequenced from *Chamaecrista* species and allies;
    
6. biogeo_data:
    1. `model_times.txt` The time frames considered in the biogeographic reconstruction;
    2. `model2_area_allowed.txt` The available areas across time frames for the second biogeographic scenario;
    3. `model2_dispersal_multi.txt` The dispersal multipliers across time frames for the second biogeographic scenario;
    4. `model2_area_allowed.txt` The available areas across time frames for the third biogeographic scenario;
    5. `model3_dispersal_multi.txt` The dispersal multipliers across time frames for the third biogeographic scenario;
    6. `neotropical_shp` The shapefile displaying the biogeographic units by Morrone (2024);
    7. `sp_area.data` The species-area matrix for biogeographic reconstruction;
    
7. biogeo_results:
    1. Rdata files with the fitted biogeographic models;
    
8. figures:
    1. Figures produced by our scripts and their manually edited versions;

9. files:
    1. `areas_allowed.xlsx` The area-availability matrices for alternative biogeographic scenarios;
    2. `dispersal_multipliers.xlsx` The dispersal matrices for alternative biogeographic scenarios;
    3. `relprob_matrix.xlsx` The relative probability of each geographic state for extant and ancestral species according to the best-fit beogeographic model;
    4. `spp_biogeo_data.xlsx` The species-area matrices for alternative biogeographic regionalizations;
    5. `spp_marker.csv` A matrix with sequenced markers (loci) for each *Chamaecrista* species and allies;
    
10. scripts:
    1. All R scripts used in our study, each with its own commented code lines;
    
    