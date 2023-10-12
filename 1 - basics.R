##########################################################################
#####                            LES TYPES
##########################################################################

class(1)
class(1.0)
class("1")
class(TRUE)
class(NULL)

is.numeric(1)
is.character("1")
is.logical(TRUE)
is.na(NA)
is.null(NULL)
is.infinite(Inf)

as.character(1)
as.numeric("1")

# Affecter une valeur à une variable
x = 1
x <- 1

x + 1
x = x + 1

# Affectation multiple
a = b = 1

# Différents affichages
paste("La valeur de x est ", x, sep = "")
paste0("La valeur de x est ", x)
cat("La valeur de x est", x)
sprintf("La valeur de x est %s", x)


##########################################################################
#####                            LES STRUCTURES
##########################################################################

# Les matrices
matrice = matrix(1:6,ncol=3)
colnames(matrice)
rownames(matrice)
dim(matrice)

colnames(matrice) = c("col1","col2","col3")
rownames(matrice) = paste0("row",1:2)

matrice[1,"col1"]


# Les listes
li = list()
li[[1]] = c("didier","liron")
li$pwd = c("lirondidier")

names(li)
length(li)

# Les dataframe
df = data.frame( user = c("didier", "toto")
               , pwd  = c("liron", "titi") )

colnames(df)
rownames(df)



##########################################################################
#####                            LES CONDITIONS
##########################################################################

a = 1
b = 2
a == b
a != b
a <= b

if(TRUE){
  print("test")
}

T&T
T&F
F&F

T|T
T|F
F|F

nb_alea = sample(10,1)
if( nb_alea == a){
  print("Les deux valeurs sont identiques")
} else {
  sprintf("Les deux valeurs sont differentes: a = %s, nb_alea = %s", a, nb_alea) 
}


# Le seed
sample(10,10)

set.seed(123)
sample(10,10)

set.seed(123)
sample(10,10)

##########################################################################
#####                            LES BOUCLES
##########################################################################


# la boucle for
for(i in 1:30){
  nb_alea = sample(10,1)
  if( nb_alea == a){
    print("Les deux valeurs sont identiques")
  } else {
    print( sprintf("Les deux valeurs sont differentes: a = %s, nb_alea = %s", a, nb_alea) ) 
  }
}


list_valeur = c("ceci","est","une","phrase","!")
for(i in list_valeur){
  print( i )
}

for( i in 1:5){
  assign( paste0("a",i) ,i)
}
get("a3")


# la boucle while
nb_alea = sample(10,1)
while(nb_alea != a){
  print( sprintf("Les deux valeurs sont differentes: a = %s, nb_alea = %s", a, nb_alea) )
  nb_alea = sample(10,1)
}
print(nb_alea)



##########################################################################
#####                           LES FONCTIONS
##########################################################################

is_a_equal_b <- function(a, b){
  res = NA
  if(a == b) {
    res = T
  } else{
    res = F
  }
  
  return(res)
}

is_a_equal_b(a = 2, b = 1)
is_a_equal_b(b = 1, a = 2)
is_a_equal_b(1,2)


is_a_equal_b <- function(a, b, verbose = F){
  res = NA
  if(a == b) {
    res = T
  } else{
    res = F
  }
  
  if(verbose & res) {
    print("yes, a and b are equal !")
  }
  
  if(verbose & !res) {
    print("no, a and b are not equal ...")
  }
  
  return(res)
}
is_a_equal_b(2,1)
is_a_equal_b(1,1,verbose=T)


# Variable globale vs locale

a = 1
function_test <- function(){
  a = a + 2
  a
}
function_test()
a = function_test()

function_test <- function(a){
  a = a + 2
  a
}
function_test(a = 1)
a

a = 1
function_test <- function(){
  a <<- a + 2
  a
}
function_test()
a


##########################################################################
#####                               LES APPLY
##########################################################################

df = data.frame( col1 = runif(100, 1.0, 10.0)
               , col2 = runif(100, 1.0, 10.0)
               , col3 = runif(100, 1.0, 10.0))

apply(df, 1, mean )
apply(df, 1, function(x) mean(x,na.rm=T) )

