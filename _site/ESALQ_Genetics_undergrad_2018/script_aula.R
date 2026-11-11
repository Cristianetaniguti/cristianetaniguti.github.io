# Isto é um script de R
# <- é usado para fazer comentários
###################################
# Aula dos monitores
# 23 de novembro de 2017
###################################

# Exemplos de aplicação do R 

# 4ª Aula prática - Segregação Indepêndente

# Folhas normais (dominante) e batata 
# Flores amarelas(dominante) e brancas

# Contagens

# Modo longo
contagens <- c(190, 61,52,17)
names(contagens) <- c("normais_amarelas", "normais_brancas", "batata_amarelas", "batata_brancas") 
(freq_esperada <- c(sum(contagens)*9/16, sum(contagens)*3/16, sum(contagens)*3/16, sum(contagens)*1/16))
(desvio <- contagens - freq_esperada)
(qui_quadrado <- (desvio^2)/freq_esperada)
qui_quadrado_total <- sum(qui_quadrado)
qui_quadrado_total

# Modo curto
qui_quadrado_total <- chisq.test(c(190, 61,52,17), p=c(9/16,3/16,3/16,1/16))
qui_quadrado_total
# Consultando tabela

valor_tab <- qchisq(0.05, df = 3, lower.tail = FALSE)

qui_quadrado_total$statistic > valor_tab # Não rejeitamos H0


# Mapas genéticos

# Exercício 2 da 6ª aula

# Ao invés trabalharmos com 3 genes, vamos trabalhar com 67 (O.O)

library(onemap)
data("mapmaker_example_bc")
mapmaker_example_bc

# Podemos fazer um teste de segregação para cada gene

segreg <- test_segregation(mapmaker_example_bc)
print(segreg)

# Calculamos as frações de recombinação

frac.rec <- rf_2pts(mapmaker_example_bc)

# Identificamos quais marcadores estão ligado

seq_tot <- make_seq(frac.rec, "all")
LGs <- group(seq_tot)
LGs

# Identificamos a ordem deles

# Grupo 1
LG1 <- make_seq(LGs, 1)

ord1_LG1 <- order_seq(LG1)
ord_LG1 <- make_seq(ord1_LG1, "force")


# Grupo 2
LG2 <- make_seq(LGs, 2)

ord1_LG2 <- order_seq(LG2)
ord_LG2 <- make_seq(ord1_LG2, "force")


# Grupo 3
LG3 <- make_seq(LGs, 3)

ord1_LG3 <- order_seq(LG3)
ord_LG3 <- make_seq(ord1_LG3, "force")

draw_map(list(ord_LG1,ord_LG2,ord_LG3))

# 9ª Aula Prática 
# Exercício 1

# Leitura dos dados

P1 <- c(38,38.5,38.5,39,39.5,40,41,41.5,42,42.5)
P2 <- c(7.5,9,9.5,9.5,10,10.5,10.5,11,12,12.5,13)
F1 <- c(24.5,26,26,27,27,27.5,27,28,28,28)
F2 <- c(10,10.5,11,11.6,12,12.5,12.8,14,15.2,15.5,16,16.6,17,17.5,17.5,18,18.2,19.6,19.8,20.2,20.5,20.5,20.5,20.7,20.8,20.9,21.2,21.3,22,22.1,
        22.4,22.5,22.9,23.1,23.2,23.4,23.5,23.5,24,24,24,24,24.2,24.3,24.5,24.5,24.5,24.7,24.7,24.8,25,25.5,25.7,25.8,26.1,26.5,27,27,27,27.8,
        27.8,28,28.2,28.3,28.5,29,29.1,29.2,29.5,29.9,30,30,30.2,31.7,34,35,35.5,36.3,38.5,40)

# Ou

P1 <- read.csv("P1.csv")
P2 <- read.csv("P2.csv")
F1 <- read.csv("F1.csv")
F2 <- read.csv("F2.csv")

#b)

medias <- c(mean(P1$Altura..cm.), mean(P2$Altura..cm.), mean(F1$Altura..cm.),mean(F2$Altura..cm.))
variancias <- c(var(P1$Altura..cm.), var(P2$Altura..cm.), var(F1$Altura..cm.),var(F2$Altura..cm.))

var_ambF2 <- mean(variancias[1:3])
var_genF2 <- variancias[4] - var_ambF2

tabela <- data.frame(pop = c("P1", "P2", "F1", "F2"), medias, variancias, vargem = c(rep(0,3), var_genF2),
                     var_amb=c(variancias[1:3], var_ambF2))
tabela

(herdabilidade <- var_genF2/variancias[4])

#c)

(ordenado <- sort(F2$Altura..cm.,decreasing = TRUE))
(Xs <- mean(ordenado[1:20]))
(ds <- Xs - mean(F2$Altura..cm.))
(GS <- herdabilidade*ds)
