# Generer 50 fois un nombre aleatoire compris entre 1 et 10
# Si la valeur arrondie vaut 7, en afficher la valeur via un print
for(i in 1:50){
  xx = round( runif(1) * 10 )
  if(xx == 7) print(xx)
}
# En faire une function avec en parametre
# 1 - le bombre de boucle
# 2 - la valeur à afficher, par defaut 7
loop_runif <- function(nbi, val = 7){
  for(i in 1:nbi){
    xx = round( runif(1) * 10 )
    if(xx == val) print(xx)
  }
}
loop_runif(50)

# Creer un data frame avec 5 colonnes 'col1' ... 'col5'
# Et 100 lignes avec des valeurs aléatoires
# Fixer l'aleatoire avec de generer les dataframe

df = data.frame( col1 = runif(100)
               , col2 = runif(100)
               , col3 = runif(100)
               , col4 = runif(100)
               , col5 = runif(100) )
# Afficher les noms de lignes et des colonnes
colnames(df)
rownames(df)
# Renommer les lignes en row1 ... row100
rownames(df) = paste0("row",1:nrow(df))
# Ajouter une colonne 'mean' avec la moyenne des lignes
df$mean = apply(df,2,mean)
# Ajouter 1 ligne avec dla moyenne des colonnes
df = rbind(df, apply(df,1,mean) )

# Transformer ce data frame en ts 
# débutant en 1950 avec une frequence trimestrielle
df_ts = ts(df, start = 1998, frequency = 4)


# Transforer ce ts en xts
library(xts)

df_xts = as.xts(df_ts)
index(df_xts) = as.Date( index(df_xts) )


# Importer les fichier .csv sp500, usbond10, uscpi, usgdp
sp500    = read.table("data/sp500.csv"   ,header = T, sep = ',', dec = '.')
usbond10 = read.table("data/usbond10.csv",header = T, sep = ',', dec = '.')
uscpi    = read.table("data/uscpi.csv"   ,header = T, sep = ',', dec = '.')
usgdp    = read.table("data/usgdp.csv"   ,header = T, sep = ',', dec = '.')
# compter et supprimer les na
# les passer en xts

# Les convertir en données trimestrielles

# Modifier les index pour qu'ils collent au format de usgdp
# 1 - afficher la classe de l'index
# 2 - retirer 2 mois à la date
# 3 - fixer les jours au premier du mois

# Fusionner les données

# Calculer la croissance du pib YoY et l'inflation

# Sauver la base dans un fichier base.csv


#### Annalyse graphique et correlations
# ----------------------------------------------------------

# Scatter plot croissance/bond

# Scatter plot sp500/bond

# correlations des variables de base

# distribution du sp500


#### Regressions lineraires
# ----------------------------------------------------------

# creer une base_ts et supprimer les na

# faire un dynlm pour prevoir la croissance en fonction 
# d'un AR, le sp500, les taux 10 ans et l'inflation

# Afficher sur un graph la croissance du pib et sa prévision


#### Données financières
# ----------------------------------------------------------

# Importer la valeur de cloture du sp500 depuis yahoo

# calculer le return quotidien du sp500

# calculer la moyenne glissante mensuelle du sp500

# Plot du sp500 et sa moyenne mobille 21J depuis 2022