apply(df, 2, mean)

df$meanrows = apply(df, 1, mean)
df$sdrows = apply(df[,c("col1","col2","col3")], 1, sd)


##########################################################################
#####                       IMPORTER DES DONNEES
##########################################################################

# Importer un fichier Excel
# xlsx (readxl et xlsx)
# https://www.insee.fr/fr/statistiques/series/102877820
library(readxl)
library(xlsx)
library(magrittr)

# filename = "../data/fichier.xlsx"

insee_data = read_excel("famille_COM-EXT_08092022.xlsx",sheet     ="valeurs_mensuelles") %>% as.data.frame
insee_data = read.xlsx( "famille_COM-EXT_08092022.xlsx",sheetName ="valeurs_mensuelles")


# csv (read table et read csv)
# https://fr.finance.yahoo.com/quote/%5EFCHI/history/

cac40 = read.table("^FCHI.csv",sep = ",", dec = ".", header = T)
cac40 = read.csv("^FCHI.csv")




# importer via une api
  # https://opendata.agenceore.fr/explore/dataset/conso-elec-gaz-annuelle-par-secteur-dactivite-agregee-departement
library(jsonlite)
library(httr)
library(magrittr)

url = "https://opendata.agenceore.fr/api/records/1.0/search/?dataset=conso-elec-gaz-annuelle-par-secteur-dactivite-agregee-departement&q=&rows=10000&facet=annee&facet=code_departement&refine.filiere=Electricit%C3%A9"

elec_cons = httr::GET(url)
elec_cons = fromJSON(content(elec_cons,type="text"))$records$fields %>% as.data.frame
elec_cons = elec_cons[,c("code_departement","annee","consototale")]
elec_cons$code_departement = as.numeric(elec_cons$code_departement)
elec_cons = na.omit(elec_cons)





##########################################################################
#####                       LES SERIES TEMPORELLES
##########################################################################

# ts
df_ts = ts( df, start = 2000, frequency = 12)
time(df_ts)
index(df_ts)
window(df_ts, start = c(2005,1), end = c(2005,12) )

# xts
library(xts)

df_xts = as.xts(df_ts)
index(df_xts) = as.Date(index(df_xts))

df_xts["2005"]
df_xts["2005/2006"]
df_xts["/2005"]
df_xts["2005/"]

# les NAs
library(zoo)
library(timeDate)

timseq = timeSequence( from="2022-08-01", to=as.Date( format(Sys.time(), "%Y-%m-%d") ), by="day", format="%Y-%m-%d", FinCenter="GMT" )
timvec = xts( rep(NA,length(timseq)), as.Date(timseq) )
colnames(timvec) = "test"

timvec[10] = 10
timvec[20] = 20
timvec[30] = 30

na.fill(timvec,0)
na.approx(timvec, na.rm=F)
na.locf(timvec, fromLast = T)
na.locf(timvec, fromLast = F)


# changement de frequence
cac40 = as.xts(cac40[,-1], as.Date(cac40[,1]))

cac40 = apply.monthly(cac40$Close, mean)
index(cac40) = as.Date( format(index(cac40), "%Y-%m-01") )


cac40_m = apply.monthly(cac40,mean)
cac40_m_ts = ts(apply.monthly(cac40,mean), start = c(2021,9), frequency = 12)


# les lags
lag(cac40_m,1)
lag(cac40_m_ts,-1)

# TODO Creer une fonction qui lag une série en fonction de son type
# parametre : 1 - base
#             2 - valeur du lag(avec valeur par defaut)
#   Tester le type de "base", si pas series temp retourner NA












lag_custom <- function(x,nblag=1) {
  if( is.xts(x) ){
    res = lag(x,nblag)
  } else if ( is.ts(x) ) {
    res = lag(x,-nblag)
  } else {
    res=NA
  }
  return(res)
}
lag_custom(cac40_m,1)
lag_custom(cac40_m_ts,1)







##########################################################################
#####                       A VOUS DE JOUER
##########################################################################

