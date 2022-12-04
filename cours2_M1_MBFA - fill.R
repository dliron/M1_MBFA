################################################################
# Partie 1 : importation et fusion des données
################################################################
library(xlsx)
library(FactoMineR)
library(magrittr)

# Lire les deux onglets du fichier data_pca.xlsx dans 2 variables separées
db     <- read.xlsx("data/data_pca.xlsx",sheetName="data"   )
dbcnt  <- read.xlsx("data/data_pca.xlsx",sheetName="nam_cnt")

# Fusionner les deux bases
base <- merge(db,dbcnt,by.x="Code",by.y="ISO3")
# renommer les lignes avec l'iso3 des pays
rownames(base) <- base$Code
# SUpprmier la colonne Code
base <- base[,!colnames(base)%in%c("Code","CNT")]
# Supprimer les NA de la base
base = na.omit(base)

# Faire une PCA en indiquant la ou les variables caterorielles
res_pca <- PCA(base,quali.sup=9)

# Afficher les graphiques des variables et des individus des 2 premieres dimensions
plot(res_pca, axes = c(1, 2),choix="var")
plot(res_pca, axes = c(1, 2),choix="ind")

# Reperer et supprimer les individus extremes
vecindsup <- which( rownames(base)=="BLR"
                  | rownames(base)=="DJI"
                  | rownames(base)=="LBY"
                  | rownames(base)=="QAT" )

res_pca <- PCA(base,ind.sup = vecindsup, quali.sup=9)

# Afficher graph des individus avec coloration p:r à la region
# en masquant les individus mis de côté
plot(res_pca, choix="ind", habillage=9,  invisible = "ind.sup")

# Afficher les composantes (matrice et graph)
res_pca$eig
barplot(res_pca$eig[,1],main="eigenvalues",names.arg=1:nrow(pca1$eig))

# Faites une classification ascendante hierarchique sur les dimensions retenues
res_pca_hclust = hclust(dist(res_pca$ind$coord[,1:3]))
# Afficher le dendogramme
plot(res_pca_hclust, axes=F,xlab='', ylab='',sub ='', main='Comp 1 to 3')
# Fixer le nombre de classes à 3
rect.hclust(res_pca_hclust, k=3, border='red')
# Faire les prédictions du hclust
pred_hclust = cutree(res_pca_hclust, k = 3) %>% data.frame( res_hclust = .)
# Ajout des resultats dans la base
base = merge(base, pred_hclust, by = "row.names", all.x = T)
rownames(base) = base$Row.names
base = base[,-1]

# Faites un k-means sur les dimensions retenues
res_kmeans <- kmeans(res_pca$ind$coord, 3)
plot(res_pca$ind$coord[,1:2],col=factor(res_kmeans$cluster))
# Faire les prédictions du kmeans
pred_kmeans = res_kmeans$cluster %>% data.frame( res_kmeans = .)
# Ajout des resultats dans la base
base = merge(base, pred_kmeans, by = "row.names", all.x = T)
rownames(base) = base$Row.names
base = base[,-1]

