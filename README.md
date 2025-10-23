# Historical biogeography of neotropical Chamaecrista

### Description:
This repository has the data and code used in the article **From rainforests to open-vegetation: The biogeographic history of Chamaecrista (Leguminosae) in the Neotropics**.
The folders and their content are as follows: 

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
    1. Figures produced by our scripts and their edited versions;

9. supporting_information:
    1. `Supporting_Information_S1.docx` The protocol for DNA extraction, amplification and sequencing;
    2. `Supporting_Information_S2.tiff` The graphical display of the ML tree inferred from the concatenated loci;
    3. `Supporting_Information_S3.docx` The biogeographic regionalization based on the occurrences of *Chamaecrista* species;
    4. `Supporting_Information_S4.xlsx` The distribution of *Chamaecrista* species and allies in biogeographic areas; 
    5. `Supporting_Information_S5.xlsx` The dispersal multipliers across time frames for the second and third biogeographic scenario;
    6. `Supporting_Information_S6.xlsx` The dispersal rates among biogeographic areas according to the best-fit model;
    
10. scripts:
    1. All R scripts used in our study, each with its own commented code lines;
    
    