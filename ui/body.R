body = shinydashboard::dashboardBody(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="css/style.css")
  ),
  tags$script(
    HTML('
      $(document).ready(function() {
        $("body").addClass("sidebar-collapse");
      })
    ')
  ),
  
    shinydashboard::tabItems(
      shinydashboard::tabItem(
        tabName = "tab_home",
        img(
          class="img-home",
          src = "img/banner.png"
        )
      ),
      shinydashboard::tabItem(
        tabName = "tab_exploratoria",
        fluidRow(
          shinydashboardPlus::boxPlus(
            width = 6,
            title = "Total de queimadas por ano",
            fluidRow(
              highchartOutput('graf_queimadas_anos')
            ) 
          ),
          shinydashboardPlus::boxPlus(
            width = 6,
            title = "Queimadas durante o ano",
            fluidRow(
              fluidRow(
                style="margin-top: -30px;",
                column(12, 
                       column(width = 3, selectInput(
                         inputId = "select_ano_queimada",
                         label = "",
                         choices = sort(unique(dados$year), decreasing = TRUE)
                       ))
                       )
              ),
              highchartOutput('graf_queimadas_ano_selected')
            ) 
          )
        ),
        fluidRow(
          shinydashboardPlus::boxPlus(
            width = 12,
            title = "Queimadas por estado",
            fluidRow(
              style="margin-top: -30px;",
              column(2, selectInput(
                inputId = "select_ano_queimada_estado",
                label = "",
                choices = c("Geral", sort(unique(dados$year), decreasing = TRUE))
              ))
            ),
            fluidRow(
              column(5, highchartOutput('graf_map_queimadas_totais')),
              column(7, highchartOutput('graf_queimadas_estado_ano_selected'))
          ),
          
          fluidRow(column(12, hr())),
          
          fluidRow(
            column(width = 12,
                   column(3,
                          selectInput(
                            inputId = "select_estado",
                            label = "Selecione um estado:",
                            choices = as.character(unique(dados$state)) )
                          ),
                   column(3,
                          selectInput(
                            inputId = "select_estado_ano",
                            label = "Selecione um ano:",
                            choices = c("Todos os anos", sort(unique(dados$year), decreasing = TRUE)) )
                   )
                  ),
            highchartOutput('graf_estado_ano_queimadas')
          )
        )
      )
    )
  )
)
