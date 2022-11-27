
################################################################
# Partie 1 : Manipulation generales
################################################################

#### Les boucles, conditions, fonctions
# ----------------------------------------------------------

# Generer 50 fois un nombre aleatoire compris entre 1 et 10
# Si la valeur arrondie vaut 7, en afficher la valeur via un print


# En faire une function avec en parametre
# 1 - le bombre de boucle
# 2 - la valeur à afficher, par defaut 7


#### Les data frame
# ----------------------------------------------------------

# Creer un data frame avec 5 colonnes 'col1' ... 'col5'
# Et 100 lignes avec des valeurs aléatoires
# Fixer l'aleatoire avec de generer les dataframe


# Afficher les noms de lignes et des colonnes
# Renommer les lignes en row1 ... row100
# Ajouter une colonne 'mean' avec la moyenne des lignes
# Ajouter 1 ligne avec la moyenne des colonnes

#### Les series temporelles (ts/xts)
# ----------------------------------------------------------
# Transformer ce data frame en ts 
# débutant en 1950 avec une frequence trimestrielle



# Transforer ce ts en xts


#### Lecture et manipulation de series temporelles
# https://github.com/dliron
# ----------------------------------------------------------

# Importer les fichier .csv sp500, usbond10, uscpi, usgdp depuis data/

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