# 1 : Telecharger les séries suivantes sur le net, quel que soit le moyen
# - cours du sp500
# - prix du Brent
# - euro dollars
# - US Treasuries 10 years
# - US CPI
# - US real gdp

# 2 : Calculer l'inflation et la croissance

# 3 : fusionner les données

# 4 : Gerer les valeurs manquantes

# 5 : calculer sur le sp500 
#     - return 1 et 3 mois
#     - volatilité 1 et 3 mois
#     - Indicateurs chartistes : macd, rsi, bande de bollinger

# 6 : calculer un indicateur de choc des 5% des pires baisses
# 6bis : lag de 21 jours sur cet indicateur pour creer une cible

# 7 : Fusionner tous ces indicateurs et enregistrer la base en .csv
 

library(quantmod)
sp500    = Cl(getSymbols( "^GSPC"       , src='yahoo', from="1980-01-01", auto.assign=F, warnings=F, methods="curl" ))
brent    =    getSymbols( "DCOILBRENTEU", src='FRED' , auto.assign=F, methods="curl")
usbond10 =    getSymbols( "DGS10"       , src='FRED' , auto.assign=F, methods="curl")
eurusd   =    getSymbols( "DEXUSEU"     , src='FRED' , auto.assign=F, methods="curl")
uscpi    =    getSymbols( "CPIAUCSL"    , src='FRED' , auto.assign=F, methods="curl")
usgdp    =    getSymbols( "GDPC1"       , src='FRED' , auto.assign=F, methods="curl")


usinfl   = (uscpi/lag_custom(uscpi,12)-1)*100
ustgdp   = (usgdp/lag_custom(usgdp,4)-1)*100


base = cbind(sp500, brent, usbond10, eurusd, usinfl, ustgdp)
colnames(base) = c("sp500", "brent", "usbond10", "eurusd", "usinfl", "ustgdp")


base[,c("usinfl","ustgdp")] = na.locf(base[,c("usinfl","ustgdp")], fromLast = F)

colnam = colnames(base)

library(TTR)
library(PerformanceAnalytics)

ret = (sp500/lag_custom(sp500,1)-1)*100

ret1m = rollapply( ret, 21, mean, align="right" )
ret3m = rollapply( ret, 63, mean, align="right" )
vol1m = rollapply( ret, 21, sd,   align="right" )
vol3m = rollapply( ret, 63, sd,   align="right" )

macd  = MACD(sp500, 12, 26, 9)[,"macd"]
rsi   = RSI(sp500)
bb    = BBands(sp500)[,'pctB']
bbw   = BBands(sp500)[,'up'] - BBands(sp500)[,'dn']


base = cbind(base, macd, rsi, bb, bbw, vol1m, vol3m, ret1m, ret3m)
colnames(base) = c(colnam, "macd", "rsi", "bb", "bbw", "vol1m", "vol3m", "ret1m", "ret3m")
colnam = colnames(base)

q_005 = quantile( ret1m, 0.05, na.rm=T )
choc = ( ret1m <= q_005 ) * 1
target = lag_custom(choc, -21)

plot.zoo(ret1m)
abline(h=q_005,col="red")

base = cbind(base, choc, target)
colnames(base) = c(colnam, "choc", "target")

base_df = data.frame( date = index(base)
                    , base             )
write.table(base_df, "base.csv", sep=",", dec = ".", row.names = F)



# Pour aller plus loin : le package PerformanceAnalytics
library(PerformanceAnalytics)
perf_custom <- function(indice){
  ret_tmp   = PerformanceAnalytics::Return.calculate(indice, method="discrete")
  
  reta_tmp  = round(PerformanceAnalytics::Return.annualized(ret_tmp, geometric=T)*100, 1)
  sda_tmp   = round(PerformanceAnalytics::sd.annualized(ret_tmp)*100, 1)
  mdd_tmp   = round(PerformanceAnalytics::maxDrawdown(ret_tmp)*100, 1)
  sharp_tmp = round(PerformanceAnalytics::SharpeRatio.annualized(ret_tmp, geometric=T), 1)
  
  xx = rbind(reta_tmp, sda_tmp, mdd_tmp, sharp_tmp)
  
  xx
}


perf_custom(sp500)