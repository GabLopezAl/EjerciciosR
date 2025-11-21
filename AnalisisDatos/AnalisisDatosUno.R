gvhdTib <- as_tibble(GvHD.pos)
gvhdTib
#Escalar nuestros datos
gvhdScaled <- gvhdTib %>% scale()
#Trazar lo datos
library(GGally)
ggpairs(GvHD.control,
upper = list(continuous = "density"),
lower = list(continuous = wrap("points", size = 0.5)),
diag = list(continuous = "densityDiag")) +
theme_bw()
#Definiendo nuestra tarea y aprendizaje
gvhdTask <- makeClusterTask(data = as.data.frame(gvhdScaled))
listLearners("cluster")$class
library(clue)
kMeans <- makeLearner("cluster.kmeans",
par.vals = list(iter.max = 100, nstart = 10))
#Ajuste de k y elección del algoritmo para nuestro modelo de k-medias
kMeansParamSpace <- makeParamSet(
makeDiscreteParam("centers", values = 3:8),
makeDiscreteParam("algorithm",
values = c("Hartigan-Wong", "Lloyd", "MacQueen")))
gridSearch <- makeTuneControlGrid()
kFold <- makeResampleDesc("CV", iters = 10)
#Realizar el ajuste
library(clusterSim)
tunedK <- tuneParams(kMeans, task = gvhdTask,
resampling = kFold,
par.set = kMeansParamSpace,
control = gridSearch,
measures = list(db, G1))
#Ver informacion de las metricas de rendimiento
kMeansTuningData <- generateHyperParsEffectData(tunedK)
kMeansTuningData$data
gatheredTuningData <- gather(kMeansTuningData$data,
key = "Metric",
value = "Value",
c(-centers, -iteration, -algorithm))
ggplot(gatheredTuningData, aes(centers, Value, col = algorithm)) +
facet_wrap(~ Metric, scales = "free_y") +
geom_line() +
geom_point() +
theme_bw()
#Entrenamiento del modelo k-means final y optimizado
tunedKMeans <- setHyperPars(kMeans, par.vals = tunedK$x)
tunedKMeansModel <- train(tunedKMeans, gvhdTask)
kMeansModelData <- getLearnerModel(tunedKMeansModel)
kMeansModelData$iter
#Mostrar los grupos con colores para visualizarlos de mejor manera
gvhdTib <- mutate(gvhdTib,
kMeansCluster = as.factor(kMeansModelData$cluster))
ggpairs(gvhdTib, aes(col = kMeansCluster),
upper = list(continuous = "density")) +
theme_bw()
#Predecir un nuevo caso y ver en que grupo pertecene
newCell <- tibble(CD4 = 510,
CD8b = 26,
CD3 = 500,
CD8 = 122) %>%
scale(center = attr(gvhdScaled, "scaled:center"),
scale = attr(gvhdScaled, "scaled:scale")) %>%
as_tibble()
predict(tunedKMeansModel, newdata = newCell)
#Predecir un nuevo caso y ver en que grupo pertecene
newCell <- tibble(CD4 = 300,
CD8b = 100,
CD3 = 365,
CD8 = 120) %>%
scale(center = attr(gvhdScaled, "scaled:center"),
scale = attr(gvhdScaled, "scaled:scale")) %>%
as_tibble()
predict(tunedKMeansModel, newdata = newCell)
save.image("C:\\Users\\DELL\\Documents\\GABRIEL\\6to_Semestre\\MineriaDatosDoc\\kmeansDataset2.R")
q()
save.image("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\AnálisisDatos")
myCSV <- read.csv("c31.csv",header=TRUE)
getwd(c31.csv)
getwd()
q()
load("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\.RData")
getwd()
library(tidyverse)
heart <- read_csv("heart.csv", col_types = "nffnnffnfnfnff")
glimpse(heart)
summary(heart)
view(heart)
set.seed(1234)
sample_set <- sample(nrow(heart), round(nrow(heart)*.75), replace = FALSE)
heart_train <- heart[sample_set, ]
heart_test <- heart[-sample_set, ]
round(prop.table(table(select(heart, heartDisease))),2)
round(prop.table(table(select(heart_train, heartDisease))),2)
round(prop.table(table(select(heart_test, heartDisease))),2)
library(e1071)
install.packages("e1071")
library(e1071)
heart_mod <- naiveBayes(heartDisease ~ ., data = heart_train, laplace = 1)
heart_mod
View(heart_mod)
heart_pred <- predict(heart_mod, heart_test, type = "class")
heart_pred_table <- table(heart_test$heartDisease, heart_pred)
heart_pred_table
sum(diag(heart_pred_table)) / nrow(heart_test)
library(tidyverse)
heart <- read_csv("heart.csv", col_types = "nffnnffnfnfnff")
glimpse(heart)
summary(heart)
set.seed(1234)
sample_set <- sample(nrow(heart), round(nrow(heart)*.80), replace = FALSE)
heart_train <- heart[sample_set, ]
heart_test <- heart[-sample_set, ]
round(prop.table(table(select(heart, heartDisease))),2)
round(prop.table(table(select(heart_train, heartDisease))),2)
round(prop.table(table(select(heart_test, heartDisease))),2)
library(e1071)
heart_mod <- naiveBayes(heartDisease ~ ., data = heart_train, laplace = 1)
heart_mod
heart_pred <- predict(heart_mod, heart_test, type = "class")
heart_pred_table <- table(heart_test$heartDisease, heart_pred)
heart_pred_table
sum(diag(heart_pred_table)) / nrow(heart_test)
plot(X="x-asis",y="y-asis",heart_pred_table)
plot(heart_pred_table)
plot(heart_pred)
save.image("~/GABRIEL/R/PRACTICAS/heart.RData")
library(readr)
Bank<-read_csv("UniversalBank.csv")
library(caTools)
set.seed(123)
split = sample.split(Bank$Online & Bank$CreditCard & Bank$`Personal Loan`, SplitRatio = 0.6)
training_set = subset(Bank, split == TRUE)
test_set = subset(Bank, split == FALSE)
View(training_set)
View(test_set)
dinamicTable<-table(training_set$CreditCard, training_set$Online,training_set$`Personal Loan`)
newNames <- c("CreditCard", "Personal Loan" , "Online", "Freq")
colnames(dinamicTable) <-newNames
dinamicTable
View(dinamicTable)
library(e1071)
data("Bank")
Bank_df = as.data.frame(Bank)
View(Bank_df)
#
#
#
data(Bank)
dinamicTable$Freq = NULL
Model_N_B = naiveBayes('Personal Loan' ~., data = dinamicTable)
View(dinamicTable)
View(dinamicTable)
View(test_set)
View(dinamicTable)
dinamicTable<-table(training_set$CreditCard, training_set$Online,training_set$`Personal Loan`)
probabilidadPersonalLoan <- dinamicTable[1,1,1] / sum(dinamicTable[1,,1])
probabilidadPersonalLoan
dinamicTable1<-table(training_set$`Personal Loan`, training_set$Online)
dinamicTable2<-table(training_set$`Personal Loan`, training_set$CreditCard)
View(dinamicTable1)
View(dinamicTable2)
View(dinamicTable1)
View(dinamicTable2)
probabilidadPersonalLoan <- dinamicTable[1,1,1] / sum(dinamicTable[1,1,])
probabilidadPersonalLoan
View(dinamicTable)
View(dinamicTable[1,1,1])
View(dinamicTable)
View(dinamicTable[1,1,1])
View(dinamicTable)
library(readr)
Bank<-read_csv("UniversalBank.csv")
View(Bank)
library(caTools)
set.seed(123)
split = sample.split(Bank$Online & Bank$CreditCard & Bank$`Personal Loan`, SplitRatio = 0.6)
training_set = subset(Bank, split == TRUE)
test_set = subset(Bank, split == FALSE)
View(training_set)
View(test_set)
dinamicTable<-table(training_set$CreditCard, training_set$Online,training_set$`Personal Loan`)
dinamicTable
View(dinamicTable)
probabilidadPersonalLoan <- dinamicTable[1,1,1] / sum(dinamicTable[1,1,])
probabilidadPersonalLoan
dinamicTable1<-table(training_set$`Personal Loan`, training_set$Online)
dinamicTable2<-table(training_set$`Personal Loan`, training_set$CreditCard)
View(dinamicTable1)
View(dinamicTable2)
save.image("C:\\Users\\DELL\\Documents\\GABRIEL\\R\\TareaNaïveBayes\\Tarea1")
q()
q()
q()
library(mlr)
library(tidyverse)
#Cargando y explorando el conjunto de datos GvHD
data(GvHD, package = "mclust")
gvhdTib <- as_tibble(GvHD.pos)
gvhdTib
#Escalar nuestros datos
gvhdScaled <- gvhdTib %>% scale()
#Trazar lo datos
library(GGally)
ggpairs(GvHD.control,
upper = list(continuous = "density"),
lower = list(continuous = wrap("points", size = 0.5)),
diag = list(continuous = "densityDiag")) +
theme_bw()
#Definiendo nuestra tarea y aprendizaje
gvhdTask <- makeClusterTask(data = as.data.frame(gvhdScaled))
listLearners("cluster")$class
library(clue)
kMeans <- makeLearner("cluster.kmeans",
par.vals = list(iter.max = 100, nstart = 10))
#Ajuste de k y elección del algoritmo para nuestro modelo de k-medias
kMeansParamSpace <- makeParamSet(
makeDiscreteParam("centers", values = 3:8),
makeDiscreteParam("algorithm",
values = c("Hartigan-Wong", "Lloyd", "MacQueen")))
gridSearch <- makeTuneControlGrid()
kFold <- makeResampleDesc("CV", iters = 10)
#Realizar el ajuste
library(clusterSim)
tunedK <- tuneParams(kMeans, task = gvhdTask,
resampling = kFold,
par.set = kMeansParamSpace,
control = gridSearch,
measures = list(db, G1))
#Ver informacion de las metricas de rendimiento
kMeansTuningData <- generateHyperParsEffectData(tunedK)
kMeansTuningData$data
gatheredTuningData <- gather(kMeansTuningData$data,
key = "Metric",
value = "Value",
c(-centers, -iteration, -algorithm))
ggplot(gatheredTuningData, aes(centers, Value, col = algorithm)) +
facet_wrap(~ Metric, scales = "free_y") +
geom_line() +
geom_point() +
theme_bw()
#Entrenamiento del modelo k-means final y optimizado
tunedKMeans <- setHyperPars(kMeans, par.vals = tunedK$x)
tunedKMeansModel <- train(tunedKMeans, gvhdTask)
kMeansModelData <- getLearnerModel(tunedKMeansModel)
kMeansModelData$iter
#Mostrar los grupos con colores para visualizarlos de mejor manera
gvhdTib <- mutate(gvhdTib,
kMeansCluster = as.factor(kMeansModelData$cluster))
ggpairs(gvhdTib, aes(col = kMeansCluster),
upper = list(continuous = "density")) +
theme_bw()
#Predecir un nuevo caso y ver en que grupo pertecene
newCell <- tibble(CD4 = 510,
CD8b = 26,
CD3 = 500,
CD8 = 122) %>%
scale(center = attr(gvhdScaled, "scaled:center"),
scale = attr(gvhdScaled, "scaled:scale")) %>%
as_tibble()
predict(tunedKMeansModel, newdata = newCell)
#Predecir un nuevo caso y ver en que grupo pertecene
newCell <- tibble(CD4 = 300,
CD8b = 100,
CD3 = 365,
CD8 = 120) %>%
scale(center = attr(gvhdScaled, "scaled:center"),
scale = attr(gvhdScaled, "scaled:scale")) %>%
as_tibble()
predict(tunedKMeansModel, newdata = newCell)
save.image("C:\\Users\\DELL\\Documents\\GABRIEL\\6to_Semestre\\MineriaDatosDoc\\kmeansDataset2.R")
q()
save.image("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\AnálisisDatos")
myCSV <- read.csv("c31.csv",header=TRUE)
getwd(c31.csv)
getwd()
q()
load("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\.RData")
library(tidyverse)
heart <- read_csv("heart.csv", col_types = "nffnnffnfnfnff")
glimpse(heart)
summary(heart)
view(heart)
set.seed(1234)
sample_set <- sample(nrow(heart), round(nrow(heart)*.75), replace = FALSE)
heart_train <- heart[sample_set, ]
heart_test <- heart[-sample_set, ]
round(prop.table(table(select(heart, heartDisease))),2)
round(prop.table(table(select(heart_train, heartDisease))),2)
round(prop.table(table(select(heart_test, heartDisease))),2)
library(e1071)
install.packages("e1071")
library(e1071)
heart_mod <- naiveBayes(heartDisease ~ ., data = heart_train, laplace = 1)
heart_mod
View(heart_mod)
heart_pred <- predict(heart_mod, heart_test, type = "class")
heart_pred_table <- table(heart_test$heartDisease, heart_pred)
heart_pred_table
sum(diag(heart_pred_table)) / nrow(heart_test)
library(tidyverse)
heart <- read_csv("heart.csv", col_types = "nffnnffnfnfnff")
glimpse(heart)
summary(heart)
set.seed(1234)
sample_set <- sample(nrow(heart), round(nrow(heart)*.80), replace = FALSE)
heart_train <- heart[sample_set, ]
heart_test <- heart[-sample_set, ]
round(prop.table(table(select(heart, heartDisease))),2)
round(prop.table(table(select(heart_train, heartDisease))),2)
round(prop.table(table(select(heart_test, heartDisease))),2)
library(e1071)
heart_mod <- naiveBayes(heartDisease ~ ., data = heart_train, laplace = 1)
heart_mod
heart_pred <- predict(heart_mod, heart_test, type = "class")
heart_pred_table <- table(heart_test$heartDisease, heart_pred)
heart_pred_table
sum(diag(heart_pred_table)) / nrow(heart_test)
plot(X="x-asis",y="y-asis",heart_pred_table)
plot(heart_pred_table)
plot(heart_pred)
save.image("~/GABRIEL/R/PRACTICAS/heart.RData")
library(readr)
Bank<-read_csv("UniversalBank.csv")
library(caTools)
set.seed(123)
split = sample.split(Bank$Online & Bank$CreditCard & Bank$`Personal Loan`, SplitRatio = 0.6)
training_set = subset(Bank, split == TRUE)
test_set = subset(Bank, split == FALSE)
View(training_set)
View(test_set)
dinamicTable<-table(training_set$CreditCard, training_set$Online,training_set$`Personal Loan`)
newNames <- c("CreditCard", "Personal Loan" , "Online", "Freq")
colnames(dinamicTable) <-newNames
dinamicTable
View(dinamicTable)
library(e1071)
data("Bank")
Bank_df = as.data.frame(Bank)
View(Bank_df)
#
#
#
data(Bank)
dinamicTable$Freq = NULL
Model_N_B = naiveBayes('Personal Loan' ~., data = dinamicTable)
View(dinamicTable)
View(dinamicTable)
View(test_set)
View(dinamicTable)
dinamicTable<-table(training_set$CreditCard, training_set$Online,training_set$`Personal Loan`)
probabilidadPersonalLoan <- dinamicTable[1,1,1] / sum(dinamicTable[1,,1])
probabilidadPersonalLoan
dinamicTable1<-table(training_set$`Personal Loan`, training_set$Online)
dinamicTable2<-table(training_set$`Personal Loan`, training_set$CreditCard)
View(dinamicTable1)
View(dinamicTable2)
View(dinamicTable1)
View(dinamicTable2)
probabilidadPersonalLoan <- dinamicTable[1,1,1] / sum(dinamicTable[1,1,])
probabilidadPersonalLoan
View(dinamicTable)
View(dinamicTable[1,1,1])
View(dinamicTable)
View(dinamicTable[1,1,1])
View(dinamicTable)
library(readr)
Bank<-read_csv("UniversalBank.csv")
View(Bank)
library(caTools)
set.seed(123)
split = sample.split(Bank$Online & Bank$CreditCard & Bank$`Personal Loan`, SplitRatio = 0.6)
training_set = subset(Bank, split == TRUE)
test_set = subset(Bank, split == FALSE)
View(training_set)
View(test_set)
dinamicTable<-table(training_set$CreditCard, training_set$Online,training_set$`Personal Loan`)
dinamicTable
View(dinamicTable)
probabilidadPersonalLoan <- dinamicTable[1,1,1] / sum(dinamicTable[1,1,])
probabilidadPersonalLoan
dinamicTable1<-table(training_set$`Personal Loan`, training_set$Online)
dinamicTable2<-table(training_set$`Personal Loan`, training_set$CreditCard)
View(dinamicTable1)
View(dinamicTable2)
save.image("C:\\Users\\DELL\\Documents\\GABRIEL\\R\\TareaNaïveBayes\\Tarea1")
q()
q()
q()
library(mlr)
library(tidyverse)
#Cargando y explorando el conjunto de datos GvHD
data(GvHD, package = "mclust")
gvhdTib <- as_tibble(GvHD.pos)
gvhdTib
#Escalar nuestros datos
gvhdScaled <- gvhdTib %>% scale()
#Trazar lo datos
library(GGally)
ggpairs(GvHD.control,
upper = list(continuous = "density"),
lower = list(continuous = wrap("points", size = 0.5)),
diag = list(continuous = "densityDiag")) +
theme_bw()
#Definiendo nuestra tarea y aprendizaje
gvhdTask <- makeClusterTask(data = as.data.frame(gvhdScaled))
listLearners("cluster")$class
library(clue)
kMeans <- makeLearner("cluster.kmeans",
par.vals = list(iter.max = 100, nstart = 10))
#Ajuste de k y elección del algoritmo para nuestro modelo de k-medias
kMeansParamSpace <- makeParamSet(
makeDiscreteParam("centers", values = 3:8),
makeDiscreteParam("algorithm",
values = c("Hartigan-Wong", "Lloyd", "MacQueen")))
gridSearch <- makeTuneControlGrid()
kFold <- makeResampleDesc("CV", iters = 10)
#Realizar el ajuste
library(clusterSim)
tunedK <- tuneParams(kMeans, task = gvhdTask,
resampling = kFold,
par.set = kMeansParamSpace,
control = gridSearch,
measures = list(db, G1))
#Ver informacion de las metricas de rendimiento
kMeansTuningData <- generateHyperParsEffectData(tunedK)
kMeansTuningData$data
gatheredTuningData <- gather(kMeansTuningData$data,
key = "Metric",
value = "Value",
c(-centers, -iteration, -algorithm))
ggplot(gatheredTuningData, aes(centers, Value, col = algorithm)) +
facet_wrap(~ Metric, scales = "free_y") +
geom_line() +
geom_point() +
theme_bw()
#Entrenamiento del modelo k-means final y optimizado
tunedKMeans <- setHyperPars(kMeans, par.vals = tunedK$x)
tunedKMeansModel <- train(tunedKMeans, gvhdTask)
kMeansModelData <- getLearnerModel(tunedKMeansModel)
kMeansModelData$iter
#Mostrar los grupos con colores para visualizarlos de mejor manera
gvhdTib <- mutate(gvhdTib,
kMeansCluster = as.factor(kMeansModelData$cluster))
ggpairs(gvhdTib, aes(col = kMeansCluster),
upper = list(continuous = "density")) +
theme_bw()
#Predecir un nuevo caso y ver en que grupo pertecene
newCell <- tibble(CD4 = 510,
CD8b = 26,
CD3 = 500,
CD8 = 122) %>%
scale(center = attr(gvhdScaled, "scaled:center"),
scale = attr(gvhdScaled, "scaled:scale")) %>%
as_tibble()
predict(tunedKMeansModel, newdata = newCell)
#Predecir un nuevo caso y ver en que grupo pertecene
newCell <- tibble(CD4 = 300,
CD8b = 100,
CD3 = 365,
CD8 = 120) %>%
scale(center = attr(gvhdScaled, "scaled:center"),
scale = attr(gvhdScaled, "scaled:scale")) %>%
as_tibble()
predict(tunedKMeansModel, newdata = newCell)
save.image("C:\\Users\\DELL\\Documents\\GABRIEL\\6to_Semestre\\MineriaDatosDoc\\kmeansDataset2.R")
q()
save.image("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\AnálisisDatos")
myCSV <- read.csv("c31.csv",header=TRUE)
getwd(c31.csv)
getwd()
q()
load("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\.RData")
q()
clean
clear
getwd()
setwd("C:/Users/DELL/Documents/SERVICIO_SOCIAL/EjemplosEjercicios")
getwd()
myCSV<-read.csv("c31.csv",header=TRUE)
str(myCSV)
View(myCSV)
myTable<-read.table("c31.txt",sep="\t",header="TRUE")
myTable<-read.table("c311.txt",sep="\t",header="TRUE")
myTable<-read.table("c311.txt",sep="\t",header=TRUE)
str(myTable)
View(myTable)
library(readxl)
myXLS<-read_excel("c311Lot1.xsl",sheet="LOT")
myXLS<-read_excel("c311Lot.xsl",sheet="LOT")
myXLS<-read_excel("c311Lot1.xls",sheet="LOT")
str(myXLS)
View(myXLS)
library(xlsx)
myxlsx<-"c311Lot.xlsx"
myxlsxdata<-read.xlsx(myxlsx,1)
>data<-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-
>data<-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv",sep=";")
data<-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv",sep=";")
summary(data)
data=read.table(file="http://www.sthda.com/upload/decathlon.txt",
header=T, row.names=1, sep="\t")
print(data)
save.image("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\AnalisisDatosEjemploUno")




save.image("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\AnalisisDatosUno.R")


source("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\AnalisisDatosEjemplo.R")
local({fn<-choose.files(filters=Filters[c('R','txt','All'),],index=4)
file.show(fn,header=fn,title='')})
