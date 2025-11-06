# Carregar o pacote sf
library("ggplot2")
library("sf")

# Caminho para o shapefile
# Substitua pelo caminho correto do seu arquivo shapefile
dir_shp <- "6_biogeo_data/neotropical_shp"

# Ler o shapefile
shp <- st_read(dir_shp)

# nome das provincias
unique(shp$Provincias)

province_col = c(
"Guianan Lowlands province" = "forestgreen",
"Guianan province" = "forestgreen",
"Imeri province" = "forestgreen",
"Napo province" = "forestgreen",
"Para province" = "forestgreen",
"Roraima province" = "forestgreen",
"Madeira province" = "forestgreen",
"Rondonia province" = "forestgreen",
"Ucayali province" = "forestgreen",
"Yungas province" = "forestgreen",
"Xingu-Tapajos province" = "forestgreen",

"Cerrado province" = "pink",
"Caatinga province" = "lightgoldenrod",
"Chapada Diamantina province" = "darkred",
"Southern Espinhaco province" = "darkred",
  
"Araucaria Forest province" = "lightgreen",
"Atlantic province"= "lightgreen",
"Parana Forest province"= "lightgreen",

"Chiapas Highlands province" = "lightblue",
"Sierra Madre Occidental province" = "lightblue",
"Sierra Madre del Sur province" = "lightblue",
"Sierra Madre Oriental province" = "lightblue",
"Transmexican Volcanic Belt province"= "lightblue",
"Bahama province" = "lightblue",
"Cayman Islands province"= "lightblue",
"Cuban province"= "lightblue",
"Hispaniola province"= "lightblue",
"Jamaica province"= "lightblue",
"Lesser Antilles province"= "lightblue",
"Puerto Rico province"= "lightblue",
"Balsas Basin province" = "lightblue",
"Mosquito province"= "lightblue",
"Pacific Lowlands province"= "lightblue",
"Veracruzan province"= "lightblue",
"Yucatan Peninsula Province"= "lightblue",
"Cauca province"= "lightblue",
"Choco-Darien province"= "lightblue",
"Ecuadorian province"= "lightblue",
"Galapagos Islands province"= "lightblue",
"Guajira province"= "lightblue",
"Guatuso-Talamanca province"= "lightblue",
"Magdalena province"= "lightblue",
"Puntarenas-Chiriqui province"= "lightblue",
"Sabana province"= "lightblue",
"Trinidad province"= "lightblue",
"Venezuelan province"= "lightblue",
"Western Ecuador province"= "lightblue",

"Atacama province" = "mediumpurple",
"Comechingones province" = "mediumpurple",
"Cuyan High Andean province" = "mediumpurple",
"Desert province" = "mediumpurple",
"Paramo province" = "mediumpurple",
"Puna province" = "mediumpurple",

"Chaco province" = "white",
"Pampean province" = "white",
"Esteros del Ibera province" = "white",
"Monte province" = "white",
"N/A" = "darkblue"
)

### export dec
pdf("8_figures/map.pdf",
    width=5,
    height=5
    )
ggplot(shp)+
  geom_sf(aes(fill=Provincias),
          col = "black") +
  scale_fill_manual(values = province_col,
                    labels = NULL) +
  
  theme(panel.background=element_rect(fill="white"),
        panel.grid=element_line(colour=NULL),
        panel.border=element_rect(fill=NA,colour="black"),
        axis.title=element_text(size=10,face="bold"),
        legend.position = "none")
dev.off()

