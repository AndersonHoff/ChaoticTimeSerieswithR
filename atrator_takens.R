## Rotina reconstrução atrator com delay ##### These scripts are in Portuguese ##

## Abre e executa o arquivo na pasta com os dados ##

## Para executar, digite no terminal: Rscript atrator_takens.R ##

library("dplyr")

# Especifique o local para carregar o arquivo com a série temporal #

atrator <- read.table("atrator.dat", quote="\"", comment.char="")

# Parâmetros de análise #

coluna <- 3 # coluna do arquivo a ser analisada #

delay <- 10 #delay do atrator

##########################

dados <- select(atrator,coluna) 

dados2 <- select(atrator,coluna) 

dados2[nrow(dados2)+delay,] <- NA

dados2 <- dados2[seq(delay+1, nrow(dados2), 1),]

takens <- data.frame(dados, dados2)

###########################

# Nomeia arquivo de saída #

jpeg("atrator10.jpeg")
plot(takens, type = "l", main = c("coluna", coluna, "delay", delay))
dev.off()

rm(atrator, dados, dados2, takens, coluna, delay)

##  Rotina para plotar atrator original   ##

# Insere endereço dos dados (mesmo do superor) #
# Para não gerar sempre esta imagem, comente (#) as linhas abaixo #

atrator <- read.table("atrator.dat", quote="\"", comment.char="")

# Seleciona colunas (no caso V1 e V2 são coluna 1 e 2) #

takens <- data.frame(atrator$V1, atrator$V2)

# Nomeia arquivo de saída #

jpeg("atrator.jpeg")
plot(takens, type = "l", main = 'atrator_original')
dev.off()

##########################################################

