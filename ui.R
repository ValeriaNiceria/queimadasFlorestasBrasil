source("./ui/header.R")
source("./ui/sidebar.R")
source("./ui/body.R")


ui <- dashboardPagePlus(
  title = "Queimadas nas Florestas",
  header,
  sidebar,
  body,
  
  rightsidebar = shinydashboardPlus::rightSidebar(
    background = "dark",
    rightSidebarTabContent(
      id = 1,
      title = "Tipo de plot",
      icon = "chart-pie",
      active = TRUE,
      p(style="font-style: italic", "Escolha um pacote para criação dos gráficos."),
      selectInput(
        inputId = "select_tipo_plot",
        label = "Pacote:",
        choices = c("highcharter", "ggplot2 + plotly"),
        selected = "highcharter"
      )
    )
  )
)