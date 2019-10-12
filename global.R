rm(list=ls())

# Carregando os pacotes
library(shiny)
library(shinydashboardPlus)

# Lendo os dados
dados <- read.csv("dados/amazon.csv", encoding = "latin1")