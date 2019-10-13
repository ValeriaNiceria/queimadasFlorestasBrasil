rm(list=ls())

# Carregando os pacotes
library(shiny)
library(shinydashboardPlus)
library(tidyverse)
library(highcharter)

# Lendo os dados
dados <- read.csv("dados/amazon.csv", encoding = "latin1")
uf_state <- readRDS("dados/uf_state.rds")
