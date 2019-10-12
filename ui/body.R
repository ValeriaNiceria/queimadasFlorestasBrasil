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
          width = 12,
          title = "Total de queimadas por ano",
          uiOutput("ui_graf_queimadas_anos")
        )
      ),
      fluidRow(
        shinydashboardPlus::boxPlus(
          width = 12,
          title = "Queimadas durante o ano",
          fluidRow(
            style="margin-top: -30px;",
            column(2, selectInput(
              inputId = "select_ano_queimada",
              label = "",
              choices = sort(unique(dados$year), decreasing = TRUE)
            ))
          ),
          fluidRow(uiOutput("ui_graf_queimadas_ano_selected"))
        )
      )
    )
  )
)
