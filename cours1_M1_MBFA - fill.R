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
library(magrittr)
sp500    = as.xts(sp500   [,-1], order.by = as.Date(sp500   [,1])) %>% na.omit()
usbond10 = as.xts(usbond10[,-1], order.by = as.Date(usbond10[,1])) %>% na.omit()
uscpi    = as.xts(uscpi   [,-1], order.by = as.Date(uscpi   [,1])) %>% na.omit()
usgdp    = as.xts(usgdp   [,-1], order.by = as.Date(usgdp   [,1])) %>% na.omit()
# Les convertir en données trimestrielles
sp500    = apply.quarterly(sp500   , function(x) mean(x, na.rm=T))
usbond10 = apply.quarterly(usbond10, function(x) mean(x, na.rm=T))
uscpi    = apply.quarterly(uscpi, mean)
# Modifier les index pour qu'ils collent au format de usgdp
# 1 - afficher la classe de l'index
# 2 - retirer 2 mois à la date
# 3 - fixer les jours au premier du mois
library(lubridate)
index(sp500)    = format( index(sp500) - months(2), "%Y-%m-01") %>% as.Date()
index(usbond10) = format( index(usbond10) - months(2), "%Y-%m-01") %>% as.Date()
index(uscpi)    = format( index(uscpi) - months(2), "%Y-%m-01") %>% as.Date()
# Fusionner les données
base = cbind(usgdp, sp500, usbond10, uscpi)
# Calculer la croissance du pib YoY et l'inflation
base$tusgdp = (base$usgdp / stats::lag(base$usgdp, 4) - 1) * 100
base$usinfl = (base$uscpi / stats::lag(base$uscpi, 4) - 1) * 100
# Sauver la base dans un fichier base.csv
write.table(data.frame(date=index(base),base), 'data/base.csv',row.names = F, sep=',', dec='.')

# Scatter plot croissance/bond
plot(as.vector(base$tusgdp), as.vector(base$usbond10))
# Scatter plot sp500/bond
plot(as.vector(base$sp500), as.vector(base$usbond10))
# correlations des variables de base
cor(na.omit(base))
# distribution du sp500
plot(density(na.omit(base$sp500)))

# creer une base_ts et supprimer les na
library(dynlm)
base_ts = ts(base, start = 1947, frequency = 4)
base_ts = na.omit(base_ts)
# faire un dynlm pour prevoir la croissance en fonction 
# d'un AR, le sp500, les taux 10 ans et l'inflation
eq = dynlm(tusgdp ~ L(tusgdp,1) + sp500 + usbond10 + usinfl, data = base_ts)
summary(eq)
# Afficher sur un graph la croissance du pib et sa prévision
plot(base_ts[,"tusgdp"])
lines(fitted(eq,base_ts[,"tusgdp"]), col = 'red')

# Importer la valeur de cloture du sp500 depuis yahoo
library(quantmod)
sp500    = Cl(getSymbols( "^GSPC" , src='yahoo', from="1980-01-01", auto.assign=F, warnings=F, methods="curl" ))
# calculer le return quotidien du sp500
library(PerformanceAnalytics)
ret = Return.calculate(sp500)

# calculer la moyenne glissante mensuelle du sp500
# Plot du sp500 et sa moyenne mobille 21J depuis 2022
plot(sp500["2022/"])
lines(rollapply(sp500,21,function(x)mean(x,na.rm=T))["2022/"], col='red')













