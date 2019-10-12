sidebar = shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(
    shinydashboard::menuItem(
      text = "Home",
      icon = icon("home"),
      tabName = "tab_home"
    ),
    shinydashboard::menuItem(
      text = "Análise Exploratória",
      icon = icon("chart-line"),
      tabName = "tab_exploratoria"
    )
  )
)