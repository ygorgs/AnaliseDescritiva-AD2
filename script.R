#Bibliotecas Usadas
library(ggplot2)
library(dplyr)
library(gmodels)

#Carregando dados
dados <- read.table("alunosUFCGAnon.csv", header=T, sep=",", dec=".", encoding="UTF-8")

#filtrando alunos
alunosTotal <- filter(dados, Situacao!="Trancado")
alunosReprovados <- filter(dados, Situacao!="Aprovado", Situacao!="Trancado")
creditosReprovados <- alunosReprovados$Creditos
creditosTotal <- alunosTotal$Creditos
countsReprovados <- data.frame(table(creditosReprovados))
countsTotal <- data.frame(table(creditosTotal))
countsTotal <- filter(countsTotal, creditosTotal %in% countsReprovados$creditosReprovados)
countsTotal$Reprovados <- countsReprovados$Freq/countsTotal$Freq
qplot(countsTotal$creditosTotal, countsTotal$Reprovados, xlab="Créditos da Disciplina", ylab = "Porcentagem de Reprovação")
cor(as.numeric(countsTotal$creditosTotal), countsTotal$Reprovados)

#filtrando alunos de computação
alunosPrimeiraEntrada <- filter(dados, substr(Periodo, 5,6)==".1")
alunosSegundaEntrada <- filter(dados, substr(Periodo, 5,6)==".2")
boxplot(alunosPrimeiraEntrada$Media_Disciplina, alunosSegundaEntrada$Media_Disciplina , names=c("Primeira Entrada","Segunda Entrada"), ylab="Médias")


