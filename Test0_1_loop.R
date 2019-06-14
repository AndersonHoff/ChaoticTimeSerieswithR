## Rotina para execução do Teste 0-1 em conjunto de séries temporais ##

## Para executar digite no terminal (na pasta com os dados): Rscript Test0_1_loop.R

## Verificar ##
# malha
# parâmetros horizontal e vertical
# coluna
# linha inicial e oversampling
# parâmetro de amortecimento
# nome de saída

# após gerar o arquivo, é necessário acrescentar # na primeira linha e localizar 
# todos os 'nada' e substituir por espaço em branco
##########################################

.onUnload <- function (libpath) {
  #' @keywords internal
  library.dynam.unload("Chaos01", libpath)}

.onUnload <- function (libpath) {
  #' @keywords internal
  library.dynam.unload("dplyr", libpath)}

library("Chaos01")

library("dplyr")

## Loop ##

fileNames <- Sys.glob("*.txt")

# Malha do plano de parâmetros #
malha <- 200

# Parâmetro horizontal #
amin <- 0.0
amax <- 1.0
passoa <- (amax - amin)/(malha-1)

# Parâmetro vertical #
bmin <- 0.0
bmax <- 1.0
passob <- (bmax - bmin)/(malha-1)

coluna <- 1 # coluna do arquivo a ser analisada #

#################################
n <- 1
m <- 0
a <- amin
b <- bmin
cc <- 'nada'
output <- data.frame(n, name = NA, a = NA, b = NA, res = NA)

for (file in fileNames) {

	# load do arquivo #

	name <- substr(x = file, start = 6, stop = 14)

	serie <- read.table(file, header = FALSE, quote="\"", comment.char="#")

	dados <- select(serie,coluna) 

	###################################
	# obter linhas específicas (oversampling)
	TS <- dados[seq(1, nrow(dados), 5),]	
	# neste caso, 1 é a linha inicial, a cada 5 linhas

	####################################

	TS <- unlist(TS)

	res<-testChaos01(TS, alpha = 0) # alpha é o parâmetro de amortecimento de ruído #

	if (m == malha){

#	print(m)

	a <- a + passoa

	b <- bmin

	output[n, ] <- c(cc,cc,cc,cc,cc)

	m <- 0
	
	n <- n+1
	}
	
	print(n)

	output[n, ] <- c(n, name, a, b, res)

	rm(name,dados,TS,res,file,serie)

	n <- n+1
	
	m <- m+1
	
	b <- b + passob

	}

# Seleciona nome do arquivo de saída #
write.table(output, file = 'dados40_2a0.dat', quote = FALSE, 
            sep = '\t', row.names = FALSE, col.names = TRUE)

rm(n,m,a, b, cc, amax, amin, bmax, bmin, malha, passoa, passob, fileNames,output)

##########################################
